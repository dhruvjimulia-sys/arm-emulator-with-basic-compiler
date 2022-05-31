#include <stdlib.h>
#include <stdint.h>
#include <assert.h>
#include <stdbool.h>
#include "utils.h"

#ifndef INSTRUCTIONS_H
#define INSTRUCTIONS_H

void execute_data_processing_instruction(struct Processor processor, uint32_t *instr);

int shift_rm_register(uint32_t *instr, struct Processor processor, bool set_cpsr);

void execute_branch_instruction(uint32_t *instr);

int32_t shift(uint32_t n, unsigned int shift_type, unsigned int shift_amount,
			uint32_t set_cpsr, uint32_t *cpsr);

void execute_multiply_instruction(struct Processor processor, uint32_t *instr);

void execute_single_data_transfer(struct Processor processor, uint32_t *instr);

#endif
