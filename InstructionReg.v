module InstructionRegister(in,load,out,clk);
	input [15:0]in;
	input load,clk;
	output reg [15:0]out;
	reg [15:0] temp;

	always @(*) begin
		temp={16{1'b0}};
		if(load==1'b1)
			temp=in;
		else if(load==1'b0)
			temp=out;
	end

	always @(posedge clk) begin
		out=temp;
	end


endmodule
