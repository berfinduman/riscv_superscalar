`timescale 1ns / 1ps

module forward_muxA1(
  input  logic [31:0] RD1A_E, ResultA_W, ALUResultA_M,
  input  logic [1:0]  ForwardA1_E,
  output logic [31:0] WriteDataA1_E
);

 // assign WriteDataE = ForwardBE[1] ? ALUResultM : (ForwardBE[0] ? ResultW : RD2E);


always_comb
begin
case (ForwardA1_E)
 
 2'b00: WriteDataA1_E = RD1A_E;
 2'b01: WriteDataA1_E = ResultA_W;
 2'b10: WriteDataA1_E = ALUResultA_M;

 default: WriteDataA1_E = RD1A_E;

endcase

end
endmodule