inicio :- writeln('Ingrese una cadena: '), read(String), pasar_a_lista(String, Lista), writeln('La longitud es: '), writeln(Lista).

pasar_a_lista('',[]).
pasar_a_lista(C, [H|T]) :- sub_atom(C, 0, 1, _, H), sub_atom(C, 1, _, 0, Sub), pasar_a_lista(Sub, T).
