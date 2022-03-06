`include "para.v"

module Adder(
    input A,
    input B,
    input Ci,
    output S,
    output G,
    output P);

    assign S = A ^ B ^ Ci;
    assign G = A & B;
    assign P = A | B;
endmodule

module CLA_8(
    input [7:0]P,
    input [7:0]G,
    input Ci,
    output [8:1]Co);

    assign Co[1] = G[0] |
                   (P[0] & Ci);
    assign Co[2] = G[1] |
                   (P[1] & G[0]) |
                   (P[1] & P[0] & Ci);
    assign Co[3] = G[2] |
                   (P[2] & G[1]) |
                   (P[2] & P[1] & G[0]) |
                   (P[2] & P[1] & P[0] & Ci);
    assign Co[4] = G[3] |
                   (P[3] & G[2]) |
                   (P[3] & P[2] & G[1]) |
                   (P[3] & P[2] & P[1] & G[0]) |
                   (P[3] & P[2] & P[1] & P[0] & Ci);
    assign Co[5] = G[4] |
                   (P[4] & G[3]) |
                   (P[4] & P[3] & G[2]) |
                   (P[4] & P[3] & P[2] & G[1]) |
                   (P[4] & P[3] & P[2] & P[1] & G[0]) |
                   (P[4] & P[3] & P[2] & P[1] & P[0] & Ci);
    assign Co[6] = G[5] |
                   (P[5] & G[4]) |
                   (P[5] & P[4] & G[3]) |
                   (P[5] & P[4] & P[3] & G[2]) |
                   (P[5] & P[4] & P[3] & P[2] & G[1]) |
                   (P[5] & P[4] & P[3] & P[2] & P[1] & G[0]) |
                   (P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & Ci);
    assign Co[7] = G[6] |
                   (P[6] & G[5]) |
                   (P[6] & P[5] & G[4]) |
                   (P[6] & P[5] & P[4] & G[3]) |
                   (P[6] & P[5] & P[4] & P[3] & G[2]) |
                   (P[6] & P[5] & P[4] & P[3] & P[2] & G[1]) |
                   (P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0]) |
                   (P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & Ci);
    assign Co[8] = G[7] |
                   (P[7] & G[6]) |
                   (P[7] & P[6] & G[5]) |
                   (P[7] & P[6] & P[5] & G[4]) |
                   (P[7] & P[6] & P[5] & P[4] & G[3]) |
                   (P[7] & P[6] & P[5] & P[4] & P[3] & G[2]) |
                   (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1]) |
                   (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0]) |
                   (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & Ci);
endmodule

module Adder8 (
    input [7:0]A,
    input [7:0]B,
    input Ci,
    output [7:0]S,
    output Co);

    wire [7:0]G, P;
    wire [8:1]C;

    CLA_8 cla(P, G, Ci, C);

    Adder a0(A[0], B[0], Ci, S[0], G[0], P[0]);
    Adder a1(A[1], B[1], C[1], S[1], G[1], P[1]);
    Adder a2(A[2], B[2], C[2], S[2], G[2], P[2]);
    Adder a3(A[3], B[3], C[3], S[3], G[3], P[3]);
    Adder a4(A[4], B[4], C[4], S[4], G[4], P[4]);
    Adder a5(A[5], B[5], C[5], S[5], G[5], P[5]);
    Adder a6(A[6], B[6], C[6], S[6], G[6], P[6]);
    Adder a7(A[7], B[7], C[7], S[7], G[7], P[7]);

    assign Co = C[7];
endmodule

module Adder32 (
    input [63:0]A,
    input [63:0]B,
    input Ci,
    output [63:0]S,
    output Co);

    wire C[7:1];

    Adder8 a0(A[7:0], B[7:0], Ci, S[7:0], C[1]);
    Adder8 a1(A[15:8], B[15:8], C[1], S[15:8], C[2]);
    Adder8 a2(A[23:16], B[23:16], C[2], S[23:16], C[3]);
    Adder8 a3(A[31:24], B[31:24], C[3], S[31:24], C[4]);
    Adder8 a4(A[39:32], B[39:32], C[4], S[39:32], C[5]);
    Adder8 a5(A[47:40], B[47:40], C[5], S[47:40], C[6]);
    Adder8 a6(A[55:48], B[55:48], C[6], S[55:48], C[7]);
    Adder8 a7(A[63:56], B[63:56], C[7], S[63:56], Co);
endmodule

module Suber32 (
    input [63:0]A,
    input [63:0]B,
    output [63:0]S,
    output OF);

    wire [63:0]_B = ~B;
    wire _OF;

    Adder32 adder(A, _B, 1'b1, S, _OF);

    assign OF = ~_OF;
endmodule

module mux1621(
    input [63:0]S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16,
    input [4:0]F,
    output [63:0]S);

    assign S = F == 4'b0000 ? S1 :
               F == 4'b0001 ? S2 :
               F == 4'b0010 ? S3 :
               F == 4'b0011 ? S4 :
               F == 4'b0100 ? S5 :
               F == 4'b0101 ? S6 :
               F == 4'b0110 ? S7 :
               F == 4'b0111 ? S8 :
               F == 4'b1000 ? S9 :
               F == 4'b1001 ? S10 :
               F == 4'b1010 ? S11 :
               F == 4'b1011 ? S12 :
               F == 4'b1100 ? S13 :
               F == 4'b1101 ? S14 :
               F == 4'b1110 ? S15 :
               F == 4'b1111 ? S16 : 64'b0;
endmodule

module ALU (
    input [63:0]A,
    input [63:0]B,
    input [3:0]MODE,
    output reg [63:0]S,
    output reg [63:0]S2,
    output [15:0]PSW);

    wire [63:0]adderS, suberS;
    wire adderCF, suberOF;
    Adder32 adder(.A (A), .B (B), .Ci(1'b0), .S(adderS), .Co(adderCF));
    Suber32 suber(.A (A), .B (B), .S(suberS), .OF(suberOF));

    reg [63:0]_PSW;

    always @(*) begin
        _PSW = 64'b0;
        if (MODE == `MODE_ADD) begin
            S = adderS;
            S2 = 64'b0;
            if (adderCF == 1'b1) begin
                _PSW = _PSW | (1 << `CF_BIT);
            end
        end
        else if (MODE == `MODE_SUB) begin
            S = suberS;
            S2 = 64'b0;
            if (suberOF == 1'b1) begin
                _PSW = _PSW | (1 << `OF_BIT);
            end
        end
        else if (MODE == `MODE_MUL) begin
        end
        else if (MODE == `MODE_DIV) begin
        end
        else if (MODE == `MODE_AND) begin
            S = A & B;
            S2 = 64'b0;
        end
        else if (MODE == `MODE_OR) begin
            S = A | B;
            S2 = 64'b0;
        end
        else if (MODE == `MODE_XOR) begin
            S = A ^ B;
            S2 = 64'b0;
        end
        else if (MODE == `MODE_NOT) begin
            S = ~ A;
            S2 = 64'b0;
        end

        if (S == 64'b0) begin
            _PSW = _PSW | (1 << `ZF_BIT);
        end
    end

    assign PSW = _PSW;
endmodule