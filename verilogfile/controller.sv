
module Alu_Decoder(

input  logic funct7A,funct7B,
input  logic [2:0] funct3A, funct3B,
input logic [2:0]  AluOPA,  AluOPB,
output logic [3:0] ALUControlA_D, ALUControlB_D);


logic [6:0] checker1,checker2;

assign checker1={{AluOPA}, {funct3A},funct7A};
assign checker2={{AluOPB}, {funct3B},funct7B};
  always_comb begin
    casex (checker1)
 // R Type instructions
           // R Type instructions
      7'b00100000: ALUControlA_D <= 4'b0000;   //add (0)
      7'b00100001: ALUControlA_D <= 4'b0001;   //subtract (1)
      7'b00100100: ALUControlA_D <= 4'b0010;   //Shift Left Logical (2)
      7'b00101000: ALUControlA_D <= 4'b0011;   //Set Less than (3)
      7'b00101100: ALUControlA_D <= 4'b0100;   //Set Less unsigned (4)
      7'b00110000: ALUControlA_D <= 4'b0101;   //xor (5)
      7'b00110100: ALUControlA_D <= 4'b0110;   //Shift Right Logical (6)
      7'b00110101: ALUControlA_D <= 4'b0111;   //Shift Right Arithmetic (7)
      7'b00111000: ALUControlA_D <= 4'b1000;   //or (8)
      7'b00111100: ALUControlA_D <= 4'b1001;   //and (9)
    // Load Instructions
      7'b011000x: ALUControlA_D <= 4'b0000;   //load byte
      7'b011001x: ALUControlA_D <= 4'b0000;   //load half
      7'b011010x:  ALUControlA_D <= 4'b0000;   //load word
    // I tyoe  Instructions
      7'b010000x: ALUControlA_D <= 4'b0000;   //addi
      7'b0100010: ALUControlA_D <= 4'b0010;   //shift left logical immediate
      7'b010010x: ALUControlA_D <= 4'b0100;   //set less than immediate
      7'b0101010: ALUControlA_D <= 4'b0100;   //shift right logical immediate
      7'b010110x: ALUControlA_D <= 4'b1000;   //or immediate
      7'b010111x: ALUControlA_D <= 4'b1001;   //and immediate
    // S Type Instructions
      7'b000000x: ALUControlA_D <= 5'b00000;  //store byte
      7'b000001x: ALUControlA_D <= 5'b00000;  //store half
      7'b000010x: ALUControlA_D <= 5'b00000 ; //store word
    // B Type Instructions  
      7'b100000x: ALUControlA_D <= 5'b00001;   //branch if =
      7'b100001x: ALUControlA_D <= 5'b00001;   //branch if not equal
      7'b100100x: ALUControlA_D <= 5'b00011;   //branch if <
      default: ALUControlA_D <= 5'b00000;
    endcase
    casex (checker2)
      // R Type instructions
      7'b00100000: ALUControlB_D <= 4'b0000;   //add (0)
      7'b00100001: ALUControlB_D <= 4'b0001;   //subtract (1)
      7'b00100100: ALUControlB_D <= 4'b0010;   //Shift Left Logical (2)
      7'b00101000: ALUControlB_D <= 4'b0011;   //Set Less than (3)
      7'b00101100: ALUControlB_D <= 4'b0100;   //Set Less unsigned (4)
      7'b00110000: ALUControlB_D <= 4'b0101;   //xor (5)
      7'b00110100: ALUControlB_D <= 4'b0110;   //Shift Right Logical (6)
      7'b00110101: ALUControlB_D <= 4'b0111;   //Shift Right Arithmetic (7)
      7'b00111000: ALUControlB_D <= 4'b1000;   //or (8)
      7'b00111100: ALUControlB_D <= 4'b1001;   //and (9)
    // Load Instructions
      7'b011000x: ALUControlB_D <= 4'b0000;   //load byte
      7'b011001x: ALUControlB_D <= 4'b0000;   //load half
      7'b011010x:  ALUControlB_D <= 4'b0000;   //load word
    // I tyoe  Instructions
      7'b010000x: ALUControlB_D <= 4'b0000;   //addi
      7'b0100010: ALUControlB_D <= 4'b0010;   //shift left logical immediate
      7'b010010x: ALUControlB_D <= 4'b0100;   //set less than immediate
      7'b0101010: ALUControlB_D <= 4'b0100;   //shift right logical immediate
      7'b010110x: ALUControlB_D <= 4'b1000;   //or immediate
      7'b010111x: ALUControlB_D <= 4'b1001;   //and immediate
    // S Type Instructions
      7'b000000x: ALUControlB_D <= 5'b00000;  //store byte
      7'b000001x: ALUControlB_D <= 5'b00000;  //store half
      7'b000010x: ALUControlB_D <= 5'b00000 ; //store word
    // B Type Instructions
      7'b100000x: ALUControlB_D <= 5'b00001;   //branch if =
      7'b100001x: ALUControlB_D <= 5'b00001;   //branch if not equal
      7'b100100x: ALUControlB_D <= 5'b00011;   //branch if <
      default: ALUControlB_D <= 5'b00000;
    endcase

  end

endmodule



module controller (
  input logic [1:0] order,
  input  logic       funct7A,funct7B,
  input  logic [6:0] OPA,funct77A,OPB,funct77B,
  input  logic [2:0] funct3A,funct3B,
  output logic [1:0] ResultSrcA_D,ResultSrcB_D,order_D,mem_modeB_D,
  output logic [2:0] ImmSrcA_D, ImmSrcB_D, AluOPA,AluOPB,
  output logic       RegWriteA_D, JumpA_D, BranchA_D, ALUSrcA_D,
  output logic RegWriteB_D, MemWriteB_D, JumpB_D, BranchB_D, ALUSrcB_D);

  parameter Byte = 2'b00;
  parameter HalfWord = 2'b01;
  parameter Word = 2'b10;


  always_comb 
  begin
 
     order_D<= order; 
     mem_modeB_D <=  2'b00; 
     casex (OPB)
      7'b0000011: begin  //lw
      BranchB_D <= 0;
      ResultSrcB_D <= 2'b01;
      MemWriteB_D <= 0;
      ALUSrcB_D <= 1;
      RegWriteB_D <= 1;
      ImmSrcB_D <= 3'b000;
      JumpB_D <= 0;
      AluOPB=3'b100;

      case (funct3B)
        000: mem_modeB_D <=  2'b00;      //Load Byte
        001: mem_modeB_D <=  HalfWord;  // Load HalfWord
        010: mem_modeB_D <=  Word;      //Load Word
      endcase        
      end

      7'b0100011:begin  //sw
      BranchB_D <= 0;
      ResultSrcB_D <= 2'bxx;
      MemWriteB_D <= 1;
      ALUSrcB_D <= 1;
      RegWriteB_D <= 0;
      ImmSrcB_D <= 3'b001;
      JumpB_D <= 0;
      AluOPB= 3'b010;

      case (funct3B)
        000: mem_modeB_D <=  2'b00;       //Store Byte
        001: mem_modeB_D <=  HalfWord;   //Store HalfWord
        010: mem_modeB_D <=  Word;       //Store Word
      endcase
      end

      7'b0110011:begin  //R-type
      BranchB_D <= 0;
      ResultSrcB_D <= 2'b00;
      MemWriteB_D <= 0;
      ALUSrcB_D <= 0;
      RegWriteB_D <= 1;
      ImmSrcB_D <= 3'bxxx;
      JumpB_D <= 0;
      AluOPB= 3'b000;

      end

      7'b1100011:begin  //branch
      BranchB_D <= 1;
      ResultSrcB_D <= 2'bxx;
      MemWriteB_D <= 0;
      ALUSrcB_D <= 0;
      RegWriteB_D <= 0;
      ImmSrcB_D <= 3'b010;
      JumpB_D <= 0;
      AluOPB= 3'b011;
      end

      7'b0010011:begin  //I-Type
      BranchB_D <= 0;
      ResultSrcB_D <= 2'b00;
      MemWriteB_D <= 0;
      ALUSrcB_D <= 1;
      RegWriteB_D <= 1;
      ImmSrcB_D <= 3'b000;
      JumpB_D <= 0;
      AluOPB= 2'b001;
      end

      7'b1101111:begin //J-Type
      BranchB_D <= 0;
      ResultSrcB_D <= 2'b10;
      MemWriteB_D <= 0;
      ALUSrcB_D <= 1'bx;
      RegWriteB_D <= 1;
      ImmSrcB_D <= 3'b011;
      JumpB_D <= 1;
      AluOPB=3'bxxx;

      end

      default:begin
      BranchB_D <= 0;
      ResultSrcB_D <= 2'b00;
      MemWriteB_D <= 0;
      ALUSrcB_D <= 1'bx;
      RegWriteB_D <= 0;
      ImmSrcB_D <= 3'b000;
      JumpB_D <= 0;       AluOPB=3'bxxx;

      end
       
    endcase
      
    casex (OPA)
//      7'b0000011: begin  //lw
//      BranchA_D <= 0;
//      ResultSrcA_D <= 2'b01;
//     // MemWriteA_D <= 0;
//      ALUSrcA_D <= 1;
//      RegWriteA_D <= 1;
//      ImmSrcA_D <= 3'b000;
//      JumpA_D <= 0;
////      case (funct3A)
////        000: mem_modeA <=  Byte;      //Load Byte
////        001: mem_modeA <=  HalfWord;  // Load HalfWord
////        010: mem_modeA <=  Word;      //Load Word
////      endcase
//      end

//      7'b0100011:begin  //sw
//      BranchA_D <= 0;
//      ResultSrcA_D <= 2'bxx;
//      //MemWriteA_D <= 1;
//      ALUSrcA_D <= 1;
//      RegWriteA_D <= 0;
//      ImmSrcA_D <= 3'b001;
//      JumpA_D <= 0;
////      case (funct3A)
////        000: mem_modeA <=  Byte;       //Store Byte
////        001: mem_modeA <=  HalfWord;   //Store HalfWord
////        010: mem_modeA <=  Word;       //Store Word
////      endcase
//      end

      7'b0110011:begin  //R-type
      BranchA_D <= 0;
      ResultSrcA_D <= 2'b00;
      //MemWriteA_D <= 0;
      ALUSrcA_D <= 0;
      RegWriteA_D <= 1;
      ImmSrcA_D <= 3'bxxx;
      JumpA_D <= 0;       AluOPA= 3'b000;

      end

      7'b1100011:begin  //branch
      BranchA_D <= 1;
      ResultSrcA_D <= 2'bxx;
      //MemWriteA_D <= 0;
      ALUSrcA_D <= 0;
      RegWriteA_D <= 0;
      ImmSrcA_D <= 3'b010;
      JumpA_D <= 0;
      AluOPA= 3'b011;

      end

      7'b0010011:begin  //I-Type
      BranchA_D <= 0;
      ResultSrcA_D <= 2'b00;
      //MemWriteA_D <= 0;
      ALUSrcA_D <= 1;
      RegWriteA_D <= 1;
      ImmSrcA_D <= 3'b000;
      JumpA_D <= 0;       AluOPA= 2'b001;

      end

      7'b1101111:begin //J-Type
      BranchA_D <= 0;
      ResultSrcA_D <= 2'b10;
     // MemWriteA_D <= 0;
      ALUSrcA_D <= 1'bx;
      RegWriteA_D <= 1;
      ImmSrcA_D <= 3'b011;
      JumpA_D <= 1;       AluOPA=3'bxxx;

      end

      default:begin
      BranchA_D <= 0;
      ResultSrcA_D <= 2'b00;
      //MemWriteA_D <= 0;
      ALUSrcA_D <= 1'bx;
      RegWriteA_D <= 0;
      ImmSrcA_D <= 3'b000;
      JumpA_D <= 0;       AluOPA=3'bxxx;

      end

    endcase

    end 
  // always_comb begin
  //     PCSrc <= Zero && Branch;
  // end
endmodule  




