`timescale 1ns / 1ps
module forward_muxA2(
  input  logic [31:0] RD2A_E, ResultA_W, ALUResultA_M,
  input  logic [1:0]  ForwardA2_E,
  output logic [31:0] WriteDataA2_E
);

 // assign WriteDataE = ForwardBE[1] ? ALUResultM : (ForwardBE[0] ? ResultW : RD2E);


always_comb
begin
case (ForwardA2_E)
 
 2'b00: WriteDataA2_E = RD2A_E;
 2'b01: WriteDataA2_E = ResultA_W;
 2'b10: WriteDataA2_E = ALUResultA_M;

 default: WriteDataA2_E = RD2A_E;

endcase

end
endmodule
