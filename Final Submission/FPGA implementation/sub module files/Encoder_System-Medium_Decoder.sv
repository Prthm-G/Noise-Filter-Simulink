module Encoder_System_Medium_Decoder(
    input logic clk,
    input logic reset,
    input logic noise_off,

    input logic [7:0] data_in,
    output logic [7:0] data_out,
    output logic error
); 

    logic [6:0] encoder_out1, encoder_out2;
    logic [6:0] decoder_in1, decoder_in2;
    logic decoder1_error, decoder2_error;

    logic extra1, extra2;

    Hamming74_Encoder encoder1(.data_in(data_in[3:0]), .data_out(encoder_out1));
    Hamming74_Encoder encoder2(.data_in(data_in[7:4]), .data_out(encoder_out2));

    System_Medium Sys1(
        .clk(clk),
        .reset(reset),
        .noise_off(noise_off),
        .data_in({encoder_out1, 1'b0}),
        .data_out({decoder_in1, extra1}));

    System_Medium Sys2(
        .clk(clk),
        .reset(reset),
        .noise_off(noise_off),
        .data_in({encoder_out2, 1'b0}),
        .data_out({decoder_in2, extra2}));

    Hamming74_Decoder decoder1(.data_in(decoder_in1), .data_out(data_out[3:0]), .error(decoder1_error));
    Hamming74_Decoder decoder2(.data_in(decoder_in2), .data_out(data_out[7:4]), .error(decoder2_error));

    assign error = decoder1_error || decoder2_error;

endmodule
