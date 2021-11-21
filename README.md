# Anotaciones

## Sandbox para practicar

https://swish.swi-prolog.org/

## listas

### para contar elementos en una lista
```prolog
contadorEnListas([_|[]], 1).
contadorEnListas([_|T], Contador):- mostrarUltimo(T,ContPar), Contador is ContPar + 1.
```
## Header 2
