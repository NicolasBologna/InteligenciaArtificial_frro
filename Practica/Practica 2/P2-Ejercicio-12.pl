inicio:- L = [6,8,20,5,45], menor(L,0,N), print(N).


menor([],Menor,Menor).

menor([C|T],0,MenorDef) :- menor(T,C,MenorDef).
menor([C|T], MenorHastaMomento, MenorDef):- C < MenorHastaMomento, menor(T, C, MenorDef).
menor([_|T], MenorHastaMomento, MenorDef):- menor(T,MenorHastaMomento, MenorDef).
