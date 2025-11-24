%%  Hechos para los investigadores

investigador('Ana').
investigador('Bruno').
investigador('Carlos').
investigador('Diana').
investigador('Elisa').

%%  Hechos para las especialidades
especialidad('Genética').
especialidad('Microbiología').
especialidad('Bioquímica').
especialidad('Inmunología').
especialidad('Neurociencia').

%%  Hechos especificos
especialidad('Ana', 'Genética'):-!, fail.
especialidad('Ana', 'Neurociencia'):-!, fail.
especialidad('Diana', 'Microbiología').
especialidad(Investigador, 'Neurociancia'):- pais(Investigador, 'España').

%%  Hechos para los horarios

horario('6 am').
horario('8 am').
horario('10 am').
horario('12 pm').
horario('14 pm').

%%  Hechos especificos
horario('Genética', Horario):- Horario = '6 am'.  
horario(Investigador, Horario):- pais('Perú', Investigador), Horario = '10 am'.


%%  Hechos para bebidas
bebida('Café').
bebida('Té').
bebida('Jugo').
bebida('Mate').
bebida('Agua').

%%  Hechos especificos
bebida(Investigador, 'Mate'):- pais(Investigador, 'Argentina').
bebida('Elisa', 'Café'):- !, fail.
bebida('Elisa', 'Té'):- !, fail.



%%  Hechos para equipos
equipo('Microscopio').
equipo('Centrífuga').
equipo('PCR').
equipo('Espectrómetro').
equipo('Incubadora').

%%  Hechos especificos
equipo(Investigador, 'PCR'):- especialidad(Investigador, 'Inmunología').
equipo(Investigador, 'Microscopio'):- \+ pais(Investigador, 'México').

% %%-->Incompleta
% equipo(Investigador, 'Incubadora'):- horario().

%% ?
equipo('Carlos', 'Espectrómetro').

%%  Hechos para paises
pais('México').
pais('Chile').
pais('España').
pais('Argentina').
pais('Perú').

pais(Investigador, 'Chile'):- especialidad(Investigador, 'Bioquímica').
pais('Bruno', 'México'):- !, fail.







