inicio :- writeln('Ingrese una cadena: '), read(C), atom_length(C, Longitud),writeln('La longitud es: '), writeln(Longitud), 
contar_recursivamente(C, LongitudRec), writeln('La longitud es: '), writeln(LongitudRec).

contar_recursivamente('',0).
contar_recursivamente(C, Long) :- sub_atom(C, 1, _, 0, Sub), contar_recursivamente(Sub, LongParc), Long is LongParc + 1.
