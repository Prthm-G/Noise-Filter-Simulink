`timescale 1ps / 1ps

module tb_System_Medium();
    logic clk = 0;
    logic reset, noise_off;

    logic [7:0] data_in, data_out;

    System_Medium Sys(.*);

    always #5 clk = ~clk;

    initial begin
        reset = 1;
        noise_off = 1;

        #20
        reset = 0;
        data_in = 0;

        #2000;

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
