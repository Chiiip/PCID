module remote_controller (clk, reset, serial, ready, remote_key);
input clk, reset, serial;
output reg ready;
output reg [7:0] remote_key;

reg [7:0] key_code, key_inv_code;
reg [3:0] counter;
reg [2:0] current_state, next_state;
wire A = key_code[4];
wire B = key_code[3];
wire C = key_code[2];
wire D = key_code[1];
wire E = key_code[0];
wire KEY_EXISTS = (key_code[7:5] == 3'b000) && (((~A)&(~B)) || 
			 ((~B)&(~C)) ||
			 ((~B)&(~E)) ||
			 (A&D) ||
			 ((~A)&(~C)&(~D)) ||
			 ((~A)&(~D)&(~E)) ||
			 ((~C)&(~D)&(~E)) ||
			 ((C)&(D)&(E)));

parameter
	INVALID_KEY = 8'hFF,
   S_AWAITING_0 = 3'b000,
	S_AWAITING_1 = 3'b001,
   S_READING_CUSTOM_CODE = 3'b010,
   S_READING_KEY_CODE = 3'b011,
   S_READING_INV_KEY_CODE = 3'b100,
	S_COMPARISON = 3'b101,
   S_VALID_KEY_DETECTED = 3'b110;


always @ (current_state or serial or counter or key_code or key_inv_code or KEY_EXISTS)
begin	
	case(current_state)
	S_AWAITING_0:
	begin
		if(serial == 1'b0) next_state <= S_AWAITING_1;
		else next_state <= S_AWAITING_0;
	end
	S_AWAITING_1:
	begin
		if(serial == 1'b1) next_state <= S_READING_CUSTOM_CODE;
		else next_state <= S_AWAITING_1;
	end
	S_READING_CUSTOM_CODE:
	begin
		if(counter == 15)
			begin
			next_state <= S_READING_KEY_CODE;
			end
		else
			begin
			next_state <= S_READING_CUSTOM_CODE;			
			end
	end
	S_READING_KEY_CODE:
	begin			
		if(counter == 7)
			begin
			next_state <= S_READING_INV_KEY_CODE;
			end
		else
			begin			
			next_state <= S_READING_KEY_CODE;
			end
	end
	S_READING_INV_KEY_CODE:
	begin		
		if(counter == 7)
			begin
			next_state <= S_COMPARISON;
			end
		else
			begin			
			next_state <= S_READING_INV_KEY_CODE;	
			end
	end	
	S_COMPARISON:
	begin
		if(((key_code ^ key_inv_code) == 8'b11111111) && (KEY_EXISTS == 1'b1)) 
			next_state <= S_VALID_KEY_DETECTED;		
		else next_state <= S_AWAITING_0;
	end
	S_VALID_KEY_DETECTED:
	begin
		if(counter == 2) next_state <= S_AWAITING_0;
		else next_state <= S_VALID_KEY_DETECTED;
	end
	default: next_state <= S_AWAITING_0;
	endcase
end

always @ (negedge clk or negedge reset)
begin
	if(!reset)
		current_state <= S_AWAITING_0;
	else
		case(current_state)
	S_AWAITING_0:
	begin
		counter <= 4'b0000;
		key_code <= 8'b00000000;
		key_inv_code <= 8'b00000000;
	end
	S_READING_CUSTOM_CODE:
	begin
		if(counter == 15) counter <= 0;
		else counter <= counter + 4'b0001;
	end
	S_READING_KEY_CODE:
	begin			
		key_code = {key_code, serial};	
		if(counter == 7) counter <= 0;
		else counter <= counter + 4'b0001;
	end
	S_READING_INV_KEY_CODE:
	begin		
		key_inv_code = {key_inv_code, serial};
		if(counter == 7) counter <= 0;
		else counter <= counter + 4'b0001;
	end	
	S_VALID_KEY_DETECTED:
	begin
		if(counter == 2) counter <= counter;
		else counter <= counter + 4'b0001;
	end
	default: next_state <= next_state;
	endcase
	current_state <= next_state;
end

always @ (current_state)
begin
	if(current_state == S_VALID_KEY_DETECTED)
		begin
		remote_key <= key_code;
		ready <= 1'b1;
		end
	else 
		begin
		remote_key <= INVALID_KEY;
		ready <= 1'b0;
		end
end

endmodule