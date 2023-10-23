`timescale 1ps / 1ps

module tb_Receiver();
    logic [15:0] data_in1, data_in2, data_in3, data_in4;
    logic [15:0] data_out1, data_out2, data_out3, data_out4;

    //Define Constants
    localparam signed [15:0] POS = 16'b0000_0000_0000_0001;  // Represents +1
    localparam signed [15:0] NEG = 16'b1000_0000_0000_0000;  // Represents -1

    Receiver rec(.*);

    initial begin
        data_in1 = POS;
        data_in2 = POS;
        data_in3 = POS;
        data_in4 = POS;
        #10

        data_in1 = POS;
        data_in2 = POS;
        data_in3 = POS;
        data_in4 = POS;
        #10

        data_in1 = POS + 17;
        data_in2 = POS + 35;
        data_in3 = POS + 69;
        data_in4 = POS + 140;
        #10

        data_in1 = NEG + 12017;
        data_in2 = NEG + 26735;
        data_in3 = NEG + 30269;
        data_in4 = NEG + 49140;
        #10


        $stop;
    end

endmodule
