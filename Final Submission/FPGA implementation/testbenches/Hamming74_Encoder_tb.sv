`timescale 1ps / 1ps

module Hamming74_Encoder_tb;
    logic [3:0] encoder_data_in;
    logic [6:0] encoder_data_out;
    logic [3:0] decoder_data_out;
    logic error;

    // Instantiate the Hamming74_Encoder
    Hamming74_Encoder encoder_dut(
        .data_in(encoder_data_in),
        .data_out(encoder_data_out)
    );

    // Instantiate the Hamming74_Decoder
    Hamming74_Decoder dencoder_dut(
        .data_in(encoder_data_out),
        .data_out(decoder_data_out),
        .error(error)
    );

    initial begin
        $monitor("At time %d, data_in = 4'b%b, data_out = 7'b%b", $time, encoder_data_in, decoder_data_out);
        
        // Apply input patterns
        encoder_data_in = 4'b0000;
        assert(decoder_data_out == encoder_data_in);
        #10;
        encoder_data_in = 4'b0001;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b0010;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b0011;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b0100;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b0101;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b0110;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b0111;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b1000;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b1001;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b1010;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b1011;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b1100;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b1101;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b1110;
        assert(decoder_data_out == encoder_data_in); #10;
        encoder_data_in = 4'b1111;
        assert(decoder_data_out == encoder_data_in); #10;

        $stop; // Finish the simulation
    end
endmodule