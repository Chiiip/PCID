`timescale 1ns/1ns

module remote_controller_test_bench();

reg clk, reset, serial;
wire ready;
wire [7:0] remote_key;

reg [15:0] custom_code_value;
reg [7:0] key_value;
reg [7:0] key_inv_value;

remote_controller rc(clk, reset, serial, ready, remote_key);

initial
begin
    clk = 0;
    forever #5 clk = !clk;
end

initial begin
    //$monitor("clk=%b, reset=%b, serial=%b, ready=%b, remote_key=%8b", clk, reset, serial, ready, remote_key); 
    serial = 1;
    reset = 0;
    #20 reset = 1;
    
// VALID KEY CODE - KEY 0x0F
// START BIT
    #3 serial = 0;  
    #10 serial = 1;    
// CUSTOM CODE
    custom_code_value = 16'b1010101010101010;
    repeat(16)
    begin
        #10 serial = custom_code_value[15];
        custom_code_value = custom_code_value << 1;
    end  
// KEY CODE  
    key_value = 8'b00001111;
    repeat(8)
    begin        
        #10 serial = key_value[7];
        key_value = key_value << 1;
    end  
// INV KEY CODE  
    key_inv_value = 8'b11110000;
    repeat(8)
    begin
        #10 serial = key_inv_value[7];
        key_inv_value = key_inv_value << 1;
    end  
// END
    repeat(5) #10 serial = 0;

// INVALID INV KEY CODE - KEY 0x0F
// START BIT
    #3 serial = 0;  
    #10 serial = 1;
// CUSTOM CODE
    custom_code_value = 16'b1110111110101011;
    repeat(16)
    begin
        #10 serial = custom_code_value[15];
        custom_code_value = custom_code_value << 1;
    end  
// KEY CODE  
    key_value = 8'b00001111;
    repeat(8)
    begin
        #10 serial = key_value[7];
        key_value = key_value << 1;
    end  
// INV KEY CODE  
    key_inv_value = 8'b11010010;
    repeat(8)
    begin
        #10 serial = key_inv_value[7];
        key_inv_value = key_inv_value << 1;
    end  
// END
    repeat(5) #10 serial = 0;

// INVALID KEY CODE - KEY 0x0A (NOT IN KEY LIST)
// START BIT
    #3 serial = 0;  
    #10 serial = 1;
// CUSTOM CODE
    custom_code_value = 16'b0110100000101010;
    repeat(16)
    begin
        #10 serial = custom_code_value[15];
        custom_code_value = custom_code_value << 1;
    end
// KEY CODE  
    key_value = 8'b00001010;
    repeat(8)
    begin
        #10 serial = key_value[7];
        key_value = key_value << 1;
    end  
// INV KEY CODE  
    key_inv_value = 8'b11110101;
    repeat(8)
    begin
        #10 serial = key_inv_value[7];
        key_inv_value = key_inv_value << 1;
    end  
// END
    repeat(5) #10 serial = 0;
    #5 $stop;

end

initial
begin
    repeat(3)
    begin
        @(posedge ready);
        if(remote_key==8'h00 
        || remote_key==8'h01 
        || remote_key==8'h02 
        || remote_key==8'h03
        || remote_key==8'h04
        || remote_key==8'h05
        || remote_key==8'h06
        || remote_key==8'h07
        || remote_key==8'h08
        || remote_key==8'h09
        || remote_key==8'h0F
        || remote_key==8'h13
        || remote_key==8'h01
        || remote_key==8'h12
        || remote_key==8'h1A
        || remote_key==8'h1E
        || remote_key==8'h1B
        || remote_key==8'h1F
        || remote_key==8'h11
        || remote_key==8'h17
        || remote_key==8'h16
        || remote_key==8'h14
        || remote_key==8'h18
        || remote_key==8'h0C) $display("---- Tecla valida identificada ----");
        else 
        begin
            $display("\n------------ Tecla invalida identificada ------------\n");
            $stop;
        end
    end
end


endmodule