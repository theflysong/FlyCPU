module test_adder;
    reg [63:0]A, B;
    reg Ci;
    reg [3:0] MODE;
    wire [63:0]S;
    wire Co;

    wire [15:0] PSW;

    parameter MODE_ADD = 4'b0000;
    parameter MODE_SUB = 4'b0001;
    parameter MODE_MUL = 4'b0010;
    parameter MODE_DIV = 4'b0011;
    parameter MODE_AND = 4'b0100;
    parameter MODE_OR  = 4'b0101;
    parameter MODE_XOR = 4'b0110;
    parameter MODE_NOT = 4'b0111;

    ALU alu(.A (A), .B (B), .MODE (MODE), .S (S), .PSW (PSW));

    initial
    begin
        $dumpfile("test_adder.vcd");
        $dumpvars(0, test_adder);

        #10 A = 64'h2000; B = 64'h2000; MODE = MODE_SUB;
        #10 A = 64'h4000; B = 64'h7000; MODE = MODE_SUB;
        #10 A = 64'h106000; B = 64'hA000; MODE = MODE_SUB;
        #10 A = 64'hFFFFFFFFFFFFFFFF; B = 64'h0002; MODE = MODE_ADD;
        #10 A = 64'b0101 ; B = 64'b0110; MODE = MODE_XOR;
        #10 A = 64'h0000FFFFF0000FFFF ; MODE = MODE_NOT;
        #10 $finish;
    end
endmodule