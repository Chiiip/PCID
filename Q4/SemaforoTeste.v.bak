module Semaforo_test_bench();

reg A, B, C, D, clock;
wire NS, LO;

Semaforo semaforo(A, B, C, D, NS, LO);

initial begin

$monitor("value of A=%b, B=%b, C = %b, D = %b, NS = %b, LO = %b", A, B, C, D, NS, LO);

A = 0;
B = 0;
C = 0;
D = 0;
//0000


//0100
#50 B = 1;

//1100
#50 A = 1;


//1101
#50 D = 1;


//1111
#50 C = 1;


//1011
#50 B = 0;


//0011
#50 A = 0;


//0010
#50 D = 0;

//0110
#50 B = 1;


//0111
#50 D = 1;

//0101
#50 C = 0;


//0001
#50 B = 0;


//1001
#50 A = 1;

//1100
#50 B = 1; D = 0;

//1010
#50 B = 0; C = 1;

//1000
#50 C = 0;

//1110
#50 B = 1; C = 1;

end
endmodule