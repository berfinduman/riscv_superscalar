module forward_muxA1(
  input  logic [31:0] RDA1_E, ResultA_W, ResultB_W,
  input  logic [1:0]  ForwardA1E,
  output logic [31:0] SrcA1_E
);

always_comb
begin
case (ForwardA1E)
 
 2'b00: SrcA1_E = RDA1_E;
 2'b01: SrcA1_E = ResultA_W;
 2'b10: SrcA1_E = ResultB_W;

 default: SrcA1_E =RDA1_E;

endcase

end
endmodule

module forward_muxA2 (
  input  logic [31:0] RDA2_E, ResultA_W, ResultB_W,
  input  logic [1:0]       ForwardA2E,
  output logic [31:0] WriteDataA_E
);

always_comb
begin
case (ForwardA2E)
 
 2'b00: WriteDataA_E = RDA2_E;
 2'b01: WriteDataA_E = ResultA_W;
 2'b10: WriteDataA_E = ResultB_W;

 default: WriteDataA_E = RDA2_E;

endcase
end
endmodule

module mux_aluA2(
  input  logic ALUSrcA_E,
  input  logic [31:0] WriteDataA_E, ImmExtA_E,
  output logic [31:0] SrcA2_E
  );

  assign SrcA2_E = ALUSrcA_E ?  ImmExtA_E: WriteDataA_E;

endmodule



module forward_muxB1(
  input  logic [31:0] RDB1_E, ResultA_W, ResultB_W,
  input  logic [1:0]  ForwardB1E,
  output logic [31:0] SrcB1_E
);

always_comb
begin
case (ForwardB1E)
 
 2'b00: SrcB1_E = RDB1_E;
 2'b01: SrcB1_E = ResultA_W;
 2'b10: SrcB1_E = ResultB_W;

 default: SrcB1_E =RDB1_E;

endcase

end
endmodule

module forward_muxB2 (
  input  logic [31:0] RDB2_E, ResultA_W, ResultB_W,
  input  logic [1:0]       ForwardB2E,
  output logic [31:0] WriteDataB_E
);

always_comb
begin
case (ForwardB2E)
 
 2'b00: WriteDataB_E = RDB2_E;
 2'b01: WriteDataB_E = ResultA_W;
 2'b10: WriteDataB_E = ResultB_W;

 default: WriteDataB_E = RDB2_E;

endcase
end
endmodule

module mux_aluB2(
  input  logic ALUSrcB_E,
  input  logic [31:0] WriteDataB_E, ImmExtB_E,
  output logic [31:0] SrcB2_E
  );

  assign SrcB2_E = ALUSrcB_E?  ImmExtB_E:WriteDataB_E;

endmodule


