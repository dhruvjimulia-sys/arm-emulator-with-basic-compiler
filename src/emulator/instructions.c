#include "instructions.h"
#include "type_definitions.h"
#include "emulator_utils.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <limits.h>

#define GPIO_START 0x20200000
#define GPIO_END 0x20200008
#define GPIO_CLEAR 0x20200028
#define GPIO_ON 0X2020001c

int32_t shift(uint32_t n, uint32_t shift_type, uint32_t shift_amount,
			bool set_cpsr, uint32_t *cpsr_reg) {
	uint32_t cout = shift_amount != 0 ? create_mask(0, shift_amount - 1, &n) : 0;
	int result = 0;

	switch(shift_type) {
		case 0: /* lsl */
			cout = shift_amount != 0 ? create_mask(BITS_PER_INSTRUCTION - shift_amount, BITS_PER_INSTRUCTION - 1, &n) : 0;
			result = n << shift_amount;
			break;
		case 1: /* lsr */
			result = n >> shift_amount;
			break;
		case 2: /* asr */
			result = ((int) n) >> shift_amount;
			break;
		case 3: /* ror */
			result = rotate_right(n, shift_amount);
			break;
		default:
			printf("Invalid shift type.\n");
			return EXIT_FAILURE;
	}

	//set C condition code to carry out from the shifter
	if (set_cpsr) {
		set_c(cpsr_reg, cout);
	}

	return result;
}

uint32_t shift_rm_register(uint32_t *instr, struct Processor* processor, bool set_cpsr) {
	uint32_t rm = create_mask(0, 3, instr);
	//for the optional part where shift is specified by rs register
	bool bit4 = extract_bit(4, instr); 
	uint32_t shift_type = create_mask(5, 6, instr);
	uint32_t shift_amount;
	uint32_t *cpsr_reg = &processor->registers[CPSR_REGISTER];

	if (bit4) {
		//shift amount is specified by rs
		int rs = create_mask(8, 11, instr);
		shift_amount = processor->registers[rs] & 0xff;
	} else {
		//shift amount is a constant amount
		shift_amount = create_mask(7, 11, instr);
	}

	return shift(processor->registers[rm], shift_type, shift_amount, set_cpsr, cpsr_reg);
}

void execute_data_processing_instruction(struct Processor* processor, uint32_t *instr) {
	uint32_t opcode = create_mask(21, 24, instr);
	bool set_cpsr = extract_bit(20, instr);
	uint32_t rm_val = create_mask(0, 11, instr);
	int32_t op2;
	int32_t result;
	uint32_t *dest = &(processor->registers[create_mask(12, 15, instr)]);
	uint32_t rn_val = processor->registers[create_mask(16, 19, instr)];
	uint32_t *cpsr_reg = &(processor->registers[CPSR_REGISTER]);

	if (extract_bit(25, instr)) {
		/* operand2 is an immediate constant */
		rm_val = create_mask(0, 7, instr);
		//get rotation value
		uint32_t rot_val = 2 * create_mask(8, 11, instr);
		op2 = rotate_right(rm_val, rot_val);
	} else {
		/* operand is shifted register */
		op2 = shift_rm_register(instr, processor, set_cpsr);
	}

	uint32_t op2_unsigned = op2;

	switch(opcode) {
		case 0: /* and, rn AND Operand2 */
			*dest = rn_val & op2;
			result = *dest;
			break;
		case 1: /* eor, rn EOR Operand2 */
			*dest = rn_val ^ op2;
			result = *dest;
			break;
		case 2: /* sub, rn - operand2 */
			*dest = rn_val -op2;
			result = *dest;

			if (set_cpsr) {
				//set C flag if subtraction produced a borrow
				set_c(cpsr_reg,rn_val >= op2_unsigned);
			}
			break;
		case 3: /* rsub, reverse sub, operand2 - rn */
			*dest = op2 - (rn_val);
			result = *dest;
			if (set_cpsr) {
				//set C flag if subtraction produced a borrow
				set_c(cpsr_reg,rn_val <= op2);
			}
			break;
		case 4: /* add, rn + operan2 */
			*dest = rn_val + op2;
			result = *dest;

			if(set_cpsr) {
				//set C flag if unsigned overflow occurs
  				set_c(cpsr_reg,(rn_val + op2_unsigned) < rn_val);
			}
			break;
		case 8: /* tst, and (but result is not written) */
			result = rn_val & op2;
			set_c(cpsr_reg, 0);
			break;
		case 9: /* teq, eor (but result is not written) */
			result = rn_val ^ op2;
			break;
		case 10: /* cmp, sub (but result is not written) */
			result = rn_val - op2;

			if (set_cpsr) {
				//set C flag if subtraction produced a borrow
				set_c(cpsr_reg,rn_val >= op2_unsigned);
			}
			break;
		case 12: /* orr, rn OR operand2 */
			result = rn_val | op2;
			*dest = result;
			break;
		case 13: /* mov, operand2 is moved, Rn is ignored */
			*dest = op2;
			result = *dest;
			break;
		default:
			printf("Invalid opcode %d for data processing instruction.\n", opcode);
	}

	if (set_cpsr) {	
		set_z(cpsr_reg, result);
		set_n(cpsr_reg, result);
	}
}

bool execute_branch_instruction(struct Processor* processor, uint32_t *instr) {
	uint32_t first4bits = create_mask(28, 31, instr);
	if (condition_check(first4bits, processor)) {
		int32_t offset = (int32_t) sign_extend((create_mask(0, 23, instr)) << 2, 26);
		processor->registers[PC_REGISTER] += offset;
		return true;
	}
	return false;
}

void execute_multiply_instruction(struct Processor* processor, uint32_t *instr) {
	uint32_t rm_val = processor->registers[create_mask(0, 3, instr)];
	uint32_t rs_val = processor->registers[create_mask(8, 11, instr)];
	uint32_t rn_val = processor->registers[create_mask(12, 15, instr)];
	uint32_t *cpsr_reg = &processor->registers[CPSR_REGISTER];
	bool set_cpsr = extract_bit(20, instr);

	uint32_t product = rm_val * rs_val;

	bool acc_cond_bit = extract_bit(21, instr);

	//truncate product (multiply instruction result) to 32 bits

	if (acc_cond_bit) {
		product += rn_val;
    }


	processor->registers[create_mask(16, 19, instr)] = product;

	//set condition codes
	if (set_cpsr) {
		set_z(cpsr_reg, product);
		set_n(cpsr_reg, product);
	}
}



void execute_single_data_transfer(struct Processor* processor, uint32_t *instr) {
	bool p_bit = extract_bit(24, instr);
	bool u_bit = extract_bit(23, instr);
	bool l_bit = extract_bit(20, instr);
	bool i_bit = extract_bit(25, instr);
	uint32_t offset = create_mask(0, 11, instr);
	int rd_index = create_mask(12, 15, instr);
	int rn_index = create_mask(16, 19, instr);
	uint32_t *dest = &processor->registers[rd_index];
	uint32_t* base_reg = &processor->registers[rn_index];

	if (i_bit) {
		// offset interpreted as a shifted register
		offset = shift_rm_register(instr, processor, 0);
	}

	int32_t net_offset = !p_bit ? 0 : (u_bit ? offset : -offset);

	uint32_t mem_location = *base_reg + net_offset;
	if (mem_location >= GPIO_START && mem_location <= GPIO_END) {
		uint32_t diff = mem_location - GPIO_START;
		assert(diff % 4 == 0);
		uint32_t start = (diff / 4) * 10;
		uint32_t end = start + 9;
		*dest = mem_location;
		printf("One GPIO pin from %d to %d has been accessed\n", start, end);
	} else if (mem_location == GPIO_CLEAR) {
		printf("PIN OFF\n");
	} else if (mem_location == GPIO_ON) {
		printf("PIN ON\n");
	} else if (change_endianness(*base_reg + BYTES_PER_INSTRUCTION + net_offset, 0) < MEM_SIZE) {
		if (l_bit) {
			//ldr, load word from memory
			uint32_t reversed = 0;
			for (int i = BYTES_PER_INSTRUCTION; i >= 0; i--) {
				reversed += reverse_bits(processor->memory[change_endianness(*base_reg + i + net_offset, 0)], CHAR_BIT);
				if (i != 0) {
					reversed <<= CHAR_BIT;
				}
			}
			*dest = reversed;
		} else {
			//str, store word in memory
			for (int i = BYTES_PER_INSTRUCTION - 1; i >= 0; i--) {
				uint32_t pos = *base_reg + i + net_offset;
				processor->memory[change_endianness(change_endianness(pos, (net_offset + *base_reg) % 4), 0)] = create_mask(i * 8, (i + 1) * 8 - 1, dest);
			}
		}
	} else {
		printf("Error: Out of bounds memory access at address 0x%08x\n", *base_reg + net_offset);
	}

	if (!p_bit) {
		//post-indexing
		assert (rd_index != rn_index);
		if (u_bit) {
			*base_reg += offset;
		} else {
			*base_reg -= offset;
		}
	}
}

void print_basic(struct Processor *processor, uint32_t *instr) {
	bool is_string = extract_bit(22, instr);
	bool reg = extract_bit(21, instr);
	uint32_t start_address = create_mask(0, 20, instr);

	if (is_string) {
		uint32_t location = reg ? (processor->registers[start_address]) : start_address;
		char ch = reverse_bits(processor->memory[location], CHAR_BIT);
		int i = 1;
		while (ch != '\0') {
			printf("%c", ch);
			ch = reverse_bits(processor->memory[location + i], CHAR_BIT);
			i++;
		}
	}
	else {
		uint32_t location = reg ? *(processor->registers + start_address) : *(processor->memory + start_address);
		printf("%d", location);
	}
}

void input_basic(struct Processor *processor, uint32_t *instr) {
	bool is_string = extract_bit(22, instr);
	bool reg = extract_bit(21, instr);
	uint32_t start_address = create_mask(0, 20, instr);

	if (is_string) {
		if (reg) {
			uint32_t location = processor->registers[start_address];
			scanf("%s", &(processor->memory[location]));
		} else {
			scanf("%s", &(processor->memory[start_address]));
		}
	}
	else {
		if (reg) {
			scanf("%u", &(processor->registers[start_address]));
		} else {
			scanf("%hhu", &(processor->memory[start_address]));
		}
	}
	printf("\n");
}

