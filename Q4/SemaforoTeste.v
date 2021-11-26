module Semaforo(A, B, C, D, NS, LO, clock);
input A, B, C, D, clock;
output NS, LO;
reg NS, LO;

always @ (posedge clock) 
	begin
		if ((C && D) || (!A && !B))
			begin
				LO <= 1;
				NS <= 0;
			end
		else
			begin
				LO <= 0;
				NS <= 1;
			end
	end
endmodule



module Semaforo_test_bench();

reg A, B, C, D, clock;
wire NS, LO;

Semaforo semaforo(A, B, C, D, NS, LO, clock);

initial begin

$monitor("value of A=%b, B=%b, C = %b, D = %b, NS = %b, LO = %b, clock = %b", A, B, C, D, NS, LO, clock);

A = 0;
B = 0;
C = 0;
D = 0;
//0000
#50 clock = 1;
#50 clock = 0;

//0100
#50 B = 1;
#50 clock = 1;
#50 clock = 0;

//1100
#50 A = 1;
#50 clock = 1;
#50 clock = 0;


//1101
#50 D = 1;
#50 clock = 1;
#50 clock = 0;


//1111
#50 C = 1;
#50 clock = 1;
#50 clock = 0;


//1011
#50 B = 0;
#50 clock = 1;
#50 clock = 0;

//0011
#50 A = 0;
#50 clock = 1;
#50 clock = 0;

//0010
#50 D = 0;
#50 clock = 1;
#50 clock = 0;

//0110
#50 B = 1;
#50 clock = 1;
#50 clock = 0;

//0111
#50 D = 1;
#50 clock = 1;
#50 clock = 0;

//0101
#50 D = 1;
#50 clock = 1;
#50 clock = 0;

//0001
#50 B = 1;
#50 clock = 1;
#50 clock = 0;

//1001
#50 A = 1;
#50 clock = 1;
#50 clock = 0;

//1100
#50 B = 1; D = 0;
#50 clock = 1;
#50 clock = 0;

//1010
#50 B = 0; C = 1;
#50 clock = 1;
#50 clock = 0;

//1000
#50 C = 0;
#50 clock = 1;
#50 clock = 0;

//1110
#50 B = 0; C = 0;
#50 clock = 1;
#50 clock = 0;

end
endmodule
