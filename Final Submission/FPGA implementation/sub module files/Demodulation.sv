module Demodulation(
    input logic reset,
    input logic signed [15:0] I_in1,
    input logic signed [15:0] I_in2,
    input logic signed [15:0] I_in3,
    input logic signed [15:0] I_in4,
    input logic signed [15:0] Q_in1,
    input logic signed [15:0] Q_in2,
    input logic signed [15:0] Q_in3,
    input logic signed [15:0] Q_in4,
    output [7:0] data_out
    );

    QPSK_demodulator QPSK_demod1(.reset(reset), .I_in(I_in1), .Q_in(Q_in1), .data_out(data_out[1:0]));
    QPSK_demodulator QPSK_demod2(.reset(reset), .I_in(I_in2), .Q_in(Q_in2), .data_out(data_out[3:2]));
    QPSK_demodulator QPSK_demod3(.reset(reset), .I_in(I_in3), .Q_in(Q_in3), .data_out(data_out[5:4]));
    QPSK_demodulator QPSK_demod4(.reset(reset), .I_in(I_in4), .Q_in(Q_in4), .data_out(data_out[7:6]));

endmodule


module QPSK_demodulator(
    input logic reset,
    input logic signed [15:0] I_in, 
    input logic signed [15:0] Q_in,
    output logic [1:0] data_out
);

    //Define Constants
    localparam signed [15:0] POS = 16'b0000_0000_0000_0001;  // Represents +1
    localparam signed [15:0] NEG = 16'b1000_0000_0000_0000;  // Represents -1

    always_comb begin
        if (reset) begin
            data_out <= 2'b00;
        end else begin
            if({I_in, Q_in} == {NEG, NEG}) data_out = 2'b00;
            else if({I_in, Q_in} == {POS, NEG}) data_out = 2'b01;
            else if({I_in, Q_in} == {NEG, POS}) data_out = 2'b10;
            else if({I_in, Q_in} == {POS, POS}) data_out = 2'b11;
			else data_out = 2'b00;
        end
    end
endmodule

