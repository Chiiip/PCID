module accumulator(clock, clear, load, transfer, data_in, data_out);
input clock, clear, load, transfer;
input [15:0] data_in;
output reg [15:0] data_out;

reg [15:0] data_in_reg;

always @ (posedge clock or negedge clear)
begin
	if(clear == 1'b0) data_out <= 15'h0000;
	else
	begin
		if(transfer == 1'b1) data_out <= data_out + data_in_reg;
		else if(load == 1'b1) data_in_reg <= data_in;
	end
end

endmodule