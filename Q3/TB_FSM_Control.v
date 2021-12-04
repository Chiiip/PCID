`timescale 1ns/1ns
module FSM_test_bench();

reg start, reset, clock;
wire[2:0] u, v, x, y;
wire active_MAC, reset_MAC, read_enable, ready;
wire[5:0] address;

integer count_ready;
integer count_reset_MAC;
integer count_read_enable;
integer count_active_MAC;
integer count_u;
integer count_v;
integer count_x;
integer count_y;
integer up_read, down_read, up_active;


FSM_Control DUV(start, clock, reset, ready, u, v, x, y, active_MAC, read_enable, address, reset_MAC);

initial begin

start = 1;
reset = 1;

#50 clock = 1;
#50 clock = 0;
#50 clock = 1;
#50 clock = 0;

start = 0;

end

always #50 clock = !clock;

initial
begin
    //Verificando se o sinal de ready é ativado mais de 64 vezes
	count_ready = 0;
	repeat (70)
	begin
		@(posedge ready)
		count_ready = count_ready + 1;
		if (count_ready > 64)
		begin
			$display("\n------------ O sinal de Ready foi ativado mais vezes do que deveria! ------------\n");
			$stop;
		end
	end
end

initial
begin
    //Verificando se o sinal de reset_MAC é ativado mais de 64 vezes
	count_reset_MAC = 0;
	repeat (70)
	begin
		@(negedge reset_MAC)
		count_reset_MAC = count_reset_MAC + 1;
		if (count_reset_MAC > 64)
		begin
			$display("\n------------ O sinal de Reset_MAC foi ativado mais vezes do que deveria! ------------\n");
			$stop;
		end
	end
end

initial
begin
    //Verificando se foram feitas mais do que 4096 leituras da memória
	count_read_enable = 0;
	repeat (4100)
	begin
		@(posedge read_enable)
		count_read_enable = count_read_enable + 1;
		if (count_read_enable > 4096)
		begin
			$display("\n------------ O sinal de Read Enable foi ativado mais vezes do que deveria! ------------\n");
			$stop;
		end
	end
end


initial
begin
    //Verificando se foram feitas mais do que 4096 ativações do MAC
	count_active_MAC = 0;
	repeat (4100)
	begin
		@(posedge active_MAC)
		count_active_MAC = count_active_MAC + 1;
		if (count_active_MAC > 4096)
		begin
			$display("\n------------ O sinal de Active Mac foi ativado mais vezes do que deveria! ------------\n");
			$stop;
		end
	end
end


initial
begin
    //Incrementando o contador de v toda vez que v é modificado
    count_v = 0;
	repeat (4100)
	begin
		@(v)
			count_v = count_v + 1;
	end
end

initial
begin
    //Incrementando o contador de u toda vez que u é modificado
    count_u = 0;
	repeat (4100)
	begin
		@(u)
			count_u = count_u + 1;
	end
end

initial
begin
    //Incrementando o contador de y toda vez que y é modificado
    count_y = 0;
	repeat (4100)
	begin
		@(y)
			count_y = count_y + 1;
	end
end

initial
begin
    //Incrementando o contador de x toda vez que x é modificado
    count_x = 0;
	repeat (4100)
	begin
		@(x)
			count_x = count_x + 1;
	end
end

initial
begin
    //Verificando se após um ready, o valor de u e v foi resetado para 0
	@(posedge ready)
		if (u != 3'b000 || v != 3'b000)
        begin
            $display("\n------------ Os valores de u e v não estão em zero logo após um sinal de ready! ------------\n"); 
            $stop;
        end
end


initial
begin
    //Obtendo o tempo do primeiro read_enable indo para nível alto
	@(posedge read_enable)
		up_read = $time;
end

initial
begin
    //Obtendo o tempo do primeiro read_enable indo para nível baixo. Foi dado um repeat(2) 
    //porque há um primeiro momento em que ele vai de X para nível baixo
    repeat(2)
	@(negedge read_enable)
		down_read = $time;
end

initial
begin
    //Obtendo o tempo do primeiro active_mac indo para nível alto
	@(posedge active_MAC)
		up_active = $time;
end


initial
begin
	#1900000 //tempo de simulação


    //Verificando se o sinal de active_MAC foi para 1 após o read_enable ir para 1 e antes do read_enable ir para 0, 
    //ou se o tempo da subida até a descida do read_enable foi inferior a 2 pulsos de clock
    if (up_active < up_read || up_active > down_read || down_read - up_read < 200)
    begin
        $display("\n------------ O sinal de active_MAC não foi para o nível alto no momento correto! ------------\n"); 
        $stop;
    end

    if (count_ready != 64 || count_read_enable != 4096 || count_reset_MAC != 64 || count_active_MAC != 4096 || 
    count_v != 4097 || count_u != 513 || count_y != 65 || count_x != 9)
        begin
        $display("\n------------ Algum teste falhou! ------------\n"); 
        $stop;
        end
    else begin
        $display("\n------------ Executado sem falhas! ------------\n"); 
        $stop;
    end
	
end


endmodule

