module Semaforo(A, B, C, D, NS, LO);
input A, B, C, D;
output NS, LO;
assign NS = (C && D) || (!A && !B);
assign LO = !((C && D) || (!A && !B));
endmodule