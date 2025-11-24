%%  mi_longitud(Lista, N)

mi_longitud([], 0).

mi_longitud([_ | Cola], N)   :-  mi_longitud(Cola, S), N is S + 1.