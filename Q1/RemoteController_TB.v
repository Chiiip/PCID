module remote_controller_test_bench();

reg clk, reset, serial;
wire ready;
wire [7:0] remote_key;

remote_controller rc(clk, reset, serial, ready, remote_key);

initial begin

//$monitor("value of Moeda=%b, Desiste=%b, Reset = %b, Clock = %b", moeda, desiste, reset, clock);


end
endmodule