`timescale 1ps / 1ps

module tb_Transmitter_AWGN_Receiver();
    logic clk = 0;
    logic reset, noise_off;
    logic [15:0] in1, in2, in3, in4;
    logic [15:0] out1, out2, out3, out4;

    //Define Constants
    localparam signed [15:0] POS = 16'b0000_0000_0000_0001;  // Represents +1
    localparam signed [15:0] NEG = 16'b1000_0000_0000_0000;  // Represents -1

    Transmitter_AWGN_Receiver dut(.*);

    always #5 clk = ~clk;

    initial begin
        reset = 1;
        noise_off = 1;

        #20
        reset = 0;
        in1 = POS;
        in2 = POS;
        in3 = POS;
        in4 = POS;
        #2000;

        in1 = NEG;
        in2 = NEG;
        in3 = NEG;
        in4 = NEG;
        #20;

        noise_off = 0;
        #20;

        in1 = NEG;
        in2 = POS;
        in3 = NEG;
        in4 = POS;
        #20;


        $stop;
    end

endmodule
