module car (CLOCK_50 ,LCD_DATA, LCD_RW, LCD_RS, LCD_EN,IRDA_RXD,
SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,LEDR,LEDG);

input CLOCK_50 ;
output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
output [17:0]LEDR;
output [6:0]LEDG;
input [3:0]KEY;
input [17:0]SW;
output [7:0] LCD_DATA;
output LCD_RW, LCD_RS, LCD_EN;																											
input IRDA_RXD;																			
wire data_ready;
wire enableir = 1'b1;
reg [1:0] select_state = 2'b00;
wire turnoffalert ;
wire clk_use;
reg reset = 1'b0;
reg first = 1'b0;
reg key = 1'b1;
wire [6:0]hex2;
wire [17:0] ledr;
wire [8:0] ledg;
wire [3:0] select_lcd;
wire [2:0] select_seg7;
reg [3:0] sllcd = 4'b0000;
reg [2:0] slseg = 3'b000;
reg rstir = 1'b1;
reg [2:0] current_state = 3'b000;
reg [2:0] next_state;
//assign LEDR = SW;
assign select_lcd= sllcd;
assign select_seg7= slseg;
wire [1:0] check_pass;
wire clk_scale;
wire check_passs;
wire  [31:0] hex_data;  
wire  [4*8-1:0] input_string;  
reduce_HZ_10HZ(CLOCK_50 , clk_use);
	/*ir r1(.enableIR(1'b1),    .rstir(rstir),				
							.CLOCK2_50(CLOCK_50 ),
							.IRDA_RXD(IRDA_RXD),
							.select_main_state (select_main), .data_readys(data_ready));
							//.turnoffalert(turnoffalert) );*/
							
IR_RECEIVE u1(
					///clk 50MHz////
					.iCLK(CLOCK_50), 
					//reset          
					.iRST_n(rstir),        
					//IRDA code input
					.iIRDA(IRDA_RXD), 
					//read command      
					//.iREAD(data_read),
					//data ready      					
					.oDATA_READY(data_ready),
					//decoded data 32bit
					.oDATA(hex_data)        
					);		
integer i=0;
always@(negedge data_ready)begin 
	//if (enable) begin
			case(hex_data[23:16]) 
			8'h0F:
			begin
				select_state <= 2'b01;
				//turnoffalert <= 1'b1;
				//resetIR <= 1'b1;
				//d =1'b1;
				//hex_out <= six;
			end
			8'h13:begin
				select_state <= 2'b10;
				//turnoffalert <= 1'b0;
				//resetIR <= 1'b1;
			end
			8'h10: begin
				select_state <= 2'b11;
				//turnoffalert <= 1'b0;
				//resetIR <= 1'b1;
			end
			8'h12: begin
				select_state <= 2'b00;
			end
			/*default:begin
				select_state <= 2'b00;
			
			end*/
			/*8'h00: begin
			if(i<2) begin
				hextemp[i] = 7'b1000000;
				i = i+1;
				end
			end
			8'h01: begin
			if(i<2) begin
				hextemp[i] = 7'b1111001;
				i = i+1;
				end*/
			endcase
end
reg checkremote = 1'b0;					
reg checkpasss =1'b0;		
reg [1:0] enableled;
wire [1:0] enableleds;
assign enableleds = enableled;
div_to_1 #(.scale(5000000))c0(.CLOCK_50(CLOCK_50), .clk_out(clk_scale));
/*wire check;
reg alerton = 1'b0;
assign check = alerton;*/

always @(posedge clk_scale) begin
if(KEY[0] == 1'b0) key = 1'b0;
else if (KEY[1] == 1'b0) key = 1'b0;
else if (KEY[2] == 1'b0) key = 1'b0; 
else if (KEY[3] == 1'b0) key = 1'b0;
else key = 1'b1;
end


reg sw = 1'b0;
always @(posedge clk_scale) begin
if (SW) sw = 1'b1;
else sw = 1'b0;
end


/*always @(*)
begin
if (SW) begin
 alerton = 1'b1;
end
else if (!key) begin
	alerton =1'b1;
end
else alerton = 1'b0;
end*/
assign LEDR = ledr;
assign LEDG = ledg;

reg checkalert =1'b0;

always @(*) begin
	case(current_state)
		3'b000: begin //block state
				//else if (!key) next_state = 3'b001;
				/*else if ((select_state == 2'b10) && ((SW) || (!key)) || ((select_state == 2'b10) && ((!SW) || (key)))) next_state = 3'b011;
				else if ((select_state == 2'b11) && ((SW) || (!key)) || ((select_state == 2'b11) && ((!SW) || (key)))) next_state = 3'b100;
				*/
				//if (SW[0] || SW[1] || SW[2] || SW[3] || SW[4] || SW[5] || SW[6] || SW[7] || SW[8] || SW[9] || SW[10] || SW[11] || SW[12] || SW[13] || SW[14] || SW[15] ||SW[16] || SW[17]) next_state = 3'b001;
				if (SW) next_state = 3'b001;
				else if (!key) next_state = 3'b001;
				else if (select_state == 2'b10) next_state = 3'b011;
				else if (select_state == 2'b11) next_state = 3'b100;
				else next_state = 3'b000;
		end
		3'b001: begin //alert on state
				if (select_state == 2'b01) next_state = 3'b010;
				else next_state = 3'b001;
		end
		3'b010: begin //alert off state 
				if (select_state == 2'b10) next_state = 3'b011;
				else if (select_state == 2'b11) next_state = 3'b100;
				else if (select_state == 2'b00) next_state = 3'b000;
				else next_state = 3'b010;
		end
		3'b011: begin //finding car state
				if (select_state == 2'b11) next_state = 3'b100;
				else if (select_state == 2'b00) next_state = 3'b000;
				else if (select_state == 2'b10) next_state = 3'b011;
				else next_state = 3'b011;
		end
		3'b100: begin //password state
				if (select_state == 2'b00) next_state = 3'b000;
				else next_state = 3'b100;
		end
		default: next_state = 3'b000;
	endcase
end

always @ (posedge CLOCK_50, posedge reset )
begin
	if(reset)
       current_state <= 3'b000;
   else
       current_state <= next_state;            
end

reg resetfinding = 1'b0;
reg resetfindingled = 1'b0;

always @(*) 
begin
	case (current_state)
		3'b000: begin
			resetfinding = 1'b0;
			sllcd = 4'b0000;
			slseg = 3'b000;
			enableled =2'b00;
			resetfindingled = 1'b0;
			checkremote = 1'b0;
			
		end
		3'b001:begin
			resetfinding = 1'b0;	
			sllcd = 4'b0001;
			slseg = 3'b001;
			enableled = 2'b01;
			resetfindingled = 1'b0;
			checkremote = 1'b0;
		end
		3'b010:begin
			resetfinding = 1'b0;
			sllcd = 4'b0010;
			slseg = 3'b000;
			resetfindingled = 1'b0;
			enableled = 2'b00;
			checkremote = 1'b0;
		end
		3'b011:begin
			resetfinding = 1'b1;
			sllcd = 4'b0011;
			slseg = 3'b010;
			enableled = 2'b10;
			resetfindingled = 1'b1;
			checkremote = 1'b0;
		end
		3'b100:begin
			resetfinding = 1'b0;
			sllcd = 4'b0110;
			slseg = 3'b100;
			enableled = 2'b00;
			resetfindingled = 1'b0;
			checkpasss = 1'b1;
			checkremote = 1'b1;
			if (check_pass == 2'b01) begin
				resetfinding = 1'b0;
				sllcd = 4'b0101;
				slseg = 3'b100;
				enableled = 2'b00;
				resetfindingled = 1'b0;
			end
			else if (check_pass == 2'b10) begin
				resetfinding = 1'b0;
				sllcd = 4'b0100;
				slseg = 3'b100;
				enableled = 2'b00;
				resetfindingled = 1'b0;
			end
			else if (check_pass == 2'b11) begin
				resetfinding = 1'b0;
					sllcd = 4'b0111;
					slseg = 3'b100;
					enableled = 2'b11;
					resetfindingled = 1'b0;
			
			end
		end
	endcase
end



//reg [6:0] hextemp [1:0];

/*IR_RECEIVE u2(
					///clk 50MHz////
					.iCLK(CLOCK_50), 
					//reset          
					.iRST_n(rstir),        
					//IRDA code input
					.iIRDA(IRDA_RXD), 
					//read command      
					//.iREAD(data_read),
					//data ready      					
					.oDATA_READY(data_ready),
					//decoded data 32bit
					.oDATA(hex_data)        
					);		
always@(negedge data_ready)begin 
	//if (enable) begin
			case(hex_data[23:16]) 
			8'h00: begin
					hextemp<= 7'b1000000;
				end
			
			
			
			endcase
			
end*/

//assign HEX3 = hextemp[0];
//assign HEX2 = hextemp[1];

/*always @ (*) begin
case(select_state)
	2'b00: begin
		if (!check) begin
			sllcd = 4'b0000;
			slseg = 3'b000;
			enableled =1'b0;
		end
		else if((select_state != 2'b01) || (select_state != 2'b10) || (select_state != 2'b11) )begin
			sllcd = 4'b0001;
			slseg = 3'b001;
			enableled =1'b1;
		end
		else begin
			sllcd = 4'b0001;
			slseg = 3'b001;
			enableled =1'b1;
			
		end
	end
	2'b01:begin
			sllcd = 4'b0010;
			slseg = 3'b000;
			enableled = 1'b0;
			//select_state_next <= 2'b00;
	end
	2'b10: begin
		sllcd = 4'b0011;
		slseg = 3'b010;
		enableled = 1'b0;
	end

endcase
end
*/
/*wire reset;
assign reset = rstir;*/
/*always @ (posedge CLOCK_50, posedge reset )
            begin
              
                if(reset)
                        select_state    <=         2'b00;
                else
                        select_state        <=            select_state_next;
                  
            end
*/
/*always @(posedge CLOCK_50)
begin
 if(!KEY[3]) 
 begin
 select_main <= 2'b01;
 turnoffalert <= 1'b1; 
 end
 /*else begin
 select_main <= 2'b00;
 turnoffalert <= 1'b0; 
 end*/
//end

/*always @(*)
begin
	case(select_main)
		2'b01: begin
		//turnoffalert <= 1'b1;
		sllcd <= 4'b0010;
		slseg <= 3'b000;
		enable <=1'b0;
		//rstir <= 1'b0;
		end
		2'b00: begin
		sllcd <= 4'b0000;
		slseg <= 3'b000;
		enable <= 1'b0;
		first <= 1'b1;
		end
		default: begin
				end
		endcase
		if (((SW) || (!key) ) && (first)) begin
			sllcd <= 4'b0001;
			slseg <= 3'b001;
			enable <=1'b1;
			first <= 1'b0;
			end
		else begin	
		sllcd <= 4'b0000;
		slseg <= 3'b000;
		enable <= 1'b0;
		end
end*/


led_run d (ledr,ledg,clk_use,enableleds,resetfindingled);
lcd_run  dd (
					CLOCK_50 ,	
					1'b1,1'b1,
					LCD_DATA,LCD_RW,LCD_EN,LCD_RS,sllcd );
seg7_run re (HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,clk_use,slseg,check_pass,1'b0,input_string,resetfinding,CLOCK_50,IRDA_RXD,checkremote);

























endmodule


module reduce_HZ_10HZ(Cin, Cout);
	input Cin;
	output reg Cout = 0;
	
	integer s = 0;
	always @(posedge Cin ) begin
			if(s == 0) begin
				Cout = 0;
				s = 1;
			end
			else if(s < 2500000) s = s + 1;
			else if(s == 2500000) begin 
				Cout = 1;
				s = s + 1;
			end
			else if(s < 5000000) s = s + 1;
			else s = 0;
		end
	
endmodule

module div_to_1(input CLOCK_50, output reg clk_out);
	
	parameter scale = 25000000;
	reg [24:0] count;

	initial count = 1'd0;
	initial clk_out = 1'b0;

	always @(posedge CLOCK_50) begin 
		if (count == scale) begin
			count <= 25'd0;
			clk_out <= !clk_out;
		end
		else count <= count + 1;

	end


endmodule 
