%%inicio :- writeln('Ingrese una cadena: '), read(String), pasar_a_lista(String, Lista), writeln('La longitud es: '), writeln(Lista).

inicio :- writeln('Ingrese una cadena: '), String = "Esto se tiene que separar en los espacios", writeln(String), pasar_a_lista(String, Lista), writeln('La lista de palabras es: '), writeln(Lista).


pasar_a_lista(C, [H|T]) :- sub_atom(C, PosEspacio, 1 , _, ' '), NuevoInicio is PosEspacio + 1,sub_atom(C, 0, PosEspacio, _, H), sub_atom(C, NuevoInicio, _, 0, Sub), pasar_a_lista(Sub, T).
pasar_a_lista(UltimoString,[UltimoString]).