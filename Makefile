VERILOG := iverilog
WAVEGEN := vvp

TBS_DIR := ./testbenchs
SRC_DIR := ./src
OUTPUT_DIR := ./output

TEST_ADDER_TBS := $(TBS_DIR)/test_adder.v
TEST_ADDER_SRC := $(SRC_DIR)/adder.v
TEST_ADDER_INPUT := $(TEST_ADDER_TBS) $(TEST_ADDER_SRC)
TEST_ADDER_OUTPUT := test_adder

.PHONY: adder_test

adder_test:
	$(VERILOG) -o $(OUTPUT_DIR)/$(TEST_ADDER_OUTPUT) $(TEST_ADDER_INPUT)
	cd $(OUTPUT_DIR)/ && $(WAVEGEN) -n $(TEST_ADDER_OUTPUT) -lxt2