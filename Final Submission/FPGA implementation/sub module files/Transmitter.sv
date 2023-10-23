module Transmitter(
    input logic [15:0] data_in1, 
    input logic [15:0] data_in2, 
    input logic [15:0] data_in3, 
    input logic [15:0] data_in4,
    output logic [15:0] data_out1, 
    output logic [15:0] data_out2, 
    output logic [15:0] data_out3, 
    output logic [15:0] data_out4
);

    assign data_out1 = data_in1;
    assign data_out2 = data_in2;
    assign data_out3 = data_in3;
    assign data_out4 = data_in4;

endmodule

