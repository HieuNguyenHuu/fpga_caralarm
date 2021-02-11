module seg7_run(HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,clk,select_seg,
check_pass,enableir,input_string,reset,CLOCK_50,IRDA_RXD,checkremote);
input checkremote;
input CLOCK_50;
input reset;
input IRDA_RXD;
input clk;
//input [31:0] hex_data;
input enableir;
input [2:0] select_seg;
output reg [1:0] check_pass;
output reg  [4*8-1:0] input_string;     
output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
parameter zero = 7'b1000000;
integer t=0;
	parameter one = 7'b1111001;
	parameter two = 7'b0100100;
	parameter three = 7'b0110000;
	parameter four = 7'b0011001;
	parameter five = 7'b0010010;
	parameter six = 7'b0000010;
	parameter seven = 7'b1111000;
	parameter eight = 7'b0000000;
	parameter nine = 7'b0011000;
	parameter pl = 7'b0001100;
	parameter al = 7'b0001000;
	parameter sl = 7'b0010010;
	parameter blank = 7'b1111111;
	reg [6:0] hex;
	reg [6:0] hex1;
	reg [6:0] hex2;
	reg [6:0] hex3;
	reg [6:0] hex4;
	reg [6:0] hex5;
	reg [6:0] hex6;
	reg [6:0] hex7;
	reg [6:0] hex8;
	reg [6:0] hex9;
	reg [6:0] hex10;
	reg [6:0] hexarray [4:0];
	reg [6:0] hexarrayt [4:0];
	reg [6:0] hexarrayck [4:0];
	reg [6:0] hextemp = blank;
	reg [6:0] hex_out;
	integer ii;
	integer i=0;
	always @(posedge clk)
		begin
			case(i)
				0: begin
					hex <= eight;
					i <= i + 1;
				end
				1: begin 
					hex <= blank;
					i <= 0;
				end
			endcase
		end
	integer iii=0;

integer dem =0;

always @( posedge clk)begin
if ((select_seg == 3'b010)) begin
	if (dem < 3) begin
			case(iii)
				0: begin
					
					hex1 = blank;
					iii = iii + 1;
				end
				1: begin 
					hex1 = eight;
					iii = iii - 1;
					dem = dem + 1;
				end
			endcase
			end
	else begin hex1 = blank; end
end
	else begin dem =0; hex1 = blank;
end 
end







	//
	/*genvar demmm;
	generate 
	for (demmm =0; demmm <2; demmm =demmm+1)
	begin
	integer dem = 0;
	always @( posedge clk)begin
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
			end
		end
	endgenerate*/


integer iss =0;
reg [6:0] Hex1s;
	always@(posedge clk) begin
	if (check_pass == 2'b11)
	begin
	case(iss)
		0:		begin
				Hex1s <= zero;
				iss = iss +1;
				end
		1:		begin
				Hex1s <= one;
				iss = iss +1;
				end
		2:		begin
				Hex1s <= two;
				iss = iss +1;
				end
		3:		begin
				Hex1s <= three;
				iss = iss +1;
				end
		4:		begin
				Hex1s <= four;
				iss = iss +1;
				end
		5:		begin
				Hex1s <= five;iss = iss +1;
				end
		6:		begin
				Hex1s <= six;
				iss = iss +1;
				end
		7:		begin
				Hex1s <= seven;
				iss = iss +1;
				end
		8:		begin
				Hex1s <= eight;iss = iss +1;
				end
		9:		begin
				Hex1s <= nine;iss = iss +1;
				end
		10:   begin
				Hex1s <= zero;
				end
	endcase
end
else iss = 0;
end



	
	wire data_ready;
	wire  [31:0] hex_data; 
	IR_RECEIVE u2(
					///clk 50MHz////
					.iCLK(CLOCK_50), 
					//reset          
					.iRST_n(1'b1),        
					//IRDA code input
					.iIRDA(IRDA_RXD), 
					//read command      
					//.iREAD(data_read),
					//data ready      					
					.oDATA_READY(data_ready),
					//decoded data 32bit
					.oDATA(hex_data)        
					);		
integer iis =0;
integer iisck =0;
always@(negedge data_ready)begin 
	//if (select_seg == 3'b100) begin
			if (checkremote == 1'b0)
			begin
				hextemp = blank;
					hexarray[4] <= hextemp;
					hexarray[3] <= hextemp;
					hexarray[2] <= hextemp;
					hexarray[1] <= hextemp;
					hexarray[0] <= hextemp;
					hexarrayck[4] <= hextemp;
					hexarrayck[3] <= two;
					hexarrayck[2] <= five;
					hexarrayck[1] <= four;
					hexarrayck[0] <= one;
					hexarrayt[4] <= hextemp;
					hexarrayt[3] <= hextemp;
					hexarrayt[2] <= hextemp;
					hexarrayt[1] <= hextemp;
					hexarrayt[0] <= hextemp;
				ii=0;	
				iis=0;
				iisck =0;
				check_pass = 2'b00;
			end
			else
			if ((ii < 4)) begin
			case(hex_data[23:16])
				8'h00: begin
					input_string[ii] = "0";
					//ii =ii +1;
					hextemp= zero;
					/*hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;*/
					
				end

				8'h01: begin
					input_string[ii] = "1";
					//ii =ii +1;
					hextemp= one;
					/*hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;*/
				end

				8'h02: begin
					input_string[ii] = "2";
					//ii =ii +1;
					hextemp= two;
					/*hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;*/
				end

				8'h03: begin
					input_string[ii] = "3";
					//ii =ii +1;
					hextemp= three;
					/*hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;*/
				end

				8'h04: begin
					input_string[ii] = "4";
					//ii =ii +1;
					hextemp= four;
					/*hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;*/
				end

				8'h05: begin
					input_string[ii] = "5";
					//ii =ii +1;
					hextemp= five;
					/*hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;*/
				end
				8'h06: begin
					input_string[ii] = "6";
					//ii =ii +1;
					hextemp= six;
					/*hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;*/
				end

				8'h07: begin
					input_string[ii] = "7";
					//ii =ii +1;
					hextemp= seven;
					/*hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;*/
				end

				8'h08: begin
					input_string[ii] = "8";
					//ii =ii +1;
					hextemp= eight;
					/*hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;*/
				end

				8'h09: begin
					input_string[ii] = "9";
					//ii =ii +1;
					hextemp= nine;
					/*hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
					ii = ii+1;*/
				end
				default: begin
					hextemp = blank;
					hexarray[4] <= hextemp;
					hexarray[3] <= hextemp;
					hexarray[2] <= hextemp;
					hexarray[1] <= hextemp;
					hexarray[0] <= hextemp;
					hexarrayt[4] <= hextemp;
					hexarrayt[3] <= hextemp;
					hexarrayt[2] <= hextemp;
					hexarrayt[1] <= hextemp;
					hexarrayt[0] <= hextemp;
				end
			endcase
				hexarray[ii] <= eight;
				hexarrayt[ii] <= hextemp;
					ii = ii+1;
			end
			else begin
				case(hex_data[23:16])
				8'h1E: begin
					d=1;
					
				end
				8'h1A: begin
					for (iis =0; iis <4; iis = iis +1)
					begin
						if (hexarrayt[iis] == hexarrayck[iis]) 
						iisck = iisck+1;
					end
					if (iisck >= 3) begin
						d=1;
						check_pass = 2'b01;
					end
					else begin
					hextemp = blank;
					hexarray[4] <= hextemp;
					hexarray[3] <= hextemp;
					hexarray[2] <= hextemp;
					hexarray[1] <= hextemp;
					hexarray[0] <= hextemp;
					hexarrayt[4] <= hextemp;
					hexarrayt[3] <= hextemp;
					hexarrayt[2] <= hextemp;
					hexarrayt[1] <= hextemp;
					hexarrayt[0] <= hextemp;
					ii=0;	
					iis=0;
					iisck =0;
					check_pass = 2'b10;
					d=3;
					end
					
				end
				8'h16:begin
					if(check_pass ==2'b01) begin
						d=2;
						check_pass = 2'b11;
					end
				
				end
				default: begin
					d=3;
				
				end
				endcase
			end
		end
	//end
	
	integer d=0;
always @(*)
begin
case(select_seg)
	3'b000:
	begin
		t=0;
		hex_out = blank;
	end
	3'b001:
	begin
	t=0;
		hex_out = hex;
	end
	3'b010:
	begin
	t=0;
		hex_out = hex1;
	end
	3'b011:
	begin
	t=0;
		hex_out = blank;
	end
	3'b100:
	begin
		//t=1;
		hex2 = pl;
		hex3 = al;
		hex4 = sl;
		hex5 = sl;
		if (d==1) t = 1;
		else if (d==2) t=3;
		else t =4;
		
		
		/*for(d =0 ;d <4; d= d+1) begin
			hexarrayt[d] = blank;
			hexarray[d] = blank;
		
		end*/
		
		
		
		
		/*case(hex_data[23:16])
				8'h01: begin
					hextemp <= one;
				end
				8'h00: begin
					hextemp <= zero;
				end
				default: begin
					hextemp <= blank;
				end
		endcase
		hexarrayt[0] = hextemp;
		hexarrayt[1] = hextemp;
		hexarrayt[2] = hextemp;
		hexarrayt[3] = hextemp;*/
		
		/*hex6 <= eight;
		hex7 <= eight;
		hex8 <= eight;
		hex9 <= eight;*/
		
		/*if (ii < 4) begin
			case(hex_data[23:16])
				8'h00: begin
					input_string[ii] = "0";
					//ii =ii +1;
					hextemp<= zero;
					hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;
				end

				8'h01: begin
					input_string[ii] = "1";
					//ii =ii +1;
					hextemp<= one;
					hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;
				end

				8'h02: begin
					input_string[ii] = "2";
					//ii =ii +1;
					hextemp<= two;
					hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;
				end

				8'h03: begin
					input_string[ii] = "3";
					//ii =ii +1;
					hextemp<= three;
					hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;
				end

				8'h04: begin
					input_string[ii] = "4";
					//ii =ii +1;
					hextemp<= four;
					hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;
				end

				8'h05: begin
					input_string[ii] = "5";
					//ii =ii +1;
					hextemp<= five;
					hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;
				end
				8'h06: begin
					input_string[ii] = "6";
					//ii =ii +1;
					hextemp<= six;
					hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;
				end

				8'h07: begin
					input_string[ii] = "7";
					//ii =ii +1;
					hextemp<= seven;
					hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;
				end

				8'h08: begin
					input_string[ii] = "8";
					//ii =ii +1;
					hextemp<= eight;
					hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;
				end

				8'h09: begin
					input_string[ii] = "9";
					//ii =ii +1;
					hextemp<= nine;
					hexarray[ii] = hextemp;
				hexarrayt[ii] = hextemp;
				ii = ii+1;
				end
				default: begin
					hextemp <= blank;
					hexarray[ii] = hextemp;
					hexarrayt[ii] = hextemp;
				end
			endcase
			end
		if ((hex_data[23:16] == 8'h1A)) begin
		t = 2;
		end*/
		
	end
	default:
	begin
	hex_out = blank;
	end
endcase
end
/*assign HEX0 = hex_out;
	assign HEX1 = hex_out;
	assign HEX2 = hex_out;
	assign HEX3 = hex_out;
	assign HEX4 = hex_out;
	assign HEX5 = hex_out;
	assign HEX6 = hex_out;
	assign HEX7 = hex_out;
	*/
	assign HEX0 = (t==0)?hex_out:(t==1)?hexarrayt[0]:(t==3)?Hex1s:hexarray[0];
	assign HEX1 = (t==0)?hex_out:(t==1)?hexarrayt[1]:(t==3)?Hex1s:hexarray[1];
	assign HEX2 = (t==0)?hex_out:(t==1)?hexarrayt[2]:(t==3)?Hex1s:hexarray[2];
	assign HEX3 = (t==0)?hex_out:(t==1)?hexarrayt[3]:(t==3)?Hex1s:hexarray[3];
	assign HEX4 = (t==0)?hex_out:(t==1)?hex5:(t==3)?Hex1s:hex5;
	assign HEX5 = (t==0)?hex_out:(t==1)?hex4:(t==3)?Hex1s:hex4;
	assign HEX6 =(t==0)?hex_out:(t==1)?hex3:(t==3)?Hex1s:hex3;
	assign HEX7 = (t==0)?hex_out:(t==1)?hex2:(t==3)?Hex1s:hex2;
endmodule
