VERILOG := iverilog
WAVEGEN := vvp

TBS_DIR := ./testbenchs
SRC_DIR := ./src
OUTPUT_DIR := ./output

TEST_ALU_TBS := $(TBS_DIR)/test_alu.v
TEST_ALU_SRC := $(SRC_DIR)/alu.v
TEST_ALU_INPUT := $(TEST_ALU_TBS) $(TEST_ALU_SRC)
TEST_ALU_OUTPUT := test_alu

.PHONY: alu_test

alu_test:
	$(VERILOG) -I "src/" -o $(OUTPUT_DIR)/$(TEST_ALU_OUTPUT) $(TEST_ALU_INPUT)
	cd $(OUTPUT_DIR)/ && $(WAVEGEN) -n $(TEST_ALU_OUTPUT) -lxt2