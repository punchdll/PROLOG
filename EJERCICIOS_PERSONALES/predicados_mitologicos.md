## setof/3

Sintaxis:
`setof(Plantilla, Predicado, Resultado).`

**Ejemplo:**

```prolog
?-  setof(X, hermano(sansa, X), Lista).

%%  Resultado

Lista = [arya, robb].
```

## reverse/2

Sintaxis:
`reverse(Lista, Lista_al_reves)`

**Ejemplo:**

```prolog
?-  reverse([1, 2], Lista_al_reves).

%%  Resultado

Lista_al_reves = [2, 1].
```