# Anotaciones

## Sandbox para practicar

https://swish.swi-prolog.org/

## listas

### para contar elementos en una lista
```prolog
/*Versión profe*/ contadorEnListas([],0).
/*Probe y me anda*/ contadorEnListas([_|[]], 1).
contadorEnListas([_|T], Contador):- mostrarUltimo(T,ContPar), Contador is ContPar + 1.
```

### sumatoria de elementos en una lista
```prolog
sumatoria([], 0).
sumatoria([H|T], Sumatoria):- sumatoria(T,SumPar), Sumatoria is SumPar + H.
```
### promedio de elementos en una lista
```prolog
promedio([], 0, 0).
promedio([H|T], Sumatoria, Contador):- promedio(T,SumPar, ContParc), Sumatoria is SumPar + H, Contador is ContParc + 1.
```

### Buscar un elemento en la lista / Pertenece
```prolog
buscar([H|_], H).
buscar([_|T], Elemento):- buscar(T,Elemento).
buscar(_,_):- write('no se encontro el elemento'). /*Sacar para hacer el PERTENECE*/
```