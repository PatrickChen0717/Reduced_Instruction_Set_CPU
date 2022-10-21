module InstructionDecoder (in,sh,opcode,numout,op,nsel,im8,im5);
 input [15:0] in;
 input [2:0] nsel;
 output [2:0] opcode;
 output reg [2:0] numout;
 output [1:0] op;
 output reg [1:0] sh;
 output reg [15:0] im8,im5;
 
 assign opcode=in[15:13];
 assign op=in[12:11];
 reg [2:0] rn;
 reg [2:0] rd;
 reg [2:0] rm;
 
 

 always @(*) begin
  if(op==2'b10&&opcode==3'b110)begin
   im8=in[7:0];
   if(im8[7]==1'b1) 
    im8[15:8]={8{1'b1}};
   else if(im8[7]==1'b0) 
    im8[15:8]={8{1'b0}};
   rn=in[10:8];
   rd=3'bxxx;
   sh=2'bxx;
   rm=3'bxxx;
  end
  else if(op==2'b00&&opcode==3'b110)begin
   im8={16{1'bx}};
   rn=3'b000;
   rd=in[7:5];
   sh=in[4:3];
   rm=in[2:0];
  end
  else if(op==2'b00&&opcode==3'b101)begin
   im8={16{1'bx}};
   rn=in[10:8];
   rd=in[7:5];
   sh=in[4:3];
   rm=in[2:0];
  end
  else if(op==2'b01&&opcode==3'b101)begin
   im8={16{1'bx}};
   rn=in[10:8];
   rd=3'b000;
   sh=in[4:3];
   rm=in[2:0];
  end
  else if(op==2'b10&&opcode==3'b101)begin
   im8={16{1'bx}};
   rn=in[10:8];
   rd=in[7:5];
   sh=in[4:3];
   rm=in[2:0];
  end
  else if(op==2'b11&&opcode==3'b101)begin
   im8={16{1'bx}};
   rn=3'b000;
   rd=in[7:5];
   sh=in[4:3];
   rm=in[2:0];
  end
  else begin
   im8={16{1'bx}};
   rn=3'bxxx;
   rd=3'bxxx;
   sh=2'bxx;
   rm=3'bxxx;
  end
 end


 always @(*) begin
  if(nsel==3'b100)
   numout=rn;
  else if(nsel==3'b010)
   numout=rd;
  else if(nsel==3'b001)
   numout=rm;
  else
   numout=3'bxxx;
 end
 

endmodule
