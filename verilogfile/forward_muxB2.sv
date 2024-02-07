`timescale 1ns / 1ps
module forward_muxB2(
  input  logic [31:0] RD2B_E, ResultB_W, ALUResultB_M,
  input  logic [1:0]  ForwardB2_E,
  output logic [31:0] WriteDataB2_E
);

 // assign WriteDataE = ForwardBE[1] ? ALUResultM : (ForwardBE[0] ? ResultW : RD2E);


always_comb
begin
case (ForwardB2_E)
 
 2'b00: WriteDataB2_E = RD2B_E;
 2'b01: WriteDataB2_E = ResultB_W;
 2'b10: WriteDataB2_E = ALUResultB_M;

 default: WriteDataB2_E = RD2B_E;

endcase

end
endmodule