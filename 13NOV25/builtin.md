## 1. write/1
> Descripción: Escribe un término en el flujo de salida actual.

```prolog
ejemplo_write :-
    write('Hola, Prolog!'), nl. 
```

## 2. read/1
> Descripción: Lee un término del flujo de entrada actual.

```prolog
ejemplo_read :-
    write('Introduce un término: '),
    read(X),
    write('Has introducido: '), write(X), nl. 
```

## 3. nl/0
> Descripción: Escribe un carácter de nueva línea en el flujo de salida actual.

```prolog
ejemplo_nl :-
    write('Línea 1.'),
    nl,
    write('Línea 2.'), nl. 
```

## 4. atom/1
> Descripción: Tiene éxito si el término es un átomo.

```prolog
ejemplo_atom :-
    (atom(hola) -> write('hola es un átomo.') ; write('hola no es un átomo.')), nl,
    (atom(123) -> write('123 es un átomo.') ; write('123 no es un átomo.')), nl. 
```

## 5. integer/1
>Descripción: Tiene éxito si el término es un número entero.

```prolog
ejemplo_integer :-
    (integer(123) -> write('123 es un entero.') ; write('123 no es un entero.')), nl,
    (integer(3.14) -> write('3.14 es un entero.') ; write('3.14 no es un entero.')), nl. 
```

## 6. float/1
> Descripción: Tiene éxito si el término es un flotante.

```prolog
ejemplo_float :-
    (float(3.14) -> write('3.14 es un flotante.') ; write('3.14 no es un flotante.')), nl,
    (float(123) -> write('123 es un flotante.') ; write('123 no es un flotante.')), nl. 
```

## 7. number/1
> Descripción: Tiene éxito si el término es un número (entero o flotante).

```prolog
ejemplo_number :-
    (number(123) -> write('123 es un número.') ; write('123 no es un número.')), nl,
    (number(3.14) -> write('3.14 es un número.') ; write('3.14 no es un número.')), nl,
    (number(hola) -> write('hola es un número.') ; write('hola no es un número.')), nl. 
```

## 8. append/3
> Descripción: Concatena dos listas.

```prolog
ejemplo_append :-
    append([a, b], [c, d], L),
    write('La lista concatenada es '), write(L), nl. 
```

## 9. select/3
> Descripción: Es cierto si se puede eliminar Elem de Lista1 para obtener Lista2.

```prolog
ejemplo_select :-
    select(b, [a, b, c], Resto),
    write('Al eliminar b de [a, b, c] se obtiene: '), write(Resto), nl. 
```

## 10. nth0/3
> Descripción: Tiene éxito si Elem es el elemento en la posición de índice N (comenzando en 0) de la Lista.

```prolog
ejemplo_nth0 :-
    nth0(1, [a, b, c], Elem),
    write('El elemento en el índice 1 de [a, b, c] es: '), write(Elem), nl,
    nth0(Index, [a, b, c], c),
    write('El elemento c está en el índice: '), write(Index), nl.
```
