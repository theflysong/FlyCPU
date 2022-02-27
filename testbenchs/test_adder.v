module test_adder;
    reg [31:0]A, B;
    reg Ci;
    wire [31:0]S;
    wire Co;

    Adder32 adder(A, B, Ci, S, Co);

    initial
    begin
        $dumpfile("test_adder.vcd");
        $dumpvars(0, test_adder);

        #10 A = 32'h1000; B = 32'h2000; Ci = 0;
        #10 A = 32'h4000; B = 32'h7000; Ci = 0;
        #10 A = 32'h106000; B = 32'hA000; Ci = 0;
        #10 $finish;
    end
endmodule