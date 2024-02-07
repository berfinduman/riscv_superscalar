module PCTargetA_E (
  input  logic [31:0] PCE, ImmExtA_E,
  output logic [31:0] PCTargetA_E
);

  assign PCTargetA_E = PCE + ImmExtA_E;

endmodule

module PCTargetB_E (
  input  logic [31:0] PCE, ImmExtB_E,
  output logic [31:0] PCTargetB_E
);

  assign PCTargetB_E = PCE + ImmExtB_E;

endmodule