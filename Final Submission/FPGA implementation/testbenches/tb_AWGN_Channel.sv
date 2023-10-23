`timescale 1ps / 1ps

module tb_AWGN_Channel();

    logic clk = 0;
    logic reset, noise_off;
    logic [15:0] data_in1, data_in2, data_in3, data_in4;
    logic [15:0] data_out1, data_out2, data_out3, data_out4;


    always #5 clk = ~clk;

    AWGN_Channel dut(.*);

    initial begin
        reset = 1;
        noise_off = 1;
        #20;
        reset = 0;
        
        data_in1 = 32'h5;
        data_in2 = 32'h17;
        data_in3 = 32'hd1;
        data_in4 = 32'hc5;

        #2000;
        #10;
        assert(data_out1 == data_in1);
        assert(data_out2 == data_in2);
        assert(data_out3 == data_in3);
        assert(data_out4 == data_in4);

        #10;
        data_in1 = 32'ha1;

        #10;
        assert(data_out1 == data_in1);

        #10;
        noise_off = 0;

        #30;



        $stop;
    end
    

endmodule
