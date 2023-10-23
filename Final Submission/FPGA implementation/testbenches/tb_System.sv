`timescale 1ps / 1ps

module tb_System();
    logic clk = 0;
    logic reset, noise_off;

    logic [23:0] data_in, data_out;
    logic error;

    always #5 clk = ~clk;

    System dut(.*);

    initial begin
        reset = 1;
        noise_off = 1;
        #20;
        reset = 0;

        data_in = 0;

        #2000;

        data_in = 0;
        #20;


        // for(int i = 0; i < 65535; i++)begin
        //     data_in = data_in + 1;
        //     #5;
        //     assert(data_out == data_in);
        //     #5;
        // end

        #20
        noise_off = 0;
        data_in = 0;

        #10

        for(int i = 0; i < 1098575; i++)begin
            data_in = data_in + 1;
            #1;
            assert(data_out == data_in);
            #1;
        end
        

        $stop;
    end

endmodule
