inicio:- read(Cadena), armarLista(Cadena, Lista), write(Lista).

armarLista(Cadena, [H|T]):- sub_atom(Cadena,Pos,1,_,' '), write(Pos),sub_atom(Cadena,0,Pos,_,Palabra), H = Palabra, SigPos is Pos+1, sub_atom(Cadena,_,SigPos,0,Resto), armarLista(Resto,T).
armarLista('', []).
