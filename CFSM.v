module CFSM (clk,s,reset,opcode,op,nsel,w,loada,loadb,write,loadc,vsel,asel,bsel,loads);
input clk,s,reset;
input [2:0] opcode;
input [1:0] op;
output  loada,loadb,loadc,asel,bsel,write,loads; 
output reg w;
output  [2:0] nsel;
output  [1:0] vsel;

//state edncoidng 
`define Sw 4'b0000  //wait state
`define Sa1 4'b0001 //state 1 for add  read Rn   for min, for bitwise and , for add 

`define Sn1 4'b1011 //state 1 for the Mvn oprations nsel=001 loada=1 
`define Sn3 4'b0111 //state 3 for not opration  asel=1 bsel=0 loadc=1

`define Sa2 4'b0010 //state 2 for add  read Rm    for ADD, for bitwise and ,for MVN ,for min

`define Sa3 4'b0011 //state 3 for add  do ALU      for min
`define Sa4 4'b0100 //state 4 for add  writeback   for bitwiseand for MOV without the imm ,vsel=11 nsel=010 write=2
`define Sm4 4'b0101 //state 4 for Minus nsel=100 vsel=11 wirte=1
`define Sn3 4'b0111 //state 3 for not opration  asel=1 bsel=0 loadc=1


`define SC1 4'b1000 //state 1 for the MOV without imm nsel=001 loadb1 
`define SC2 4'b1001 //state 2 for the MOV without the asel=1 bsel=0 




wire [3:0] present_state,state_next_or_reset,next_state;
reg  [15:0] next;
vDFF12 #(4) State(clk,state_next_or_reset,present_state);

assign state_next_or_reset= reset ? `Sw: next_state;


always @(*) begin
    casex({present_state,opcode,op,s})
        
          
        {`Sw, 3'bxxx,2'bxx,1'b0}:  next= {`Sw,  12'b000000000000};  //PS:wair for the signal S to be set to 1

        {`Sw, 3'b101,2'b00,1'bx}:  next= {`Sa1, 12'b000000000000}; // after the s set to 1
        {`Sw, 3'b101,2'b01,1'bx}:  next= {`Sa1, 12'b000000000000}; // same state A for the ADD CMP AND oprations 
        {`Sw, 3'b101,2'b10,1'bx}:  next= {`Sa1, 12'b000000000000}; // same state A for the ADD CMP AND oprations
        {`Sw, 3'b101,2'b11,1'bx}:  next= {`Sn1, 12'b000000000000}; // next state for the MVN oprations 
        {`Sw, 3'b110,2'b10,1'bx}:  next= {`Sa4, 12'b000000000000}; //next state is the MOV with the imm 
        {`Sw, 3'b110,2'b00,1'bx}:  next= {`SC1, 12'b000000000000}; // next state is the MOV without the imm
        
             
        {`Sa1,3'b101,2'b00,1'bx}:  next= {`Sa2, 12'b100100000000}; //PS out: nsel=100 loada=1    read Rn  next state  for read Rm 00
        {`Sa1,3'b101,2'b01,1'bx}:  next= {`Sa2, 12'b100100000000}; //PS out: nsel=100 loada=1    read Rn  next state for read Rm 01
        {`Sa1,3'b101,2'b10,1'bx}:  next= {`Sa2, 12'b100100000000}; //PS out: nsel=100 loada=1    read Rn  next state for read Rm 10
        {`Sn1,3'b101,2'b11,1'bx}:  next= {`Sa2, 12'b001100000000}; //PS out: nsel=001 loada=1    read Rm  next state  for read Rm 11 
        {`SC1,3'b110,2'b00,1'bx}:  next= {`SC2, 12'b001100000000}; //PS out: nsel=001 load=1 read from Rm next state for the MOv with00




        {`Sa2,3'b101,2'b00,1'bx}:  next= {`Sa3, 12'b001010000000}; //PS out: nsel=001 loadb=1    read Rm  next state for ALU 00     
        {`Sa2,3'b101,2'b01,1'bx}:  next= {`Sa3, 12'b001010000000}; //PS out: nsel=001 loadb=1    read Rm  next state for ALU 01     
        {`Sa2,3'b101,2'b10,1'bx}:  next= {`Sa3, 12'b001010000000}; //PS out: nsel=001 loadb=1    read Rm  next state for ALU 10     
        {`Sa2,3'b101,2'b11,1'bx}:  next= {`Sn3, 12'b001010000000}; //PS out: nsel=001 loadb=1    read Rm  next state for ALU 11  
        {`SC2,3'b110,2'b00,1'bx}:  next= {`Sa3, 12'b001010000000}; //PS out: nsle=001 loadb=1    read Rm  next state for MOV without the imm
    
        {`Sa3,3'b101,2'b00,1'bx}:  next= {`Sa4, 12'b000001000001}; //PS out: asel=0 bsel=0 loadc=1 loads=1 DOALU next state for the write back 00
        {`Sa3,3'b101,2'b01,1'bx}:  next= {`Sa4, 12'b000001000001}; //PS out: asel=0 bsel=0 loadc=1 loads=1 DOALU next state for the write back 01
        {`Sa3,3'b101,2'b10,1'bx}:  next= {`Sa4, 12'b000001000001}; //PS out: asel=0 bsel=0 loadc=1 loads=1 DOALU next state for the write back 10
        {`Sn3,3'b101,2'b11,1'bx}:  next= {`Sa4, 12'b000001100001}; //PS out: asel=1 bsel=0 loadc=1 loads=1 DOALU next state for the write back 11  
        {`Sa3,3'b110,2'b00,1'bx}:  next= {`Sa4, 12'b000001100001}; //PS out: asel=1 bsel=0 loadc=1 loads=1 DOALU for the MOV without the imm


        {`Sa4,3'b101,2'b00,1'bx}:  next= {`Sw,  12'b010000001110}; //PS out: nsel=010 vsel=11 write=1 write the data back to the destination register Rd 00
        {`Sa4,3'b101,2'b01,1'bx}:  next= {`Sw,  12'b100000000110}; //PS out: nsel=100 vsel=11 write=0 wirte the data back to the Rn  01
        {`Sa4,3'b101,2'b10,1'bx}:  next= {`Sw,  12'b010000001110}; //PS out: nsel=010 vsel=11 write=1 write the data back to the destination register   10
        {`Sa4,3'b101,2'b11,1'bx}:  next= {`Sw,  12'b010000001110}; //PS out: nsel=010 vsel=11 write=1 write the data back to the destination register 11
        {`Sa4,3'b110,2'b00,1'bx}:  next= {`Sw,  12'b010000001110}; //PS out: nsel=010 vsel=11 write=1 wirte the data back ot the destination register For MOV without the imm
        {`Sa4,3'b110,2'b10,1'bx}:  next= {`Sw,  12'b100000001010};  //PS out: nsel=100 write=1  vsel=01 ,write into Rn select from the datapath_in 
        default:  next={{4{1'bx}},{12{1'bx}}};
    endcase

end
always @(*) begin
    casex ({present_state,s})
       {`Sw,1'b0}: w=1'b1;
        default: w=1'b0;
    endcase
end

 assign {next_state,nsel,loada,loadb,loadc,asel,bsel,write,vsel,loads}=next;

endmodule




module vDFF12 (clk,state_next_or_reset,present_state);
parameter n =4;
input clk;
input [n-1:0] state_next_or_reset;
output [n-1:0] present_state;
reg [n-1:0] present_state;
always @(posedge clk) begin
    present_state=state_next_or_reset;
end
    

endmodule
    



