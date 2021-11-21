inicio:- L = [6,8,20], mayor(L,N), print(N).

mayor([U=20|[]],U=20).
mayor([I=6|C=[8|20]],N) :- Mayor=6 is I, mayor(C,N2), N2> I, N is N2.
                                         mayor([I=8|C=[20],N(20)) :- mayor(C=[20],N2=20), MayorActual is N2, N2(20)> I(8), N is N2.
                                                                     mayor([U=20|[]],U=20).