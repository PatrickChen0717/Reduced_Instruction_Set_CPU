
module datapath (datapath_in,vsel,writenum,write,readnum,clk,loada,loadb,loadc,loads,shift,asel,bsel,ALUop,datapath_out,Z_out,V_out,N_out);
input [15:0] datapath_in;
input [1:0] vsel;
input [2:0] writenum;
input write;
input [2:0] readnum;
input clk;
input loada;
input loadb;
input [1:0] shift;
input asel;
input bsel;
input [1:0] ALUop;
input loadc;
input loads;
output Z_out;
output  [15:0] datapath_out;
reg [15:0] mdata={16{1'b0}};
reg [15:0] PC={16{1'b0}};
///
wire [15:0] sximm5={16{1'b0}};
///



wire [15:0] wire9_1;
wire [15:0] wire1_3_4;
wire [15:0] wire3_6;
wire [15:0] wire4_8;
wire [15:0] wire8_7;
wire [15:0] wire6_2;
wire [15:0] wire7_2;
wire wire2_10;
wire [15:0] wire2_5;
wire [15:0] wire5_9;
wire [15:0] bselin;
wire [15:0] aselin={16{1'b0}};
wire wire2_11,wire2_12;
output V_out,N_out;
//assign bselin={{11{1'b0}},datapath_in[4:0]};
assign datapath_out=wire5_9;

muxstart  DUT1(mdata,datapath_in,PC,wire5_9,vsel,wire9_1);
regfile REGFILE(wire9_1,writenum,write,readnum,clk,wire1_3_4);
load1 DUT3(wire1_3_4,wire3_6,loada,clk); // A
load1 DUT4(wire1_3_4,wire4_8,loadb,clk); //B
shifter DUT5(wire4_8,shift,wire8_7);
mux DUT6(wire3_6,aselin,wire6_2,asel);
mux DUT7(wire8_7,sximm5,wire7_2,bsel);
ALU DUT8(wire6_2,wire7_2,ALUop,wire2_5,wire2_10,wire2_11,wire2_12);
load1 DUT9(wire2_5,wire5_9,loadc,clk);
load2 DUT10(wire2_10,Z_out,loads,clk);
load2 DUT11(wire2_11,V_out,loads,clk);
load2 DUT12(wire2_12,N_out,loads,clk);



endmodule


module load1 (in,out,load,clk);//3,4,5
	parameter n=16;
	input [n-1:0] in;
	input load,clk;
	output reg [n-1:0] out;
	reg [n-1:0] temp;

	always @(*) begin
		temp={n{1'bx}};
		if(load==1'b1)
			temp=in;
		else if(load==1'b0)
			temp=out;
	end

	always @(posedge clk) begin
		out=temp;
	end

endmodule

module load2(in,out,load,clk);//10
	input in;
	input load,clk;
	output reg  out;
	reg  temp;

	always @(*) begin
		temp=1'b0;
		if(load==1'b1)
			temp=in;
		else if(load==1'b0)
			temp=out;
	end

	always @(posedge clk) begin
		out=temp;
	end

endmodule

module mux(Ain,Bin,out,sel);//6,7,9
	//sel=0,pick Ain
	//sel=1,pick Bin
	parameter n=16;
	input [n-1:0] Ain,Bin;
	input sel;
	output reg [n-1:0] out;
	
	always @(*) begin
		out={n{1'bx}};
		if(sel==1'b0)
			out=Ain;
		else if(sel==1'b1)
			out=Bin;
	end

endmodule



module muxstart(mdata,sximm8,PC,C,vsel,out);
 input [15:0] sximm8;
 input [15:0] mdata,PC;
 input [15:0] C;
 input [1:0] vsel;
 output reg [15:0] out;

 always @(*) begin
  if(vsel==2'b00)
   out=mdata;
  else if(vsel==2'b01)
   out=sximm8;
  else if(vsel==2'b10)
   out=PC;
  else if(vsel==2'b11)
   out=C;
  else
   out={16{1'bx}};

 end
endmodule


/*
module ALU(Ain,Bin,ALUop,out,Z,ovf,N);//2
	input [1:0] ALUop;
	input [15:0] Ain, Bin;
	output reg [15:0] out;
	output reg Z, N;
	output reg ovf;
	reg [16:0] temp={17{1'b0}};
	

	always @(*) begin
		out=16'bxxxxxxxxxxxxxxxx;
		if(ALUop==2'b00) begin
			out=Ain+Bin;
			temp=Ain+Bin;
		end
		else if(ALUop==2'b01)
			out=Ain-Bin;
		else if(ALUop==2'b10) 
			out=Ain&Bin;
		else if(ALUop==2'b11) 
			out=~Bin;
	end
	always @(out) begin
		if(out==16'b0000000000000000)
			Z=1'b1;
		else 
			Z=1'b0;
	end

	always @(out) begin
		if(temp[16]==1'b1)
			ovf=1'b1;
		else 
			ovf=1'b0;
	end
	
	always @(out) begin
		if(out[15]==1'b1)
			N=1'b1;
		else 
			N=1'b0;
	end


endmodule

*/