module Modulation(
    input reset,
    input [7:0] data_in,
    output signed [15:0] I_out1,
    output signed [15:0] I_out2,
    output signed [15:0] I_out3,
    output signed [15:0] I_out4,
    output signed [15:0] Q_out1,
    output signed [15:0] Q_out2,
    output signed [15:0] Q_out3,
    output signed [15:0] Q_out4
    );

    QPSK_modulator QPSK_mod1(.reset(reset), .data_in(data_in[1:0]), .I_out(I_out1), .Q_out(Q_out1));
    QPSK_modulator QPSK_mod2(.reset(reset), .data_in(data_in[3:2]), .I_out(I_out2), .Q_out(Q_out2));
    QPSK_modulator QPSK_mod3(.reset(reset), .data_in(data_in[5:4]), .I_out(I_out3), .Q_out(Q_out3));
    QPSK_modulator QPSK_mod4(.reset(reset), .data_in(data_in[7:6]), .I_out(I_out4), .Q_out(Q_out4));

endmodule


module QPSK_modulator(
    input logic reset,
    input logic [1:0] data_in,
    output logic signed [15:0] I_out, 
    output logic signed [15:0] Q_out
);

    //Define Constants
    localparam signed [15:0] POS = 16'b0000_0000_0000_0001;  // Represents +1
    localparam signed [15:0] NEG = 16'b1000_0000_0000_0000;  // Represents -1

    always_comb begin
        if (reset) begin
            I_out <= 16'd0;
            Q_out <= 16'd0;
        end else begin
            case (data_in)
                2'b00: begin
                    I_out <= NEG;
                    Q_out <= NEG;
                end
                2'b01: begin
                    I_out <= POS;
                    Q_out <= NEG;
                end
                2'b10: begin
                    I_out <= NEG;
                    Q_out <= POS;
                end
                2'b11: begin
                    I_out <= POS;
                    Q_out <= POS;
                end
            endcase
        end
    end
endmodule

