module test (clk, reset, hex);
input clk;
input reset;
output [6:0] hex;
reg [6:0] hex1;
parameter one = 7'b1111001;
	parameter two = 7'b0100100;
	parameter three = 7'b0110000;
	parameter four = 7'b0011001;
	parameter five = 7'b0010010;
	parameter six = 7'b0000010;
	parameter seven = 7'b1111000;
	parameter eight = 7'b0000000;
	parameter nine = 7'b0011000;
	parameter pl = 7'b0000110;
	parameter al = 7'b0000010;
	parameter sl = 7'b0001001;
	parameter blank = 7'b1111111;


integer iii=0;

integer dem =0;

always @( posedge clk)begin
if (reset) begin
	if (dem <2) begin
			case(iii)
				0: begin
					hex1 <= eight;
					iii <= iii + 1;
				end
				1: begin 
					hex1<= blank;
					iii <= iii - 1;
				end
			endcase
			dem = dem +1;
			end
			else dem =0;
end
else begin dem =0;
	
end 
end

assign hex = hex1;			
			













endmodule
