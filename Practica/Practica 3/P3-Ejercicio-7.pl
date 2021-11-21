inicio :- writeln('Ingrese una cadena: '), read(String), writeln(String), write('Cumple: '),verificar_cadena(String, 'a').

verificar_caracter(Caracter, Caracter).

verificar_cadena(String, Letra) :- sub_atom(String, 0, 1, _, Sub), verificar_caracter(Sub, Letra), sub_atom(String, 1, _, 0, Resto), verificar_cadena(Resto, Letra).
verificar_cadena(String, 'a') :- verificar_cadena(String, 'b').
verificar_cadena('', _).