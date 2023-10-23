module Receiver(
    input logic [15:0] data_in1, 
    input logic [15:0] data_in2, 
    input logic [15:0] data_in3, 
    input logic [15:0] data_in4,
    output logic [15:0] data_out1, 
    output logic [15:0] data_out2, 
    output logic [15:0] data_out3, 
    output logic [15:0] data_out4
);
    //Define Constants
    localparam signed [15:0] POS = 16'b0000_0000_0000_0001;  // Represents +1
    localparam signed [15:0] NEG = 16'b1000_0000_0000_0000;  // Represents -1

    assign data_out1 = data_in1[15] ? NEG : POS;
    assign data_out2 = data_in2[15] ? NEG : POS;
    assign data_out3 = data_in3[15] ? NEG : POS;
    assign data_out4 = data_in4[15] ? NEG : POS;

endmodule
