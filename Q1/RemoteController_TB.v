`timescale 1ns/1ns

module remote_controller_test_bench();

reg clk, reset, serial;
wire ready;
wire [7:0] remote_key;

remote_controller rc(clk, reset, serial, ready, remote_key);

initial
begin
    clk = 0;
    forever #5 clk = !clk;
end

initial begin
    $monitor("clk=%b, reset=%b, serial=%b, ready=%b, remote_key=%8b", clk, reset, serial, ready, remote_key); 
    serial = 1;
    reset = 0;
    #20 reset = 1;
// VALID KEY CODE - KEY 0x0F
// START BIT
    #3 serial = 0;  
    #10 serial = 1;
// CUSTOM CODE
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
// KEY CODE  
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 1;
    #10 serial = 1;
    #10 serial = 1;
// INV KEY CODE  
    #10 serial = 1;
    #10 serial = 1;
    #10 serial = 1;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
// END
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;

// INVALID INV KEY CODE - KEY 0x0F
// START BIT
    #3 serial = 0;  
    #10 serial = 1;
// CUSTOM CODE
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
// KEY CODE  
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 1;
    #10 serial = 1;
    #10 serial = 1;
// INV KEY CODE  
    #10 serial = 1;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
// END
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;

// INVALID KEY CODE - KEY 0x0A (NOT IN KEY LIST)
// START BIT
    #3 serial = 0;  
    #10 serial = 1;
// CUSTOM CODE
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
// KEY CODE  
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
// INV KEY CODE  
    #10 serial = 1;
    #10 serial = 1;
    #10 serial = 1;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
    #10 serial = 0;
    #10 serial = 1;
// END
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #10 serial = 0;
    #5 $stop;

end
endmodule