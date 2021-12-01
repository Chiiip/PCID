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
	increase_address = 8'b00010000,
	reset_v = 8'b00100000,
	reset_output = 8'b01000000,
	reset_y = 8'b10000000;


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
			next_state = increase_address;
		end
	increase_address:
		begin
			if (v == 3'b000) next_state = reset_v;
			else next_state = get_address;
		end
	reset_v:
		begin
			next_state = get_address;
		end
	/*estado2 : 
		begin
		if (moeda) 
			begin
			refri = 1;
			estadoFuturo = estadoInicial;			
			end
		else if (desiste)
			begin 
			troco = 1;
			estadoFuturo = estadoInicial;
			end
		else
		estadoFuturo = estado2;
		end*/
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
					read_enable <= 0;
				end
			get_address: 
				begin
					v <= v + 1;
					address <= {u, v};
				end
			enable_read:
				begin
					read_enable <= 1;
				end
			accumulate:
				begin
					active_MAC <= 1;
				end
			increase_address:
				begin
					read_enable <= 0;
					active_MAC <= 0;
				end
			reset_v:
				begin
					u <= u + 1;
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
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;
end
endmodule
 