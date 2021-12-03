module Semaforo_test_bench();

reg A, B, C, D;
wire NS, LO;

integer erro = 0;

Semaforo DUV(A, B, C, D, NS, LO);

function SemaforoNSLigado;
input reg ligado;
begin
	if (NS == 1 && LO == 0) SemaforoNSLigado = 1;
    else SemaforoNSLigado = 0;
end
endfunction

initial begin

//0000
A = 0; B = 0; C = 0; D = 0;
#50 if (SemaforoNSLigado(1) == 1)
erro = erro + 1;
$monitor("erro = %b", erro);

//0100
#50 B = 1;

#50 if (SemaforoNSLigado(1) == 0)
erro = erro + 1;
$monitor("erro = %b", erro);

//1101
#50 A = 1; D = 1;

#50 if (SemaforoNSLigado(1) == 1)
erro = erro + 1;
$monitor("erro = %b", erro);

//1111
#50 C = 1;

#50 if (SemaforoNSLigado(1) == 1)
erro = erro + 1;
$monitor("erro = %b", erro);

//1011
#50 B = 0;

#50 if (SemaforoNSLigado(1) == 1)
erro = erro + 1;
$monitor("erro = %b", erro);

//0011
#50 A = 0;

#50 if (SemaforoNSLigado(1) == 1)
erro = erro + 1;
$monitor("erro = %b", erro);

//0010
#50 D = 0;

#50 if (SemaforoNSLigado(1) == 1)
erro = erro + 1;
$monitor("erro = %b", erro);

//0110
#50 B = 1;

#50 if (SemaforoNSLigado(1) == 1)
erro = erro + 1;
$monitor("erro = %b", erro);

//0111
#50 D = 1;

#50 if (SemaforoNSLigado(1) == 1)
erro = erro + 1;
$monitor("erro = %b", erro);

//0101
#50 C = 0;

#50 if (SemaforoNSLigado(1) == 1)
erro = erro + 1;
$monitor("erro = %b", erro);

//0001
#50 B = 0;

#50 if (SemaforoNSLigado(1) == 1)
erro = erro + 1;
$monitor("erro = %b", erro);

//1001
#50 A = 1;

#50 if (SemaforoNSLigado(1) == 1)
erro = erro + 1;
$monitor("erro = %b", erro);

//1100
#50 B = 1; D = 0;

#50 if (SemaforoNSLigado(1) == 0)
erro = erro + 1;
$monitor("erro = %b", erro);

//1010
#50 B = 0; C = 1;

#50 if (SemaforoNSLigado(1) == 1)
erro = erro + 1;
$monitor("erro = %b", erro);

//1000
#50 C = 0;

#50 if (SemaforoNSLigado(1) == 0)
erro = erro + 1;
$monitor("erro = %b", erro);

//1110
#50 B = 1; C = 1;

#50 if (SemaforoNSLigado(1) == 1)
erro = erro + 1;
$monitor("erro = %b", erro);

if (erro == 0)
        begin
		$display("\n------------ Semáforo funcionando adequadamente ------------\n");
        $stop;
        end
	else
        begin
		$display("\n------------ O semáforo não funcionou adequadamente ------------\n");
        $stop;
        end

end
endmodule