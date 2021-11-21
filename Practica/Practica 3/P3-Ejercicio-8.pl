inicio :- writeln('Ingrese una cadena: '), String = "Se deben contar la cantidad de veces que aparece la letra", writeln(String), writeln('Ingrese un caracter: '), Caracter = 'e', writeln(Caracter), contar_caracter(String, Caracter, Resultado), writeln('La cantidad de veces que aparece el cracter es: '), writeln(Resultado).

contar_caracter('', _, 0).
contar_caracter(String, Caracter, Resultado) :- sub_atom(String, PosCar, 1 , _, Caracter), NuevoInicio is PosCar + 1, sub_atom(String, NuevoInicio, _, 0, Sub), contar_caracter(Sub, Caracter, ResParc), Resultado is ResParc + 1.
contar_caracter(String, Caracter, Resultado) :- sub_atom(String, 1, _ , 0, NuevoString), contar_caracter(NuevoString, Caracter, Resultado).