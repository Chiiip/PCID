module remote_controller (clk, reset, serial, ready, remote_key);
input clk, reset, serial;
output reg ready;
output reg [7:0] remote_key;

reg [7:0] key_code, key_inv_code;
reg [3:0] counter;
reg [2:0] current_state, next_state;

parameter
	INVALID_KEY = 8'hFF,
   S_AWAITING_0 = 3'b000,
	S_AWAITING_1 = 3'b001,
   S_READING_CUSTOM_CODE = 3'b010,
   S_READING_KEY_CODE = 3'b011,
   S_READING_INV_KEY_CODE = 3'b100,
	S_COMPARISON = 3'b101,
   S_VALID_KEY_DETECTED = 3'b110;


always @ (posedge clk)
begin	
	case(current_state)
	S_AWAITING_0:
	begin
		counter <= 4'b0000;
		key_code <= 8'b00000000;
		key_inv_code <= 8'b00000000;
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
			counter <= 0;
			end
		else
			begin
			counter <= counter + 4'b0001;
			next_state <= S_READING_CUSTOM_CODE;			
			end
	end
	S_READING_KEY_CODE:
	begin				
		if(counter == 7)
			begin
			next_state <= S_READING_INV_KEY_CODE;
			counter <= 0;
			end
		else
			begin
			key_code = {key_code, serial};
			counter <= counter + 4'b0001;
			next_state <= S_READING_KEY_CODE;
			end
	end
	S_READING_INV_KEY_CODE:
	begin		
		if(counter == 7)
			begin
			next_state <= S_COMPARISON;
			counter <= 0;
			end
		else
			begin
			key_inv_code = {key_inv_code, serial};
			counter <= counter + 4'b0001;
			next_state <= S_READING_INV_KEY_CODE;	
			end
	end	
	S_COMPARISON:
	begin
		if(key_code ^ key_inv_code == 8'b11111111) next_state <= S_VALID_KEY_DETECTED;
		else next_state <= S_AWAITING_0;
	end
	S_VALID_KEY_DETECTED:
	begin
		if(counter == 2) next_state <= S_AWAITING_0;
		else
			begin
			counter <= counter + 4'b0001;
			next_state <= S_VALID_KEY_DETECTED;
			end
	end
	default: next_state <= S_AWAITING_0;
	endcase
end

always @ (posedge clk or negedge reset)
begin
	if(!reset)
		current_state <= S_AWAITING_0;
	else
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