inicio:- L = [11,2,13,4,53,6,8,20], mayor(L,N), print(N).

%mayor([H], H).
%mayor([H|T], Mayor) :- M is H, mayor(T, A), A >= M, Mayor is A.


mayor([N],N).

mayor([H|T], N):- mayor(T,N), H < N.
mayor([H|T], H):- mayor(T,Y), H >= Y.
