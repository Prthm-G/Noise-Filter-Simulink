`timescale 1ps / 1ps

module tb_Encoder_System_Medium_Decoder();
    logic clk = 0;
    logic reset, noise_off;

    logic [7:0] data_in, data_out;
    logic error;

    always #5 clk = ~clk;

    Encoder_System_Medium_Decoder dut(.*);

    initial begin
        reset = 1;
        noise_off = 1;
        #20;
        reset = 0;

        data_in = 0;

        #2000;

        data_in = 0;
        #20;


        for(int i = 0; i < 256; i++)begin
            data_in = data_in + 1;
            #10;
            assert(data_out == data_in);
            #10;
        end

        #20
        noise_off = 0;
        data_in = 0;

        #10

        for(int i = 0; i < 256; i++)begin
            data_in = data_in + 1;
            #10;
            assert(data_out == data_in);
            #10;
        end
        

        $stop;
    end
endmodule
