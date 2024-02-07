`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module DtoE_stage(
   
    input  logic        rst, clk, RegWriteA_D, JumpA_D, BranchA_D ,ALUSrcA_D ,ZeroA_E, FlushE,
    input  logic        RegWriteB_D, MemWriteB_D, JumpB_D, BranchB_D ,ALUSrcB_D ,ZeroB_E,
    input  logic [4:0]  Rs1A_D, RdA_D,  Rs2A_D, Rs1B_D, Rs2B_D,RdB_D,
    input  logic [2:0]  funct3A_D,funct3B_D, 
    input  logic [1:0]  ResultSrcA_D,ResultSrcB_D,order_D,mem_modeB_D,
    input  logic [3:0]  ALUControlA_D, ALUControlB_D,
    input  logic [31:0] PCD, ImmExtA_D,ImmExtB_D, PCPlus8D, RD1A_D, RD2A_D,  RD1B_D,RD2B_D,
    output logic [31:0] PCE, ImmExtA_E, ImmExtB_E, PCPlus8E, RD1A_E, RD2A_E, RD1B_E, RD2B_E,
    output logic [3:0]  ALUControlA_E,ALUControlB_E,
    output logic [1:0]  ResultSrcA_E,ResultSrcB_E, order_E,mem_modeB_E,
    output logic [2:0]  funct3A_E,funct3B_E, 
    output logic [4:0]  RdA_E, Rs1A_E, Rs2A_E, RdB_E, Rs1B_E, Rs2B_E,
    output logic        RegWriteA_E, RegWriteB_E, MemWriteB_E, JumpA_E, JumpB_E, BranchA_E,BranchB_E, ALUSrcA_E, ALUSrcB_E, PCSrcA_E,PCSrcB_E
);

  always_ff @( posedge clk or negedge rst ) begin
    if (!rst) begin
      RegWriteA_E <=  0;            RegWriteB_E <= 0;
      JumpA_E <= 0;                 JumpB_E <= 0;
      BranchA_E <= 0;               BranchB_E <= 0; 
      ALUSrcA_E <= 0;               ALUSrcB_E <= 0;
      ResultSrcA_E <= 2'b00;        ResultSrcB_E <= 2'b00;
      ALUControlA_E <= 4'b0000;    ALUControlA_E <= 4'b0000;
      PCE <= 32'd0;
      ImmExtA_E <= 32'd0;           ImmExtB_E <= 32'd0;
      PCPlus8E <= 32'd0;  
      funct3A_E <= 3'd0;            funct3B_E <= 3'd0;
      order_E<= 2'b0; 
      RD1A_E <= 32'd0;              RD1B_E <= 32'd0;
      RD2A_E <= 32'd0;              RD2B_E <= 32'd0;
      RdA_E <= 5'd0;                RdB_E <= 5'd0;
      Rs1A_E <= 5'd0;               Rs1B_E <= 5'd0;
      Rs2A_E <= 5'd0;               Rs2B_E <= 5'd0;
      mem_modeB_E <= 3'd0;          MemWriteB_E <= 0;
    end
    else if (FlushE) begin
      RegWriteA_E <=  0;            RegWriteB_E <= 0;
      JumpA_E <= 0;                 JumpB_E <= 0;
      BranchA_E <= 0;               BranchB_E <= 0; 
      ALUSrcA_E <= 0;               ALUSrcB_E <= 0;
      ResultSrcA_E <= 2'b00;        ResultSrcB_E <= 2'b00;
      ALUControlA_E <= 4'b0000;    ALUControlA_E <= 4'b0000;
      PCE <= 32'd0;
      ImmExtA_E <= 32'd0;           ImmExtA_E <= 32'd0;
      PCPlus8E <= 32'd0;  
      RD1A_E <= 32'd0;              RD1B_E <= 32'd0;
      RD2A_E <= 32'd0;              RD2B_E <= 32'd0;
      funct3A_E <= 3'd0;            funct3B_E <= 3'd0;
      RdA_E <= 5'd0;                RdB_E <= 5'd0;
      Rs1A_E <= 5'd0;               Rs1B_E <= 5'd0;
      Rs2A_E <= 5'd0;               Rs2B_E <= 5'd0;
      mem_modeB_E <= 3'd0;          MemWriteB_E <= 0;
      order_E<=2'b0;
    end
    else begin
      RegWriteA_E <= RegWriteA_D;         RegWriteB_E <= RegWriteB_D;
      ResultSrcA_E <= ResultSrcA_D;       ResultSrcB_E <= ResultSrcB_D;
      JumpA_E <= JumpA_D;                 JumpB_E <= JumpB_D;
      BranchA_E <= BranchA_D;             BranchB_E <= BranchB_D;
      ALUSrcA_E <= ALUSrcA_D;             ALUSrcB_E <= ALUSrcB_D;
      ALUControlA_E <= ALUControlA_D;      ALUControlB_E <= ALUControlB_D;
      PCE <= PCD;        
      ImmExtA_E <= ImmExtA_D;             ImmExtB_E <= ImmExtB_D;
      PCPlus8E <= PCPlus8D;  
      RD1A_E <= RD1A_D;                    RD1B_E <= RD1B_E;
      RD2A_E <= RD2A_D;                    RD2B_E <= RD2B_E;
      funct3A_E <= funct3A_D;              funct3B_E <= funct3B_D;
      RdA_E <= RdA_D;                      RdB_E <= RdB_D;
      RdA_E <= RdA_D;                      RdB_E <= RdB_D;
      Rs1A_E <= Rs1A_D;                   Rs1B_E <= Rs1B_D;
      Rs2A_E <= Rs2A_D;                   Rs2B_E <= Rs2B_D;
      
      mem_modeB_E <= mem_modeB_D;  MemWriteB_E <= MemWriteB_D;
      order_E<=order_D;

    end

  end

  always_comb begin
    PCSrcA_E <= (ZeroA_E && BranchA_E) || JumpA_E;
    PCSrcB_E <=(ZeroB_E && BranchB_E) || JumpB_E;
  end

endmodule
