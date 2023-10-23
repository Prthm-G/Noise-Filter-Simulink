module System_Medium(
    input logic clk,
    input logic reset,
    input logic noise_off,

    input [7:0] data_in,
    output [7:0] data_out
);
    logic [15:0] I_out_mod1, I_out_mod2, I_out_mod3, I_out_mod4;
    logic [15:0] Q_out_mod1, Q_out_mod2, Q_out_mod3, Q_out_mod4;

    logic [15:0] I_in_demod1, I_in_demod2, I_in_demod3, I_in_demod4;
    logic [15:0] Q_in_demod1, Q_in_demod2, Q_in_demod3, Q_in_demod4;

    Modulation mod(
        .reset(reset),
        .data_in(data_in),
        .I_out1(I_out_mod1), .I_out2(I_out_mod2), .I_out3(I_out_mod3), .I_out4(I_out_mod4),
        .Q_out1(Q_out_mod1), .Q_out2(Q_out_mod2), .Q_out3(Q_out_mod3), .Q_out4(Q_out_mod4));

    Transmitter_AWGN_Receiver T_GN_R1(
        .clk(clk),
        .reset(reset),
        .noise_off(noise_off),
        .in1(I_out_mod1), .in2(I_out_mod2), .in3(I_out_mod3), .in4(I_out_mod4),
        .out1(I_in_demod1), .out2(I_in_demod2), .out3(I_in_demod3), .out4(I_in_demod4));

    Transmitter_AWGN_Receiver T_GN_R2(
        .clk(clk),
        .reset(reset),
        .noise_off(noise_off),
        .in1(Q_out_mod1), .in2(Q_out_mod2), .in3(Q_out_mod3), .in4(Q_out_mod4),
        .out1(Q_in_demod1), .out2(Q_in_demod2), .out3(Q_in_demod3), .out4(Q_in_demod4));

    Demodulation demod(
        .reset(reset),
        .I_in1(I_in_demod1), .I_in2(I_in_demod2), .I_in3(I_in_demod3), .I_in4(I_in_demod4),
        .Q_in1(Q_in_demod1), .Q_in2(Q_in_demod2), .Q_in3(Q_in_demod3), .Q_in4(Q_in_demod4),
        .data_out(data_out));

endmodule


module Transmitter_AWGN_Receiver(
    input logic clk, 
    input logic reset,
    input logic noise_off,

    input logic [15:0] in1, 
    input logic [15:0] in2, 
    input logic [15:0] in3, 
    input logic [15:0] in4,

    output logic [15:0] out1,
    output logic [15:0] out2,
    output logic [15:0] out3,
    output logic [15:0] out4
);

    logic [15:0] transmitter_out1, transmitter_out2, transmitter_out3, transmitter_out4;
    logic [15:0] AWGN_out1, AWGN_out2, AWGN_out3, AWGN_out4;

    Transmitter transmitter(
        .data_in1(in1),
        .data_in2(in2),
        .data_in3(in3),
        .data_in4(in4),
        .data_out1(transmitter_out1),
        .data_out2(transmitter_out2),
        .data_out3(transmitter_out3),
        .data_out4(transmitter_out4));

    AWGN_Channel AWGN(
        .clk(clk),
        .reset(reset),
        .noise_off(noise_off),
        .data_in1(transmitter_out1),
        .data_in2(transmitter_out2),
        .data_in3(transmitter_out3),
        .data_in4(transmitter_out4),
        .data_out1(AWGN_out1),
        .data_out2(AWGN_out2),
        .data_out3(AWGN_out3),
        .data_out4(AWGN_out4));

    Receiver receiver(
        .data_in1(AWGN_out1),
        .data_in2(AWGN_out2),
        .data_in3(AWGN_out3),
        .data_in4(AWGN_out4),
        .data_out1(out1),
        .data_out2(out2),
        .data_out3(out3),
        .data_out4(out4));

endmodule
