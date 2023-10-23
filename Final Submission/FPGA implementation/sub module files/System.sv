module System(
    input logic clk,
    input logic reset,
    input logic noise_off,

    input logic [23:0] data_in,
    output logic [23:0] data_out,
    output logic error
);

    logic error1, error2, error3;

    Encoder_System_Medium_Decoder sys1(
        .clk(clk),
        .reset(reset),
        .noise_off(noise_off),
        .data_in(data_in[7:0]),
        .data_out(data_out[7:0]),
        .error(error1));

    Encoder_System_Medium_Decoder sys2(
        .clk(clk),
        .reset(reset),
        .noise_off(noise_off),
        .data_in(data_in[15:8]),
        .data_out(data_out[15:8]),
        .error(error2));

    Encoder_System_Medium_Decoder sys3(
        .clk(clk),
        .reset(reset),
        .noise_off(noise_off),
        .data_in(data_in[23:16]),
        .data_out(data_out[23:16]),
        .error(error3));

    assign error = error || error || error;


endmodule
