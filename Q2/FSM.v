module FSM(clock, reset, ready, mem_address, mem_read_enable, mem_write_enable, acc_load, acc_transfer, acc_clear);
input clock, reset;
output reg ready,
	mem_read_enable,
	mem_write_enable,
	acc_load,
	acc_transfer,
	acc_clear;

output reg [4:0] mem_address;

reg [3:0] current_state, next_state;

parameter
	S_RESET = 0,
	S_CLEAR_ACC = 1,
	S_MEM_READ = 2,
	S_MEM_WAIT_READ = 3, 
	S_ACC_LOAD_DATA = 4,
	S_ACC_TRANSFER_DATA = 5,
	S_CHECK_POSITION = 6,
	S_MEM_WRITE = 7,
	S_MEM_WAIT_WRITE = 8,
	S_UPDATE_ADDRESS = 9,
	S_READY = 10;

always @ (current_state or mem_address)
begin
	case(current_state)
	S_RESET:
	begin		
		next_state = S_CLEAR_ACC;
	end
	S_CLEAR_ACC:
	begin
		next_state = S_MEM_READ;
	end
	S_MEM_READ:
	begin
		next_state = S_MEM_WAIT_READ;
	end
	S_MEM_WAIT_READ:
	begin
		next_state = S_ACC_LOAD_DATA;
	end
	S_ACC_LOAD_DATA:
	begin
		next_state = S_ACC_TRANSFER_DATA;
	end
	S_ACC_TRANSFER_DATA:
	begin
		next_state = S_CHECK_POSITION;
	end
	S_CHECK_POSITION:
	begin
		if(mem_address != 6 && mem_address != 14 && mem_address != 22 && mem_address != 30) next_state = S_MEM_READ;		 
		else next_state = S_MEM_WRITE;
	end
	S_MEM_WRITE:
	begin			
		next_state = S_MEM_WAIT_WRITE;
	end
	S_MEM_WAIT_WRITE:
	begin
		if(mem_address == 31) next_state <= S_READY;
		else next_state = S_UPDATE_ADDRESS;
	end
	S_UPDATE_ADDRESS:
	begin		
		next_state = S_CLEAR_ACC;
	end
	S_READY:
	begin		
		next_state = S_RESET;
	end
	endcase
end


always @ (posedge clock or posedge reset)
begin
	if(reset)
	begin
		current_state <= S_RESET;
	end
	else
	begin
		case(current_state)
		S_RESET:
		begin
			mem_address <= 5'b00000;
			ready <= 1'b0;		
			mem_read_enable <= 1'b0;
			mem_write_enable <= 1'b0;
			acc_load <= 1'b1;
			acc_transfer <= 1'b0;
			acc_clear <= 1'b1;
		end
		S_CLEAR_ACC:
		begin
			mem_write_enable <= 1'b0;
			acc_clear<= 1'b0;
		end
		S_MEM_READ:
		begin
			mem_read_enable <= 1'b1;
			acc_clear<= 1'b1;
		end
		S_ACC_LOAD_DATA:
		begin
			mem_read_enable <= 1'b0;
			acc_load <= 1'b1;
		end
		S_ACC_TRANSFER_DATA:
		begin
			acc_transfer <= 1'b1;		
			acc_load <= 1'b0;		
		end
		S_CHECK_POSITION:
		begin
			mem_address <= mem_address + 1;	
			acc_transfer <= 1'b0;
		end
		S_MEM_WRITE:
		begin		
			mem_write_enable <= 1'b1;
		end
		S_UPDATE_ADDRESS:
		begin
			mem_address = mem_address + 1;
			mem_write_enable <= 1'b0;
		end
		S_READY:
		begin
			mem_write_enable <= 1'b0;
			ready <= 1'b1;
		end
		default: next_state <= next_state;
		endcase
		current_state <= next_state;
	end
end

endmodule