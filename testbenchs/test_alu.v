`include "para.v"

module test_alu;
    reg [63:0]R0, R1;
    reg [3:0] MODE;

    wire [15:0] PSW;
    wire [63:0]S0, S1;

    ALU alu(.A (R0), .B (R1), .MODE (MODE), .S (S0), .S2(S1), .PSW (PSW));

    initial
    begin
        $dumpfile("test_alu.vcd");
        $dumpvars(0, test_alu);

        //0x20 + 0x30 - 0x40
        #10 R0 = 64'h20; R1 = 64'h30; MODE = `MODE_ADD;
        #10 R0 = S0; R1 = S1;
        #10 R1 = 64'h40; MODE = `MODE_SUB;
        #10 R0 = S0; R1 = S1;
        #10 $finish;
    end
endmodule