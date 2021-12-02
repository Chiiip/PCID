module FSM_Control(start, clock, reset, ready, u, v, x, y, active_MAC, read_enable, address, reset_MAC);
input start, clock, reset;
output reg[2:0] u, v, x, y;
output reg active_MAC, read_enable, reset_MAC, ready;
output reg[5:0] address;
reg[7:0] current_state, next_state;

parameter 
	idle_state = 8'b00000001,
	get_address = 8'b00000010,
	enable_read = 8'b00000100,
	accumulate = 8'b00001000,
	increase_v = 8'b00010000,
	increase_u = 8'b00100000,
	increase_y = 8'b01000000,
	increase_x = 8'b10000000;


always @ (current_state or start or u or v or x or y)
begin
case (current_state)
	idle_state : 
		begin 
			if (start) next_state = get_address;
			else next_state = idle_state;
		end
	get_address : 
		begin
			next_state = enable_read;
		end
	enable_read : 
		begin
			next_state = accumulate;
		end
	accumulate : 
		begin
			next_state = increase_v;
		end
	increase_v:
		begin
			if (v == 3'b111)
				begin
					if (u == 3'b111) 
						begin
							if (y == 3'b111)
								begin
									if (x == 3'b111)
										begin
											next_state = idle_state;
										end
									else next_state = increase_x;
								end
							else next_state = increase_y;
						end
					else next_state = increase_u;
				end
			else next_state = get_address;
		end
	increase_u:
		begin
			next_state = get_address;
		end
	increase_y:
		begin
			next_state = get_address;
		end
	increase_x:
		begin
			next_state = get_address;
		end
	default : next_state = idle_state;
endcase
end

always @ (posedge clock or negedge reset) 
begin
	if (!reset)
		current_state <= idle_state;
	else
	begin
		current_state <= next_state;
		case (current_state)
			idle_state: 
				begin
					u <= 000;
					v <= 000;
					x <= 000;
					y <= 000;
					reset_MAC <= 1;
					read_enable <= 0;

					if (address == 6'b111111) ready <= 1;
					else ready <= 0;
				end
			get_address: 
				begin
					address <= {u, v};
					reset_MAC <= 1;
				end
			enable_read:
				begin
					read_enable <= 1;
				end
			accumulate:
				begin
					active_MAC <= 1;
				end
			increase_v:
				begin
					read_enable <= 0;
					active_MAC <= 0;
					v <= v + 1;
				end
			increase_u:
				begin
					u <= u + 1;
					next_state <= get_address;
				end
			increase_y:
				begin
					u <= u + 1;
					y <= y + 1;
					reset_MAC <= 0;
					next_state <= get_address;
				end
			increase_x:
				begin
					u <= u + 1;
					y <= y + 1;
					x <= x + 1;
					next_state <= get_address;
				end
			default: next_state <= next_state;
		endcase
	end
end


endmodule


module FSM_test_bench();

reg start, reset, clock;
wire[2:0] u, v, x, y;
wire active_MAC, reset_MAC, read_enable, ready;
wire[5:0] address;

FSM_Control teste(start, clock, reset, ready, u, v, x, y, active_MAC, read_enable, address, reset_MAC);

initial begin

start = 1;
reset = 1;

#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;

start = 0;
while( 1 <= 10 )

	begin
		#50 clock = 1;
		#50 clock = 0;
	end 

end
endmodule
 