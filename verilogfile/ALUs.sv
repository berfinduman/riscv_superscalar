`timescale 1ns / 1ps
module aluA(
  input  logic [31:0] SrcA1_E,SrcA2_E,
  input  logic [3:0] ALUControlA_E,
  input  logic [2:0] funct3A_E,
  output logic [31:0] ALUResultA_E,
  output logic CarryOutA,
  output logic  ZeroA_E
);
  logic [31:0] ALU_Result;
  logic [32:0] tmp;
  assign ALUResultA_E = ALU_Result;
  assign tmp = {1'b0,SrcA1_E} + {1'b0,SrcA2_E};
  assign CarryOutA = tmp[32];

	always_comb begin
    case(funct3A_E)
    3'b000:  ZeroA_E <=  SrcA1_E == SrcA2_E; //beq
    3'b001:  ZeroA_E <=  SrcA1_E != SrcA2_E; //bne
    3'b100:  ZeroA_E <=  SrcA1_E <  SrcA2_E; //blt
    3'b101:  ZeroA_E <=  SrcA1_E >  SrcA2_E; //bge
    3'b110:  ZeroA_E <=  SrcA1_E <  SrcA2_E; //bltu
    3'b111:  ZeroA_E <=  SrcA1_E >= SrcA2_E; //bgeu
    default: ZeroA_E <= 0;
    endcase
	end

  always_comb begin
    case(ALUControlA_E)
    4'b0000: ALU_Result = SrcA1_E + SrcA2_E ;           //Addition
    4'b0001: ALU_Result = SrcA1_E - SrcA2_E ;           //Subtraction
    4'b0010: ALU_Result = SrcA1_E<< SrcA2_E;             //Shift Left Logical
    4'b0011: ALU_Result = ($signed(SrcA1_E) < $signed(SrcA2_E)) ? 1 : 0;  //Set Less than
    4'b0100: ALU_Result =(SrcA1_E < SrcA2_E) ? 1 : 0;  //Set Less than unsigned
    4'b0101: ALU_Result = SrcA1_E ^ SrcA2_E;            //LOgical xor
    4'b0110: ALU_Result = SrcA1_E>>SrcA2_E;             //Shift Right Logical
    4'b0111: ALU_Result = SrcA1_E >>> SrcA2_E;          //Shift Right Arithmetic
    4'b1000: ALU_Result = SrcA1_E | SrcA2_E;            //Logical Or
    4'b1001: ALU_Result = SrcA1_E & SrcA2_E;            //Logical and
    default:  ALU_Result = SrcA1_E + SrcA2_E;
    endcase

  end

endmodule


module aluB(
  input  logic [31:0] SrcB1_E,SrcB2_E,
  input  logic [3:0] ALUControlB_E,
  input  logic [2:0] funct3B_E,
  output logic [31:0] ALUResultB_E,
  output logic CarryOutB,
  output logic  ZeroB_E
);
  logic [31:0] ALU_Result;
  logic [32:0] tmp;
  assign ALUResultB_E = ALU_Result;
  assign tmp = {1'b0,SrcB1_E} + {1'b0,SrcB2_E};
  assign CarryOutA = tmp[32];

	always_comb begin
    case(funct3B_E)
    3'b000:  ZeroB_E <=  SrcB1_E == SrcB2_E; //beq
    3'b001:  ZeroB_E <=  SrcB1_E != SrcB2_E; //bne
    3'b100:  ZeroB_E <=  SrcB1_E <  SrcB2_E; //blt
    3'b101:  ZeroB_E <=  SrcB1_E >  SrcB2_E; //bge
    3'b110:  ZeroB_E <=  SrcB1_E <  SrcB2_E; //bltu
    3'b111:  ZeroB_E <=  SrcB1_E >= SrcB2_E; //bgeu
    default: ZeroB_E <= 0;
    endcase
	end

  always_comb begin
    case(ALUControlB_E)
    4'b0000: ALU_Result = SrcB1_E + SrcB2_E ;           //Addition
    4'b0001: ALU_Result = SrcB1_E - SrcB2_E ;           //Subtraction
    4'b0010: ALU_Result = SrcB1_E<< SrcB2_E;             //Shift Left Logical
    4'b0011: ALU_Result = ($signed(SrcB1_E) < $signed(SrcB2_E)) ? 1 : 0;  //Set Less than
    4'b0100: ALU_Result =(SrcB1_E < SrcB2_E) ? 1 : 0;  //Set Less than unsigned
    4'b0101: ALU_Result = SrcB1_E ^ SrcB2_E;            //LOgical xor
    4'b0110: ALU_Result = SrcB1_E>>SrcB2_E;             //Shift Right Logical
    4'b0111: ALU_Result = SrcB1_E >>> SrcB2_E;          //Shift Right Arithmetic
    4'b1000: ALU_Result = SrcB1_E | SrcB2_E;            //Logical Or
    4'b1001: ALU_Result = SrcB1_E & SrcB2_E;            //Logical and
    default:  ALU_Result = SrcB1_E + SrcB2_E;
    endcase

  end

endmodule
