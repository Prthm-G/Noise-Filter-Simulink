`timescale 1ps / 1ps

module QPSK_modulator_tb;
    
    logic reset;
    logic [1:0] data_in; // Assuming 2 bits input data
    logic [15:0] I_out, Q_out; // Assuming I_out and Q_out are 16 bits wide
   
    localparam signed [15:0] POS = 16'b0000_0000_0000_0001;  // Represents +1
    localparam signed [15:0] NEG = 16'b1000_0000_0000_0000;  // Represents -1

    initial begin
        reset = 1'b1;
        #20
        reset = 1'b0;
        data_in = 2'b00;
        #20;
        data_in = 2'b01;
        #20;
        data_in = 2'b10;
        #20;
        data_in = 2'b11;
        #20;
        $stop;
    end

    QPSK_modulator dut(.reset(reset), .data_in(data_in), .I_out(I_out), .Q_out(Q_out));

endmodule

