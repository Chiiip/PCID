`timescale 1ns/1ns

module TOP_test_bench();

reg clock, reset;

wire [4:0] mem_address;
wire ready, mem_read_enable, mem_write_enable;
wire [15:0] acc_data_out;
wire [15:0] acc_data_in;

integer counter_read_enable;
integer counter_write_enable;
integer counter_ready;
integer sum_at_7;
integer sum_at_15;
integer sum_at_23;
integer sum_at_31;

TOP top(clock, reset, acc_data_in, ready, mem_read_enable, mem_address, mem_write_enable, acc_data_out);
External_RAM external_ram(mem_address, clock, acc_data_out, mem_read_enable, mem_write_enable, acc_data_in);

initial
begin
    clock = 0;
    forever #5 clock = !clock;
end

initial 
begin
    reset = 0;
    #20 reset = 1;
    #20 reset = 0;
    #3165 $stop;
end

initial 
begin
    counter_read_enable = 0;
    repeat(108)
    begin
        @(posedge mem_read_enable)
        counter_read_enable = counter_read_enable + 1;
        if (counter_read_enable > 56)
        begin
            $display("\n------------ O sinal de READ_ENABLE foi ativado mais vezes do que deveria! ------------\n");
            $stop;
        end
        else $display("READ_ENABLE COUNTER = %d/56", counter_read_enable);
    end
end

initial
begin
    counter_write_enable = 0;
    repeat(16)
    begin
        @(posedge mem_write_enable)
        counter_write_enable = counter_write_enable + 1;
        if (counter_write_enable > 8)
        begin
            $display("\n------------ O sinal de WRITE_ENABLE foi ativado mais vezes do que deveria! ------------\n");
            $stop;
        end
        else $display("WRITE_ENABLE COUNTER = %d/8", counter_write_enable);
    end
    
end

initial
begin
    counter_ready = 0;
    repeat(4)
    begin
        @(posedge ready)
        counter_ready = counter_ready + 1;
        if (counter_ready > 2)
        begin
            $display("\n------------ O sinal de READY foi ativado mais vezes do que deveria! ------------\n");
            $stop;
        end
        else $display("READY COUNTER = %d/2", counter_ready);
    end 
end

initial
begin
    sum_at_7 = 21; // Soma dos valores 0+1+2+3+4+5+6 = 21 de acordo com o arquivo MIF
    sum_at_15 = 77; // Soma dos valores 8+9+10+11+12+13+14 = 77 de acordo com o arquivo MIF
    sum_at_23 = 133; // Soma dos valores 16+17+18+19+20+21+22 = 133 de acordo com o arquivo MIF
    sum_at_31 = 189; // Soma dos valores 24+25+26+27+28+29+30 = 189 de acordo com o arquivo MIF
    repeat(8)
    begin
        @(posedge mem_write_enable)
        case(mem_address)
        7:
        begin
            if(acc_data_out != sum_at_7)
            begin
            $display("\n------------ Soma incorreta na posicao de memoria 7 ------------\n");
            $stop;
            end
        end
        15:
        begin
            if(acc_data_out != sum_at_15)
            begin
            $display("\n------------ Soma incorreta na posicao de memoria 15 ------------\n");
            $stop;
            end
        end
        23:
        begin
            if(acc_data_out != sum_at_23)
            begin
            $display("\n------------ Soma incorreta na posicao de memoria 23 ------------\n");
            $stop;
            end
        end
        31:
        begin
            if(acc_data_out != sum_at_31)
            begin
            $display("\n------------ Soma incorreta na posicao de memoria 31 ------------\n");
            $stop;
            end
        end
        endcase
    end
    
end



endmodule