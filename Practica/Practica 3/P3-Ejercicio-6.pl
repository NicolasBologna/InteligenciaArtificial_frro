inicio :- writeln('Ingrese el numero a convertir: '), Numero = 128, writeln(Numero), pasar_a_binario(Numero, Resultado), reverse(Resultado, ResultadoFinal)
,writeln('El numeor en binario es: '), writeln(ResultadoFinal).

pasar_a_binario(0, []).
pasar_a_binario(Numero, [H|T]) :- H is Numero mod 2, Resultado is Numero // 2, pasar_a_binario(Resultado, T).