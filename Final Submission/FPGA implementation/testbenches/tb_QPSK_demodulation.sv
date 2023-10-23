`timescale 1ps / 1ps

module QPSK_demodulator_tb();
    
    logic reset;
    logic [15:0] I_in, Q_in;
    logic [1:0] data_out; 

    //Define Constants
    localparam signed [15:0] POS = 16'b0000_0000_0000_0001;  // Represents +1
    localparam signed [15:0] NEG = 16'b1000_0000_0000_0000;  // Represents -1

    initial begin
        reset = 1'b1;
        #20
        reset = 1'b0;
        I_in = NEG; Q_in = NEG;
        #20
        I_in = POS; Q_in = NEG;
        #20
        I_in = NEG; Q_in = POS;
        #20
        I_in = POS; Q_in = POS;
        #20
	$stop;
    end

    QPSK_demodulator dut(.reset(reset), .I_in(I_in), .Q_in(Q_in), .data_out(data_out));

endmodule
