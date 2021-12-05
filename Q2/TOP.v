module TOP(clock, reset, acc_data_in, ready, mem_read_enable, mem_address, mem_write_enable, acc_data_out);
input clock, reset;
input [15:0] acc_data_in;

output [4:0] mem_address;
output ready, mem_read_enable, mem_write_enable;
output [15:0] acc_data_out;

wire acc_load, acc_transfer, acc_clear;

FSM fsm_controller(clock, reset, ready, mem_address, mem_read_enable, mem_write_enable, acc_load, acc_transfer, acc_clear);
accumulator acc(clock, acc_clear, acc_load, acc_transfer, acc_data_in, acc_data_out); 

endmodule