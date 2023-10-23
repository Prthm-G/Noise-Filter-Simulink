`timescale 1ps / 1ps

module tb_Demoluation();

    logic reset;
    logic [7:0]data_in;
    logic [7:0]data_out;

    logic signed [15:0]I1;
    logic signed [15:0]I2;
    logic signed [15:0]I3;
    logic signed [15:0]I4;

    logic signed [15:0]Q1;
    logic signed [15:0]Q2;
    logic signed [15:0]Q3;
    logic signed [15:0]Q4;


    initial begin
        reset = 1'b1;
        #20;
        reset = 1'b0;
        data_in = 8'b00000000;
        #20;
        assert(data_out == data_in);

        for(int i = 0; i < 256; i++)begin
            data_in = data_in + 1'b1;
            #10;
            assert(data_out == data_in);
            #10;
        end


        $stop;
    end

    Modulation mod(.reset(reset), .data_in(data_in), .I_out1(I1), .I_out2(I2), .I_out3(I3), .I_out4(I4), .Q_out1(Q1), .Q_out2(Q2), .Q_out3(Q3), .Q_out4(Q4));
    Demodulation demod(.reset(reset), .I_in1(I1), .I_in2(I2), .I_in3(I3), .I_in4(I4), .Q_in1(Q1), .Q_in2(Q2), .Q_in3(Q3), .Q_in4(Q4), .data_out(data_out));

endmodule