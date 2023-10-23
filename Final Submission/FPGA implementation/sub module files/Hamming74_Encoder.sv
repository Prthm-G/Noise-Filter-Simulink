module Hamming74_Encoder(
    input logic [3:0] data_in,
    output logic [6:0] data_out
);

    logic p1, p2, p4;

    assign p1 = data_in[0] ^ data_in[1] ^ data_in[3];
    assign p2 = data_in[0] ^ data_in[2] ^ data_in[3];
    assign p4 = data_in[1] ^ data_in[2] ^ data_in[3];

    assign data_out = {data_in[3:1], p4, data_in[0], p2, p1};

endmodule