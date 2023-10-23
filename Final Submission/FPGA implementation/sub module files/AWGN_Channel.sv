module AWGN_Channel(
    input logic clk,
    input logic reset,
    input logic noise_off,
    input logic [15:0] data_in1,
    input logic [15:0] data_in2,
    input logic [15:0] data_in3,
    input logic [15:0] data_in4,
    output logic [15:0] data_out1,
    output logic [15:0] data_out2,
    output logic [15:0] data_out3,
    output logic [15:0] data_out4
);

    logic [15:0] good_noise_out1, good_noise_out2, good_noise_out3, good_noise_out4;
    logic [15:0] bad_noise_out1, bad_noise_out2, bad_noise_out3, bad_noise_out4;

    parameter GOOD_CHANNEL = 2'b00;
    parameter BAD_CHANNEL = 2'b01;
    
    logic [31:0] random_value;
    logic [1:0] current_state, next_state;

    RandomValueGenerator rand_gen(.clk(clk), .reset(reset), .random_value(random_value));

    Good_Channel Good_channel(
        .clk(clk),
        .reset(reset),
        .data_out1(good_noise_out1),
        .data_out2(good_noise_out2),
        .data_out3(good_noise_out3),
        .data_out4(good_noise_out4));

    Bad_Channel Bad_channel(
        .clk(clk),
        .reset(reset),
        .data_out1(bad_noise_out1),
        .data_out2(bad_noise_out2),
        .data_out3(bad_noise_out3),
        .data_out4(bad_noise_out4));


    always_ff @(posedge clk) begin
        if (reset) begin
            next_state <= GOOD_CHANNEL;
        end else begin
            case (current_state)
                GOOD_CHANNEL: begin
                    if (random_value < 32'h0C427FAB) begin // Probability of 0.03
                        next_state <= BAD_CHANNEL;
                    end else begin
                        next_state <= GOOD_CHANNEL;
                    end
                end
                BAD_CHANNEL: begin
                    if (random_value < 32'h1311A28F) begin // Probability of 0.25
                        next_state <= GOOD_CHANNEL;
                    end else begin
                        next_state <= BAD_CHANNEL;
                    end
                end
            endcase
        end
    end

    always_ff @(posedge clk) begin
        current_state <= next_state;
    end

    always_comb begin
        if(noise_off) begin
            data_out1 <= data_in1;
            data_out2 <= data_in2;
            data_out3 <= data_in3;
            data_out4 <= data_in4;
        end
        else begin
            case(current_state) 
                GOOD_CHANNEL: begin
                    data_out1 <= data_in1 + good_noise_out1;
                    data_out2 <= data_in2 + good_noise_out2;
                    data_out3 <= data_in3 + good_noise_out3;
                    data_out4 <= data_in4 + good_noise_out4;
                end
                BAD_CHANNEL: begin
                    data_out1 <= data_in1 + bad_noise_out1;
                    data_out2 <= data_in2 + bad_noise_out2;
                    data_out3 <= data_in3 + bad_noise_out3;
                    data_out4 <= data_in4 + bad_noise_out4;
                end
                default: begin
                    data_out1 <= data_in1;
                    data_out2 <= data_in2;
                    data_out3 <= data_in3;
                    data_out4 <= data_in4;
                end
            endcase
        end
    end


endmodule


module Bad_Channel(
    input logic clk,
    input logic reset,
    output logic [15:0] data_out1,
    output logic [15:0] data_out2,
    output logic [15:0] data_out3,
    output logic [15:0] data_out4
);

    logic [5:0] counter;
    logic [11:0] address;
    logic [15:0] AWGN_data_out;
    logic [15:0] data_out1_reg, data_out2_reg, data_out3_reg, data_out4_reg;

    // Counter for address generation
    always_ff @(posedge clk) begin
        if (reset) begin // Counter updates every 50 clock cycles
            counter <= 0;
            address <= 0;
        end
        else if(counter == 49)begin
            counter <= 0;
        end
        else begin
            counter <= counter + 6'd1;
            address <= address + counter;
        end
    end


    AWGN_9db LUP_9db(
        .address(address),
        .clock(clk),
        .q(AWGN_data_out)
    );

    // Output registers and assignments
    always_ff @(posedge clk) begin
        case (counter)
            0: begin
                data_out1_reg <= AWGN_data_out; //--------------
                data_out2_reg <= data_out2_reg;
                data_out3_reg <= data_out3_reg;
                data_out4_reg <= data_out4_reg;
            end
            5: begin
                data_out1_reg <= data_out1_reg; 
                data_out2_reg <= AWGN_data_out; //--------------
                data_out3_reg <= data_out3_reg;
                data_out4_reg <= data_out4_reg;
            end
            10: begin
                data_out1_reg <= data_out1_reg; 
                data_out2_reg <= data_out2_reg;
                data_out3_reg <= AWGN_data_out; //--------------
                data_out4_reg <= data_out4_reg;
            end
            15: begin
                data_out1_reg <= data_out1_reg; 
                data_out2_reg <= data_out2_reg;
                data_out3_reg <= data_out3_reg;
                data_out4_reg <= AWGN_data_out; //--------------
            end
            default: begin
                data_out1_reg <= data_out1_reg; // Hold previous values
                data_out2_reg <= data_out2_reg;
                data_out3_reg <= data_out3_reg;
                data_out4_reg <= data_out4_reg;
            end
        endcase
    end

// Assigning to the output ports
    assign data_out1 = data_out1_reg;
    assign data_out2 = data_out2_reg;
    assign data_out3 = data_out3_reg;
    assign data_out4 = data_out4_reg;


endmodule


module Good_Channel(
    input logic clk,
    input logic reset,
    output logic [15:0] data_out1,
    output logic [15:0] data_out2,
    output logic [15:0] data_out3,
    output logic [15:0] data_out4
);

    logic [5:0] counter;
    logic [11:0] address;
    logic [15:0] AWGN_data_out;
    logic [15:0] data_out1_reg, data_out2_reg, data_out3_reg, data_out4_reg;

    // Counter for address generation
    always_ff @(posedge clk) begin
        if (reset) begin // Counter updates every 50 clock cycles
            counter <= 0;
            address <= 0;
        end
        else if(counter == 49)begin
            counter <= 0;
        end
        else begin
            counter <= counter + 6'd1;
            address <= address + counter;
        end
    end


    AWGN_21db LUP_21db(
        .address(address),
        .clock(clk),
        .q(AWGN_data_out)
    );

    // Output registers and assignments
    always_ff @(posedge clk) begin
        case (counter)
            0: begin
                data_out1_reg <= AWGN_data_out; //--------------
                data_out2_reg <= data_out2_reg;
                data_out3_reg <= data_out3_reg;
                data_out4_reg <= data_out4_reg;
            end
            5: begin
                data_out1_reg <= data_out1_reg; 
                data_out2_reg <= AWGN_data_out; //--------------
                data_out3_reg <= data_out3_reg;
                data_out4_reg <= data_out4_reg;
            end
            10: begin
                data_out1_reg <= data_out1_reg; 
                data_out2_reg <= data_out2_reg;
                data_out3_reg <= AWGN_data_out; //--------------
                data_out4_reg <= data_out4_reg;
            end
            15: begin
                data_out1_reg <= data_out1_reg; 
                data_out2_reg <= data_out2_reg;
                data_out3_reg <= data_out3_reg;
                data_out4_reg <= AWGN_data_out; //--------------
            end
            default: begin
                data_out1_reg <= data_out1_reg; // Hold previous values
                data_out2_reg <= data_out2_reg;
                data_out3_reg <= data_out3_reg;
                data_out4_reg <= data_out4_reg;
            end
        endcase
    end

// Assigning to the output ports
    assign data_out1 = data_out1_reg;
    assign data_out2 = data_out2_reg;
    assign data_out3 = data_out3_reg;
    assign data_out4 = data_out4_reg;


endmodule


module RandomValueGenerator(
  input logic clk,
  input logic reset,
  output logic [31:0] random_value
);
  
    logic [31:0] lfsr_state;

    always_ff @(posedge clk) begin
        lfsr_state <= {lfsr_state[30:0], lfsr_state[0] ^ lfsr_state[2] ^ lfsr_state[3] ^ lfsr_state[5]};
    end
    
    always_comb begin
        random_value <= lfsr_state;
    end
endmodule


module RandomValueGenerator_simulation(
  input logic clk,
  input logic reset,
  output logic [31:0] random_value
);

  logic [31:0] lfsr_state;

  always_ff @(posedge clk) begin
    if (reset) begin
      lfsr_state <= 32'hf0f0f0f0; // Set initial value based on seed
    end else begin
      lfsr_state <= {lfsr_state[30:0], lfsr_state[0] ^ lfsr_state[2] ^ lfsr_state[3] ^ lfsr_state[5]};
    end
  end
  
  always_comb begin
    random_value <= lfsr_state;
  end
endmodule