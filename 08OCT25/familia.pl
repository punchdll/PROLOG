%Mujeres
mujer(pilar).
mujer(elena).
mujer(sara).
mujer(sofia).
mujer(carmen).
mujer(ana).
mujer(valeria).
mujer(isabel).
mujer(lucia).

%Hombres
hombre(javier).
hombre(carlos).
hombre(alberto).
hombre(jose).
hombre(mario).
hombre(antonio).
hombre(miguel).
hombre(david).


madre(elena).
madre(ana).
madre(isabel).

padre(carlos).
padre(jose).
padre(miguel).

% madre_de(Madre, Hijo_o_Hija)
madre_de(elena, sara).
madre_de(elena, sofia).  
madre_de(ana, valeria).
madre_de(isabel, lucia).
madre_de(isabel, david). 

% padre_de(Padre, Hijo_o_Hija)
padre_de(carlos, sara).
padre_de(carlos, sofia).
padre_de(jose, valeria).
padre_de(miguel, lucia).
padre_de(miguel, david). 

padre_de(antonio, ana).
padre_de(antonio, miguel).
padre_de(antonio, isabel).

padre_de(javier, carlos).
padre_de(javier, jose).
padre_de(javier, elena).

%reglas

hermanos(X, Y) :- madre_de(P, X), madre_de(P, Y), X \== Y.

abuelo_de(X, Z) :- padre_de(X, Y), padre_de(Y, Z).

abuela_de(X, Z) :- madre_de(X, Y), madre_de(Y, Z).

primos(X, Y) :-( padre_de(P, X), padre_de(Q, Y), hermanos(P, Q)
                ; madre_de(R, X), madre_de(S, Y), hermanos(R, S)).