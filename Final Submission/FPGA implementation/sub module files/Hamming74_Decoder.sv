// module hamming74_decoder(
//     input logic [6:0] hamming_code,  // Encoded data
//     output logic [3:0] decoded_data   // Decoded data
// );

//     logic [3:0] error;
//     always_comb begin
//         // Calculate error bit
        
//         error[0] = hamming_code[6] ^ hamming_code[4] ^ hamming_code[2] ^ hamming_code[0];
//         error[1] = hamming_code[5] ^ hamming_code[4] ^ hamming_code[1] ^ hamming_code[0];
//         error[2] = hamming_code[3] ^ hamming_code[2] ^ hamming_code[1] ^ hamming_code[0];
//         error[3] = hamming_code[6] ^ hamming_code[5] ^ hamming_code[3] ^ hamming_code[0];
        
//         // Correct error
//         if (error != 4'b0000) begin
//             hamming_code[error] = ~hamming_code[error];
//         end

//         // Get original data
//         decoded_data[0] = hamming_code[2];
//         decoded_data[1] = hamming_code[4];
//         decoded_data[2] = hamming_code[5];
//         decoded_data[3] = hamming_code[6];
//     end

    
// endmodule


module Hamming74_Decoder(
    input logic [6:0] data_in,
    output logic [3:0] data_out,
    output logic error
  );
  
  logic p1, p2, p4;
  logic [6:0] syndrome; //one hot value for the bit to be corrected
  logic [6:0] decoded_data;
  logic parity;

  always_comb begin
    p1 = data_in[0] ^ data_in[2] ^ data_in[4] ^ data_in[6];
    p2 = data_in[1] ^ data_in[2] ^ data_in[5] ^ data_in[6];
    p4 = data_in[3] ^ data_in[4] ^ data_in[5] ^ data_in[6];
  end
  

  always_comb begin
    case({p4,p2,p1}) 
        3'd1: syndrome = 7'b0000_001;
        3'd2: syndrome = 7'b0000_010;
        3'd3: syndrome = 7'b0000_100;
        3'd4: syndrome = 7'b0001_000;
        3'd5: syndrome = 7'b0010_000;
        3'd6: syndrome = 7'b0100_000;
        3'd7: syndrome = 7'b1000_000;
        default: syndrome = 7'b0;
    endcase
  end

  // Error detection
  always_comb begin
    error = (syndrome != 3'b000);
  end

  assign decoded_data = syndrome ^ data_in; //correct the error if found

  assign data_out = {decoded_data[6:4], decoded_data[2]};

endmodule
