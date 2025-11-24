%%  Sumar una lista

suma_lista([], 0).

suma_lista([H | T], Resultado)    :-    suma_lista(T, Parcial), 
                                        Resultado is Parcial + H.

%%No listas jajajaj
acceso(admin, 1234, root)       :-!.
acceso(invitado, _, guest)      :-!.
acceso(_,_, denegado).


%%  Eliminar todos los elementos
%%  deleteall(Elemento, Lista, Resultado).

deleteall(_, [], []).

deleteall(Elemento, [Cabeza | Cola], Resultado):- Elemento == Cabeza, deleteall(Elemento, Cola, Resultado).

deleteall(Elemento, [Cabeza | Cola], [Cabeza | Resultado]):-Elemento \= Cabeza,
                                                            deleteall(Elemento, Cola, Resultado).

sumal([], 0).
sumal([Cabeza | Cola], Resultado):- sumal(Cola, Resultado_parcial), 
                                    Resultado is Resultado_parcial + Cabeza.