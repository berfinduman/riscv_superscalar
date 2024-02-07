`timescale 1ns / 1ps

module inst_control(
    input logic [31:0] inst1,
    input logic [31:0] inst2,
    output logic [31:0] instA,
    output logic [31:0] instB,
    output hazard_control
     );


// 7'b0000011  //lw 3
//7'b0100011:begin  //sw 35
    logic [31:0] instrA, instrB;
    always_comb begin
    if(stallonlyD)
    begin
        B1      = instr2 [19:15];     
        B2      = instr2 [24:20];
        Rs1B_D    = instr2 [19:15];
        Rs2B_D    = instr2 [24:20];
        RdB_D     = instr2 [11:7];
        ImmB_D    = instr2 [31:7];
        OPB      = instr2 [6:0];
        funct3B  = instr2 [14:12];
        funct77B = instr2 [31:25];
        funct7B  = instr2 [30];
        hazard_flag=1'b0; 
        
        
        A1      = 5'b0;     
        A2      = 5'b0; 
        Rs1A_D    = 5'b0; 
        Rs2A_D    = 5'b0; 
        RdA_D     = 5'b0; 
        ImmA_D    =25'b0; 
        OPA      = 7'b0; 
        funct3A  = 3'b0; 
        funct77A = 7'b0; 
        funct7A  = 1'b0; 
        
    end
    else
    begin
    
    if (((instr1[6:0] == 7'b0000011) || (instr1[6:0] == 7'b0100011)) && ((instr2[6:0] != 7'b0000011) || (instr2[6:0]!= 7'b0100011)))
    begin
    //!!! HAZARD
    order<= 01;
    hazard_flag=1; 
    end 

    else if (( instr1 [11:7] == instr2 [19:15]) || ( instr1 [11:7] == instr2 [24:20]) ) //HAZARD
    begin 
    hazard_flag=1; 
    order<= 01; 
    end 
    
    else if ((instr1[6:0] == 7'b1100011) || (instr1[6:0] == 7'b1101111)) //HAZARD
    begin 
    hazard_flag=1; 
    order<= 01; 
    end 
    
    else if ((instr1[6:0] == 7'b0000011) || (instr1[6:0] == 7'b0100011))
    begin 
    instrA<= instr2;
    instrB<= instr1;
    order<= 10; 
    hazard_flag=1'b0; 

    end 
    else 
    begin  //if ((instr2[6:0] == 7'b0000011) || (instr2[6:0] == 7'b0100011))
    instrA<= instr1;
    instrB<= instr2;
    order<= 00; 
    hazard_flag=1'b0; 

    end
    end 


   end

always_comb
begin 
    if (!stallonlyD)
    begin
    if (hazard_flag)
    begin 
        B1      = instr1 [19:15];     
        B2      = instr1 [24:20];
        Rs1B_D    = instr1 [19:15];
        Rs2B_D    = instr1 [24:20];
        RdB_D     = instr1 [11:7];
        ImmB_D    = instr1 [31:7];
        OPB      = instr1 [6:0];
        funct3B  = instr1 [14:12];
        funct77B = instr1 [31:25];
        funct7B  = instr1 [30];
        hazard_flag=1'b0; 
        A1      = 5'b0;     
        A2      = 5'b0; 
        Rs1A_D    = 5'b0; 
        Rs2A_D    = 5'b0; 
        RdA_D     = 5'b0; 
        ImmA_D    =25'b0; 
        OPA      = 7'b0; 
        funct3A  = 3'b0; 
        funct77A = 7'b0; 
        funct7A  = 1'b0; 

    end 
    else 
    begin 
        A1      = instr1 [19:15];     
        A2      = instr1 [24:20];
        Rs1A_D    = instr1 [19:15];
        Rs2A_D    = instr1 [24:20];
        RdA_D     = instr1 [11:7];
        ImmA_D    = instr1 [31:7];
        OPA      = instr1 [6:0];
        funct3A  = instr1 [14:12];
        funct77A = instr1 [31:25];
        funct7A  = instr1 [30];
    
    
        B1      = instr2 [19:15];     
        B2      = instr2 [24:20];
        Rs1B_D    = instr2 [19:15];
        Rs2B_D    = instr2 [24:20];
        RdB_D     = instr2 [11:7];
        ImmB_D    = instr2 [31:7];
        OPB      = instr2 [6:0];
        funct3B  = instr2 [14:12];
        funct77B = instr2 [31:25];
        funct7B  = instr2 [30];
    end 
end
end 
endmodule

    
