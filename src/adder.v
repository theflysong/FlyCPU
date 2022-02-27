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
    input [31:0]A,
    input [31:0]B,
    input Ci,
    output [31:0]S,
    output Co);

    wire C[4:1];

    Adder8 a0(A[7:0], B[7:0], Ci, S[7:0], C[1]);
    Adder8 a1(A[15:8], B[15:8], C[1], S[15:8], C[2]);
    Adder8 a2(A[23:16], B[23:16], C[2], S[23:16], C[3]);
    Adder8 a3(A[31:24], B[31:24], C[3], S[31:24], C[4]);

    assign Co = C[4];
endmodule