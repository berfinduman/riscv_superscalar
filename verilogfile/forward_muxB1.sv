`timescale 1ns / 1ps
module forward_muxB1(
  input  logic [31:0] RD1B_E, ResultB_W, ALUResultB_M,
  input  logic [1:0]  ForwardB1_E,
  output logic [31:0] WriteDataB1_E
);

 // assign WriteDataE = ForwardBE[1] ? ALUResultM : (ForwardBE[0] ? ResultW : RD2E);


always_comb
begin
case (ForwardB1_E)
 
 2'b00: WriteDataB1_E = RD1B_E;
 2'b01: WriteDataB1_E = ResultB_W;
 2'b10: WriteDataB1_E = ALUResultB_M;

 default: WriteDataB1_E = RD1B_E;

endcase

end
endmodule