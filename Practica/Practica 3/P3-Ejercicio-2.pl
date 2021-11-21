inicio :- writeln('Ingrese una cadena: '), read(C), atom_length(C, Longitud), PenUltimo is Longitud-1
,sub_atom(C, PenUltimo, 1, _, Sub), writeln('El último caracter es: '), writeln(Sub).