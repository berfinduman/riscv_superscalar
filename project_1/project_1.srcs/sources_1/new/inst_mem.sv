`timescale 1ns / 1ps

module inst_mem #(
  parameter IMemInitFile = "imem.mem") (
  input  logic [31:0] PCF,
  output logic [31:0] instr1,
  output logic [31:0] instr2
);
  reg [7:0] mem [1023:0];
  initial begin 
    $readmemh(IMemInitFile, mem);
  end
assign instr1 = {mem[PCF], mem[PCF+1], mem[PCF+2], mem[PCF+3]};
assign instr2 = {mem[PCF+4], mem[PCF+5], mem[PCF+6], mem[PCF+7]};
endmodule
