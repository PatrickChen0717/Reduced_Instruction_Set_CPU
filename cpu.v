module cpu (
    clk,
    reset,
    s,
    load,
    in,out,N,V,Z,w
);
    input clk,reset,s,load;
    input [15:0] in;// instruction that we take into the datapath
    output [15:0] out;
    output N,V,Z,w;


//---------------------------------------// connections 



    wire [15:0] reg_to_Decoder;         // InstructionRegister
    wire [2:0] opcode;                  // InstructionDecoder
    wire [1:0] op;                      // InstructionDecoder
    wire [2:0] nsel;                    // FSM
    wire [2:0] numout;                  // InstructionDecoder
    wire  loada,loadb,loadc,asel,bsel,write,w,loads; //FSM              
    wire  [1:0] vsel;                   //FSM
    wire [15:0] imm8,imm5;              // InstructionDecoder
    wire [1:0] sh;                      // InstructionDecoder
    wire [15:0] out;                    // DP
    wire Z_out,V_out,N_out;             // DP
    

InstructionRegister DUT1(in,load,reg_to_Decoder,clk);
InstructionDecoder  DUT2 (reg_to_Decoder,sh,opcode,numout,op,nsel,imm8,imm5);   // nsel is input 
CFSM  DUT3 (clk,s,reset,opcode,op,nsel,w,loada,loadb,write,loadc,vsel,asel,bsel,loads);



datapath DP (.datapath_in(imm8), .vsel(vsel), .writenum(numout), .write(write), .readnum(numout), 
             .clk(clk), .loada(loada), .loadb(loadb), .loadc(loadc), .loads(loads), .shift(sh),
             .asel(asel), .bsel(bsel), .ALUop(op), .datapath_out(out), .Z_out(Z), .V_out(V),
             .N_out(N)
             );
   




endmodule
