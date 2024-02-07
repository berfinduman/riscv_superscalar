`timescale 1ns / 1ps

module TOP_mod  #( parameter DMemInitFile = "dmem.mem",
  parameter IMemInitFile = "imem.mem",
  parameter LogFile = "rv_track.txt")
(
 input clk_i,rst_ni
);
  
logic   hazard_flag, funct7A, funct7B,PCSrcA_E,PCSrcB_E,  StallF,
stallonly,stallonlyD,FlushD,RegWriteA_W,RegWriteB_W,RegWriteA_D, JumpA_D, 
 BranchA_D, ALUSrcA_D,RegWriteB_D, MemWriteB_D, JumpB_D, BranchB_D, ALUSrcB_D ,
   ZeroA_E, FlushE,ZeroB_E, CarryOutA,  CarryOutB, RegWriteA_E, RegWriteB_E, MemWriteB_E, JumpA_E, 
   JumpB_E, BranchA_E,BranchB_E, ALUSrcA_E, ALUSrcB_E;

logic [1:0]  ResultSrcA_D,ResultSrcB_D,ResultSrcA_E,ResultSrcB_E,ResultSrcA_W,ResultSrcB_W,
ForwardA1E, ForwardA2E, ForwardB1E, ForwardB2E,order,order_D, order_E,order_W,mem_modeB_D,mem_modeB_E;

logic [2:0] funct3A, funct3B,funct3A_E,funct3B_E,ImmSrcA_D,ImmSrcB_D, AluOPA, AluOPB;
logic [3:0]  ALUControlA_D, ALUControlB_D,  ALUControlA_E,ALUControlB_E; 
logic [4:0]  A1, A2, Rs1A_D, Rs2A_D,Rs1A_E, Rs2A_E, RdA_D,RdA_E, RdA_W, B1, B2, Rs1B_D, Rs2B_D,Rs1B_E, Rs2B_E, RdB_D, RdB_E, RdB_W  ;  

logic [6:0]  OPA, OPB,funct77A,funct77B;

logic [24:0] ImmA,ImmB;

logic [31:0] instr1, instr2, instr1D, instr2D,PCF,PCD,PCPlus8D,PCTargetA_E, PCTargetB_E, PCPlus8F,ImmExtA_D,
ImmExtB_D, RDA1, RDA2, RDB1, RDB2, ResultA_W,ResultB_W, ImmExtA_E, ImmExtB_E, PCE,PCPlus8E,PCPlus8W, 
RD1A_E, RD2A_E, RD1B_E, RD2B_E, RD1E,ResultA_WH, ResultB_WH,
RD2E,  SrcA1_E,  SrcA2_E,  SrcB1_E,SrcB2_E,   SrcAE,SrcBE,WriteDataA_E,WriteDataB_E, ALUResult,WriteDataM,
PCPlus4M,ReadDataB_E,ReadDataB_W,ALUResultW,ReadDataW,PCPlus4W,ALUResultA_E, ALUResultB_E,ALUResultA_W, ALUResultB_W;


//Fetch part


////
//    input logic clk,rst,
//    input logic StallF,
//    input logic PCSrcA_E, PCSrcB_E,
//    input logic [31:0]  PCPlus8F,PCTargetA_E,  PCTargetB_E,
//    output logic [31:0] PCF 

  
  Pcounter prog_c (.clk(clk_i), .rst(rst_ni), .StallF(StallF), .PCSrcA_E(PCSrcA_E),  .PCSrcB_E(PCSrcB_E),
    .PCPlus8F(PCPlus8F) , .PCTargetB_E(PCTargetB_E), .PCTargetA_E(PCTargetA_E), .PCF(PCF));
   
  inst_mem #(.IMemInitFile(IMemInitFile) ) inst_mem (.PCF(PCF),.instr1(instr1),.instr2(instr2));  
  //input logic [31:0] PCF, output logic  [31:0] PcPlus8F
  PcPlus8 pc_plus8  (.PCF(PCF),.PCPlus8F(PCPlus8F));
//Fetch To Decode  
  FtoD_stage FtoD(.clk(clk_i), .rst(rst_ni),.stallonly(stallonly),
  .FlushD(FlushD),.instr1(instr1), .instr2(instr2),.PCF(PCF),.PCPlus8F(PCPlus8F),
  .stallonlyD(stallonlyD),.instr1D(instr1D), 
  .instr2D(instr2D), .PCD(PCD) ,.PCPlus8D(PCPlus8D) );
//Decode Part

  instruction_fetch instruction_fetch(.stallonlyD(stallonlyD),.instr1D(instr1D), .instr2D(instr2D), .A1(A1), .A2(A2), .Rs1A_D(Rs1A_D), .Rs2A_D(Rs2A_D), 
  .RdA_D(RdA_D), .B1(B1), .B2(B2), .Rs1B_D(Rs1B_D), .Rs2B_D(Rs2B_D),.RdB_D(RdB_D),.ImmA_D(ImmA), .ImmB_D(ImmB),.OPA(OPA), .OPB(OPB),.funct3A(funct3A),
   .funct3B(funct3B),.funct7A(funct7A), .funct7B(funct7B),.funct77A(funct77A),.funct77B(funct77B),.order(order),.hazard_flag(hazard_flag));
  
  extendA ext_A(.ImmA(ImmA), .ImmSrcA_D(ImmSrcA_D),.ImmExtA_D(ImmExtA_D)); 
  
  extendB ext_B(.ImmB(ImmB), .ImmSrcB_D(ImmSrcB_D),.ImmExtB_D(ImmExtB_D));  
  
  register_file reg_file(.clk(clk_i), .rst(rst_ni),.RegWriteA_W(RegWriteA_W),.RegWriteB_W(RegWriteB_W),
   .A1(A1), .A2(A2), .RdA_W(RdA_W), .B1(B1),.B2(B2), .RdB_W(RdB_W),.ResultA_WH(ResultA_WH),
   .ResultB_WH(ResultB_WH),.RDA1(RDA1), .RDA2(RDA2), .RDB1(RDB1), .RDB2(RDB2)); 
 
 
 
  controller cont(.OPA(OPA), .OPB(OPB),.funct3A(funct3A), .funct3B(funct3B),.AluOPA(AluOPA),.AluOPB(AluOPB),
   .funct7A(funct7A), .funct7B(funct7B),.funct77A(funct77A),.funct77B(funct77B),.order(order),.order_D(order_D),.ImmSrcA_D(ImmSrcA_D),
   .ImmSrcB_D(ImmSrcB_D), .mem_modeB_D(mem_modeB_D),.RegWriteA_D(RegWriteA_D), .JumpA_D(JumpA_D), .BranchA_D(BranchA_D), .ResultSrcA_D(ResultSrcA_D),.ResultSrcB_D(ResultSrcB_D),
   .ALUSrcA_D(ALUSrcA_D),.RegWriteB_D(RegWriteB_D), .MemWriteB_D(MemWriteB_D), .JumpB_D(JumpB_D), .BranchB_D(BranchB_D), .ALUSrcB_D(ALUSrcB_D));
  
  Alu_Decoder alu_dec(.funct3A(funct3A), .funct3B(funct3B),.AluOPA(AluOPA),.AluOPB(AluOPB),.funct7A(funct7A), .funct7B(funct7B),.ALUControlA_D(ALUControlA_D), 
   .ALUControlB_D(ALUControlB_D)); 
// Decode to Execute 

 DtoE_stage dtoe(.clk(clk_i), .rst(rst_ni),.order_D(order_D),
   .mem_modeB_D(mem_modeB_D),.RegWriteA_D(RegWriteA_D), .JumpA_D(JumpA_D),
   .BranchA_D(BranchA_D), .ALUSrcA_D(ALUSrcA_D),.RegWriteB_D(RegWriteB_D),
   .MemWriteB_D(MemWriteB_D), .JumpB_D(JumpB_D), .BranchB_D(BranchB_D), 
   .ALUSrcB_D(ALUSrcB_D),.ZeroA_E(ZeroA_E), .FlushE(FlushE),.ZeroB_E(ZeroB_E),.RD1A_D(RDA1), 
   .RD2A_D(RDA2), .RD1B_D(RDB1), .RD2B_D(RDB2), .Rs1A_D(Rs1A_D), .Rs2A_D(Rs2A_D), .RdA_D(RdA_D),
   .RdA_E(RdA_E), .RdB_E(RdB_E),
   .Rs1B_D(Rs1B_D), .Rs2B_D(Rs2B_D),.RdB_D(RdB_D),.funct3A_D(funct3A), .funct3B_D(funct3B), .funct3A_E(funct3A_E), .funct3B_E(funct3B_E),
   .ResultSrcA_D(ResultSrcA_D),.ResultSrcB_D(ResultSrcB_D),.ResultSrcA_E(ResultSrcA_E),.ResultSrcB_E(ResultSrcB_E),
   .ALUControlA_D(ALUControlA_D), .ALUControlA_E(ALUControlA_E),.ALUControlB_E(ALUControlB_E),
   .ALUControlB_D(ALUControlB_D),.PCD(PCD),.ImmExtA_D(ImmExtA_D) ,.ImmExtB_D(ImmExtB_D),
   .ImmExtA_E(ImmExtA_E) ,.ImmExtB_E(ImmExtB_E),.PCE(PCE),.PCPlus8E(PCPlus8E),
   .PCPlus8D(PCPlus8D),  .mem_modeB_E(mem_modeB_E),
   .RegWriteA_E(RegWriteA_E), .RegWriteB_E(RegWriteB_E), .MemWriteB_E(MemWriteB_E), .JumpA_E(JumpA_E), .JumpB_E(JumpB_E), 
   .BranchA_E(BranchA_E),.BranchB_E(BranchB_E), 
   .ALUSrcA_E(ALUSrcA_E), .ALUSrcB_E(ALUSrcB_E), .PCSrcA_E(PCSrcA_E),.PCSrcB_E(PCSrcB_E),
   .RD1A_E(RD1A_E), .RD2A_E(RD2A_E), .RD1B_E(RD1B_E), .RD2B_E(RD2B_E),.Rs1A_E(Rs1A_E), .Rs2A_E(Rs2A_E), .Rs1B_E(Rs1B_E), .Rs2B_E(Rs2B_E),.order_E(order_E)
     ); 
//Execute Part                       //

//A path:
forward_muxA1 f_mA1(.RDA1_E(RD1A_E),.ResultA_W(ResultA_W), .ResultB_W(ResultB_W),.ForwardA1E(ForwardA1E),.SrcA1_E(SrcA1_E));

forward_muxA2   f_mA2(.RDA2_E(RD2A_E),.ResultA_W(ResultA_W), .ResultB_W(ResultB_W),.ForwardA2E(ForwardA2E),.WriteDataA_E(WriteDataA_E));

mux_aluA2 m_aluA2(.ALUSrcA_E(ALUSrcA_E),.WriteDataA_E(WriteDataA_E),.ImmExtA_E(ImmExtA_E),.SrcA2_E(SrcA2_E)); 

PCTargetA_E pc_targetA_E(.PCE(PCE), .ImmExtA_E(ImmExtA_E),.PCTargetA_E(PCTargetA_E));

aluA aluA(.SrcA1_E(SrcA1_E),.SrcA2_E(SrcA2_E),.ALUControlA_E(ALUControlA_E),.funct3A_E(funct3A_E), .ALUResultA_E(ALUResultA_E),
 .CarryOutA(CarryOutA),.ZeroA_E(ZeroA_E));

//B path:
forward_muxB1 f_mB1(.RDB1_E(RD1B_E),.ResultA_W(ResultA_W), .ResultB_W(ResultB_W),.ForwardB1E(ForwardB1E),.SrcB1_E(SrcB1_E));

forward_muxB2   f_mB2(.RDB2_E(RD2B_E),.ResultA_W(ResultA_W), .ResultB_W(ResultB_W),.ForwardB2E(ForwardB2E),.WriteDataB_E(WriteDataB_E));

mux_aluB2 m_aluB2(.ALUSrcB_E(ALUSrcB_E),.WriteDataB_E(WriteDataB_E),
 .ImmExtB_E(ImmExtB_E),.SrcB2_E(SrcB2_E)); 

PCTargetB_E pc_targetB_E(.PCE(PCE), .ImmExtB_E(ImmExtB_E),.PCTargetB_E(PCTargetB_E));

aluB aluB (.SrcB1_E(SrcB1_E),.SrcB2_E(SrcB2_E),.ALUControlB_E(ALUControlB_E),.funct3B_E(funct3B_E), .ALUResultB_E(ALUResultB_E),.CarryOutB(CarryOutB),
 .ZeroB_E(ZeroB_E));



data_memory #(.DMemInitFile(DMemInitFile) ) data_mem(.clk(clk_i), .rst(rst_ni),.MemWriteB_E(MemWriteB_E),.mem_mode(mem_modeB_E),.ALUResultB_E(ALUResultB_E),
.ReadData_B(ReadDataB_E),.WriteDataB_E(WriteDataB_E));

//Execute to Decode 
EtoW_stage etow(.clk(clk_i), .rst(rst_ni),.RegWriteA_E(RegWriteA_E), .RegWriteB_E(RegWriteB_E),
.ResultSrcA_E(ResultSrcA_E),.ResultSrcB_E(ResultSrcB_E),.ALUResultA_E(ALUResultA_E),
.ALUResultB_E(ALUResultB_E),.ReadDataB_E(ReadDataB_E),.PCPlus8E(PCPlus8E),.PCPlus8W(PCPlus8W),
.RdA_E(RdA_E),.RdB_E(RdB_E), .RdA_W(RdA_W), .RdB_W(RdB_W),.ALUResultA_W(ALUResultA_W), 
.ALUResultB_W(ALUResultB_W),.ReadDataB_W(ReadDataB_W),
.ResultSrcA_W(ResultSrcA_W),.ResultSrcB_W(ResultSrcB_W),.RegWriteA_W(RegWriteA_W),.RegWriteB_W(RegWriteB_W),.order_E(order_E),.order_W(order_W)); 

//Execute Part

mux_resultA mux_rA(.ALUResultA_W(ALUResultA_W),.PCPlus8W(PCPlus8W),.ResultSrcA_W(ResultSrcA_W),.ResultA_W(ResultA_W));


mux_resultB mux_rB(.ALUResultB_W(ALUResultB_W),.ReadDataB_W(ReadDataB_W),.PCPlus8W(PCPlus8W),.ResultSrcB_W(ResultSrcB_W),.ResultB_W(ResultB_W));

//HAZARD UNIT
//input logic [31:0] ResultA_W+, ResultB_W+,
//input logic hazard_flag+,  PCSrcA_E+, PCSrcB_E+,RegWriteA_W+, RegWriteB_W+, 
//input logic [4:0]  RdA_E+, Rs1A_E+, Rs2A_E+, RdB_E+, Rs1B_E+, Rs2B_E+,RdA_W+,RdB_W+,
//output logic [1:0] ForwardA1E+,ForwardA2E+, ForwardB1E+,ForwardB2E+, order_W+,
//output logic       StallF, StallD,stallonly, FlushE, FlushD,
//output logic [31:0] ResultA_WH, ResultB_WH
hazard_unit hu (.ResultA_W(ResultA_W),.ResultB_W(ResultB_W),.hazard_flag(hazard_flag),
.PCSrcA_E(PCSrcA_E),.PCSrcB_E(PCSrcB_E),.RegWriteA_W(RegWriteA_W),.RegWriteB_W(RegWriteB_W),
.RdA_E(RdA_E),.RdB_E(RdB_E),.Rs1A_E(Rs1A_E),.Rs2A_E(Rs2A_E),.Rs1B_E(Rs1B_E), .Rs2B_E(Rs2B_E),
.RdA_W(RdA_W), .RdB_W(RdB_W),.ForwardA1E(ForwardA1E),.ForwardA2E(ForwardA2E),.ForwardB1E(ForwardB1E),
.ForwardB2E(ForwardB2E),.order_W(order_W),.StallF(StallF),.stallonly(stallonly),
.FlushE(FlushE),.FlushD(FlushD),.ResultA_WH(ResultA_WH),.ResultB_WH(ResultB_WH)); 

int file;
    //DUZENLEEEE
  always_ff @(posedge (RegWriteA_W|RegWriteB_W) or posedge MemWriteB_E) begin
    file = $fopen(LogFile, "w");
    $fwrite(file, "A path REGMEM:  x%0d 0x%16h--%d \n", RdA_W, ResultA_W,ResultA_W ); // log the register file writes
    $fwrite(file, "B path REGMEM: x%0d 0x%16h--%d \n", RdB_W, ResultB_W,ResultB_W ); // log the register file writes
    $fwrite(file, "MEM:  MemWrite:  Write Data:0x%16h  A (hex,dec): 0x%16h -- %d \n ",RdB_E, WriteDataB_E,WriteDataB_E); // log the data memory writes
    $display("Write completed");
    $fclose(file);
  end

endmodule
