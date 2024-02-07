module instruction_fetch ( 
    input logic stallonlyD, 
    input  logic [31:0] instr1D, instr2D,
    output logic [4:0]  A1, A2, Rs1A_D, Rs2A_D, RdA_D, B1, B2, Rs1B_D, Rs2B_D, RdB_D,
    output logic [24:0] ImmA_D, ImmB_D,
    output logic [6:0]  OPA, OPB,
    output logic [2:0]  funct3A, funct3B,
    output logic        funct7A, funct7B,
    output logic [6:0]  funct77A,funct77B,
    output logic [1:0] order,
    output logic hazard_flag
);
 
// 7'b0000011  //lw 3
//7'b0100011:begin  //sw 35
    always_comb begin

    if(!stallonlyD)
    begin
    
    if (((instr1D[6:0] == 7'b0000011) || (instr1D[6:0] == 7'b0100011)) && ((instr2D[6:0] == 7'b0000011) || (instr2D[6:0]== 7'b0100011))) //iki instructionda load, sw ise 
    begin
    //!!! HAZARD
    hazard_flag<=1'b1; 
    order<= 01;

    B1      <= instr1D [19:15];     
    B2      <= instr1D [24:20];
    Rs1B_D    <= instr1D [19:15];
    Rs2B_D    <= instr1D [24:20];
    RdB_D     <= instr1D [11:7];
    ImmB_D    <= instr1D [31:7];
    OPB      <= instr1D [6:0];
    funct3B  <= instr1D [14:12];
    funct77B <= instr1D [31:25];
    funct7B  <= instr1D [30];
    A1      <= 5'b0;     
    A2      <= 5'b0; 
    Rs1A_D    <= 5'b0; 
    Rs2A_D    <= 5'b0; 
    RdA_D     <= 5'b0; 
    ImmA_D   <=25'b0; 
    OPA      <= 7'b0; 
    funct3A  <= 3'b0; 
    funct77A <= 7'b0; 
    funct7A  <= 1'b0;
    end 
    else if ((instr1D!=0)  &&  (( instr1D [11:7] == instr2D [19:15]) || ( instr1D [11:7] == instr2D [24:20]))) //HAZARD
    begin 
    
    order<= 01; 
    hazard_flag<=1'b1; 
    B1      <= instr1D [19:15];     
    B2      <= instr1D [24:20];
    Rs1B_D    <= instr1D [19:15];
    Rs2B_D    <= instr1D [24:20];
    RdB_D     <= instr1D [11:7];
    ImmB_D    <= instr1D [31:7];
    OPB      <= instr1D [6:0];
    funct3B  <= instr1D [14:12];
    funct77B <= instr1D [31:25];
    funct7B  <= instr1D [30];
    A1      <= 5'b0;     
    A2      <= 5'b0; 
    Rs1A_D    <= 5'b0; 
    Rs2A_D    <= 5'b0; 
    RdA_D     <= 5'b0; 
    ImmA_D   <=25'b0; 
    OPA      <= 7'b0; 
    funct3A  <= 3'b0; 
    funct77A <= 7'b0; 
    funct7A  <= 1'b0;
    end
    else if ((instr1D == 7'b1100011) || (instr1D[6:0] == 7'b1101111)) //HAZARD beq
    begin 
   
    hazard_flag=1'b1; 
    order= 01; 
    B1      <= instr1D [19:15];     
    B2      <= instr1D [24:20];
    Rs1B_D    <= instr1D [19:15];
    Rs2B_D    <= instr1D [24:20];
    RdB_D     <= instr1D [11:7];
    ImmB_D    <= instr1D [31:7];
    OPB      <= instr1D [6:0];
    funct3B  <= instr1D [14:12];
    funct77B <= instr1D [31:25];
    funct7B  <= instr1D [30];
    A1      <= 5'b0;     
    A2      <= 5'b0; 
    Rs1A_D    <= 5'b0; 
    Rs2A_D    <= 5'b0; 
    RdA_D     <= 5'b0; 
    ImmA_D   <=25'b0; 
    OPA      <= 7'b0; 
    funct3A  <= 3'b0; 
    funct77A <= 7'b0; 
    funct7A  <= 1'b0;
    end 
    
    else if ((instr1D[6:0] == 7'b0000011) || (instr1D[6:0] == 7'b0100011)) //eðer ilk instruction load ise 
    begin 

    order<= 10; 
    hazard_flag=1'b0; 
        B1        <= instr1D [19:15];     
        B2        <= instr1D [24:20];
        Rs1B_D    <= instr1D [19:15];
        Rs2B_D    <= instr1D [24:20];
        RdB_D     <= instr1D [11:7];
        ImmB_D    <= instr1D [31:7];
        OPB       <=  instr1D [6:0];
        funct3B   <=  instr1D [14:12];
        funct77B  <=  instr1D [31:25];
        funct7B   <=  instr1D [30];
    
    
        A1        <=   instr2D [19:15];     
        A2        <=   instr2D [24:20];
        Rs1A_D    <= instr2D [19:15];
        Rs2A_D    <= instr2D [24:20];
        RdA_D     <= instr2D [11:7];
        ImmA_D    <= instr2D [31:7];
        OPA      <=  instr2D [6:0];
        funct3A   <=  instr2D [14:12];
        funct77A  <=  instr2D [31:25];
        funct7A   <=  instr2D [30];
    end 
    else 
    begin  //if ((instr2[6:0] == 7'b0000011) || (instr2[6:0] == 7'b0100011))

        order<= 00; 
        //order<=11;
        hazard_flag<=1'b0; 
        A1        <= instr1D [19:15];     
        A2        <= instr1D [24:20];
        Rs1A_D    <= instr1D [19:15];
        Rs2A_D    <= instr1D [24:20];
        RdA_D     <= instr1D [11:7];
        ImmA_D    <= instr1D [31:7];
        OPA       <=  instr1D [6:0];
        funct3A   <=  instr1D [14:12];
        funct77A  <=  instr1D [31:25];
        funct7A   <=  instr1D [30];
    
    
        B1        <=   instr2D [19:15];     
        B2        <=   instr2D [24:20];
        Rs1B_D    <= instr2D [19:15];
        Rs2B_D    <= instr2D [24:20];
        RdB_D     <= instr2D [11:7];
        ImmB_D    <= instr2D [31:7];
        OPB       <=  instr2D [6:0];
        funct3B   <=  instr2D [14:12];
        funct77B  <=  instr2D [31:25];
        funct7B   <=  instr2D [30];
    end
    end
    else
    begin 
        hazard_flag<=1'b0; 
        B1      <= instr2D [19:15];     
        B2      <= instr2D [24:20];
        Rs1B_D    <= instr2D [19:15];
        Rs2B_D    <= instr2D [24:20];
        RdB_D     <= instr2D [11:7];
        ImmB_D    <= instr2D [31:7];
        OPB      <= instr2D [6:0];
        funct3B  <= instr2D [14:12];
        funct77B <= instr2D [31:25];
        funct7B  <= instr2D [30];
        
        
        
        A1      <= 5'b0;     
        A2      <= 5'b0; 
        Rs1A_D    <= 5'b0; 
        Rs2A_D    <= 5'b0; 
        RdA_D     <= 5'b0; 
        ImmA_D    <=25'b0; 
        OPA      <= 7'b0; 
        funct3A  <= 3'b0; 
        funct77A <= 7'b0; 
        funct7A  <= 1'b0; 
        
    end 
    


   end





endmodule

    
