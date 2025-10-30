%Despedida
eliza(Input):- Input == ['adios'], writeln('Adios. espero poder verte ayudado.'), !.
eliza(Input):- Input == ['adios', '.'], writeln('Adios. espero poder verte ayudado.'), !.
eliza(Input):- Input == ['bye'], writeln('Bye. Vuelve pronto.'), !.
eliza(Input):- Input == ['bye', '.'], writeln('Bye. Vuelve pronto.'), !.
eliza(Input):- Input == ['chao'], writeln('Chao. Cuidate.'), !.
eliza(Input):- Input == ['chao', '.'], writeln('Chao. Cuidate.'), !.
eliza(Input):- Input == ['hasta, luego'], writeln('Hasta luego. Que tengas un buen dia.'), !.
eliza(Input):- Input == ['hasta, luego', '.'], writeln('Hasta luego. Que tengas un buen dia.'), !.
eliza(Input):- Input == ['nos, vemos'], writeln('Nos vemos!'), !.
eliza(Input):- Input == ['nos, vemos', '.'], writeln('Nos vemos!'), !.
eliza(Input):- Input == ['hasta, la, proxima'], writeln('Hasta la proxima! Estare aqui.'), !.
eliza(Input):- Input == ['hasta, la, proxima', '.'], writeln('Hasta la proxima! Estare aqui.'), !.
eliza(Input):- Input == ['salir'], writeln('Saliendo... Adios.'), !.
eliza(Input):- Input == ['terminar'], writeln('Terminando sesion. Adios.'), !.
eliza(Input):- Input == ['ya, me, voy'], writeln('Esta bien. Adios.'), !.
eliza(Input):- Input == ['ya, me, voy', '.'], writeln('Esta bien. Adios.'), !.
eliza(Input):- Input == ['tengo, que, irme'], writeln('Entendido. Vuelve pronto.'), !.
eliza(Input):- Input == ['tengo, que, irme', '.'], writeln('Entendido. Vuelve pronto.'), !.
eliza(Input):- Input == ['eso, es, todo'], writeln('Perfecto. Que estes bien. Adios.'), !.
eliza(Input):- Input == ['eso, es, todo', '.'], writeln('Perfecto. Que estes bien. Adios.'), !.

%Saludo
template([hola], ['Hola!', 'En', que, puedo, ayudarte', '?'], []).
template([hey], ['Hola.', 'Dime', 'tu', 'consulta', '.'], []).
template([que, tal], ['Que', 'tal!', 'Cual', 'es', 'tu', 'pregunta', '?'], []).
template([que, onda], ['Hola.', 'Estoy', 'lista', 'para', 'tu', 'consulta', '.'], []).
template([saludos], ['Saludos.', 'En', que, te', 'ayudo', '?'], []).
template([buena, tarde], ['Buenas', 'tardes.', 'Cual', 'es', 'tu', 'consulta', '?'], []).
template([buenas, noches], ['Buenas', 'noches.', 'En', que, te', 'puedo', 'ayudar', '?'], []).
template([que, hay], ['Todo', 'bien.', 'Que', 'necesitas', '?'], []).
template([hola, '.'], ['Hola!', 'En', que, puedo, ayudarte', '?'], []).
template([hey, '.'], ['Hola.', 'Dime', 'tu', 'consulta', '.'], []).
template([como, estas, '?'], ['Yo', estoy, 'bien', ',', gracias, '.', 'Cual', 'es', 'tu', 'consulta', '?'], []).
template([como, estas, tu, '?'], ['Yo', estoy, 'bien', ',', gracias, '.', 'Cual', 'es', 'tu', 'consulta', '?'], []).
template([como, te, va, '?'], ['Todo', 'en', 'orden.', 'Dime', 'en', 'que', 'puedo', 'ayudarte', '.'], []).
template([todo, bien, '?'], ['Si,', 'todo', 'bien.', 'Cual', 'es', 'tu', 'duda', '?'], []).
template([hola, ',', me, llamo, s(_), '.'], ['Hola', 0, '!', 'Mucho', 'gusto', '.'], [3]).
template([buenas, tardes, ',', me, llamo, s(_), '.'], ['Buenas', 'tardes', 0, '.', 'En', 'que', 'te', 'ayudo', '?'], [4]).
template([hey, ',', mi, nombre, es, s(_), '.'], ['Que', 'tal', 0, '!', 'Un', 'placer', '.'], [5]).
template([me, llamo, s(_)], ['Hola', 0, '.', 'Bonito', 'nombre', '.'], [1]).
template([mi, nombre, es, s(_)], ['Hola', 0, '.', 'Encantada', 'de', 'conocerte', '.'], [3]).
template([soy, s(_), '.'], ['Hola', 0, '.', 'En', 'que', 'puedo', 'ayudarte', '?'], [1]).