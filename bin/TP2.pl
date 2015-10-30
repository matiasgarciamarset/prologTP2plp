% ####################################
% Calentando motores
% ####################################

%%% Ejercicio 1

% listaNats(+LInf,+LSup,?Nats), que unifica la lista Nats con los naturales en el rango [LInf, LSup], o una lista vacía si LSup < LInf.

% Unifica Nats con una lista vacia, un lista de un elemento, o
% una lista recursiva dependiendo del signo de la diferencia entre X e Y.
listaNats(X, Y, []) :- X > Y.
listaNats(X, X, [X]).
listaNats(X, Y, [X|T]) :- X < Y, Z is X + 1, listaNats(Z, Y, T).

%MATIAS:
% Esta bien hacer X + 1 cuando es "?Nats" ??? 

%%% Ejercicio 2

% nPiezasDeCada(+Cant, +Tamaños, -Piezas), que instancia a Piezas con una lista que contiene 
%  una cantidad Cant de cada tamaño en la lista Tamaños.

% Unifica Piezas con una lista de una pirza por cada elemento de Tamaños.
% Asume que Tamaños no tiene repetidos.
nPiezasDeCada(_, [], []).
nPiezasDeCada(N, [L|K], [H|T]) :- H = pieza(L, N), nPiezasDeCada(N, K, T).

%MATIAS: Yo ubiese puesto nPiezasDeCada(N, [L|K], [pieza(L, N)|T]) :-  nPiezasDeCada(N, K, T). es igual?

%%% Ejercicio 3

% resumenPiezas(+SecPiezas, -Piezas), que permite instanciar Piezas con la lista de
%  piezas incluidas en SecPiezas. 

% Unifica Piezas con una lista ordenada de piezas con cada elemento igual a
% un elemento de SecPiezas y la cantidad de veces que aparece.
% Para hacer esto se aprovecha del predicado delete(+L1, @Elem, -L2) que
% unifica L2 con L1 sin los elementos que matcheen con Elem.

% Hay una manera mas linda de hacer esto?
resumenPiezas([], []).
resumenPiezas(S, P) :-
	min_list(S, M), delete(S, M, D), length(S, A), length(D, B), L is A - B,
	resumenPiezas(D, Q), nPiezasDeCada(L, [M], W),
	append(W, Q, P).

/*
%cuenta la cantidad de apariciones de un elemento en una lista
%countAt(?,+,?)
countAt([],_,Y) :- Y = 0.
countAt([H|T],X,Y) :- X = H ,   countAt(T,X,Z), Y is Z+1.
countAt([H|T],X,Y) :- dif(X , H) ,   countAt(T,X,Z), Y is Z.

% 1 unifico la pieza con el numero y su cantidad
% 2 cuenta la cantidad de veces que aparece el elemento en la lista completa
% 3 borro el elemento y sus repeticiones en la lista
% 4 llamo recursivamente con el resto de las piezas y elementos.
%resumenPiezas(+,-)
resumenPiezas([], []).
resumenPiezas([H|T],[X|XS]) :-  X = (H,W), countAt([H|T],H,W), delete([H|T],H,Q), resumenPiezas(Q,XS). 



%MATIAS:
%resumenPiezas([], []).
%resumenPiezas([X|Y|Z], [pieza(X,Y)|W]) :- resumenPiezas(Z,W).
*/

% ####################################
% Enfoque naïve
% ####################################

%%% Ejercicio 4

% Predicado auxiliar:
% sumList(?L, ?N), donde L es una lista de enteros positivos y N representa
% su suma. Similar a sum_list, pero reversible.
sumList([], 0).
sumList([H|T], N) :- nonvar(N), between(1, N, H), Q is N - H, sumList(T, Q).
sumList([H|T], N) :- ground([H|T]), sumList(T, X), N is X + H.
sumList(L, N) :- var(N), between(1, inf, N), sumList(L, N).

% generar(+Total,+Piezas,-Solución), donde Solución representa una lista de piezas
%  cuyos valores suman Total. Aquí no se pide controlar que la cantidad de cada pieza
%  esté acorde con la disponibilidad.

% Este puede generar varias soluciones iguales. Esto esta bien? Si no,
% hay que modificar sumList para que solo devuelva listas ordenadas.
generar(T, _, S) :- sumList(L, T), resumenPiezas(L, S).

%%% Ejercicio 5 

% Predicado auxiliar:
% equalList(+L, +N, -S), donde S es una lista con N elementos iguales a L.
equalList(_, 0, []).
equalList(L, N, [L|T]) :- N > 0, M is N - 1, equalList(L, M, T).

% Predicado auxiliar
% piezasALista(+Piezas, -SecPiezas), donde L es una lista que contiene las piezas de P.
% Es el inverso de resumenPiezas. Capaz este bueno juntar estas dos funciones.
piezasALista([], []).
piezasALista([pieza(R, C) | T], Q) :- equalList(R, C, A), append(A, B, Q), piezasALista(T, B).

% cumpleLímite(+Piezas,+Solución) será verdadero cuando la cantidad de piezas utilizadas en Solución 
%  no exceda las cantidades disponibles indicadas en Piezas
cumpleLimite(Piezas, Solucion) :- piezasALista(Piezas, A), piezasALista(Solucion, B), ord_subset(B, A).

%%% Ejercicio 6

% construir1(+Total,+Piezas,-Solución), donde Solución representa una lista de piezas cuyos valores 
%  suman Total y, además, las cantidades utilizadas de cada pieza no exceden los declarados en Piezas.
construir1(T, P, S) :- generar(T, P, S), cumpleLimite(P, S).

% ####################################
% Enfoque dinámico
% ####################################

%%% Ejercicio 7

% construir2(+Total,+Piezas,-Solución), cuyo comportamiento es id ́entico a construir1/3 pero que utiliza 
%  definiciones dinámicas para persistir los cálculos auxiliares realizados y evitar repetirlos. 
%  No se espera que las soluciones aparezcan en el mismo orden entre construir1/3 y construir2/3, pero sí, sean las mismas.

%implemente esta funcion, calcula los resultados sin duplicados. 
% me resulto mas utiil usar las tuplas, despues para pasar a piezas es una boludez

%explicacion 
% 1 - extraigo cantidad y valor de pieza
% 2 - tomo todos los valores entre el valor de la pieza y la suma total que quiero generar
% 3 - divido el valor que quiero sumar, por el valor de la pieza, Eso me genera un cociente C  y un resto R 
% 4 - valido que la division de resto 0, 
% 5 - valido que tenga la cantidad de piezas necesarias de ese largo
% 6 - genero la pieza, con el valor de la original P pero utilizo C piezas con ese valor
% 7 - calculo cuanta longitud me queda cubrir
% 8 - llamo recursivamente con las piezas de otra longitud, y para cubrir el resto de espacio que queda. 
%construir2(0,[],[]).
%                                 1     -         2      -       3         -    4     -    5   -   6     -   7      -    8
%construir2(T,[X|XS],[A|B]) :- (P,G) = X,  between(P,T,N), divmod(N,P,C,R) , R =:= 0  , C =< G ,A = (P,C), L is T-N ,  construir2(XS,L,B).
%construir2(T,[_|XS],Q) :- construir2(XS,T,Q).
%construir2([(2,3),(1,10)],10,X).
%construir2([(2,3),(1,10)],2,X).
%construir2([(2,3),(1,10)],6,X).



%esta es la version dinamica, utiliza registros para no recalcular subresultados
construir2(X,Y,Z) :- term_hash( (X,Y) ,H), recorded(H,V,_), Z = V .
construir2(X,Y,Z) :- term_hash( (X,Y) ,H), \+ recorded(H,_,_ ),  construir2work(X,Y,Z),  recorda(H, Z  ,_).

construir2work(0,[],[]).
construir2work(T,[X|XS],[A|B]) :- (P,G) = X,  between(P,T,N), divmod(N,P,C,R) , R =:= 0  , C =< G ,A = (P,C), L is T-N , construir2(L,XS,B).
construir2work(T,[_|XS],Q) :- construir2(T,XS,Q).


% ####################################
% Comparación de resultados y tiempos
% ####################################

%%% Ejercicio 8

% todosConstruir1(+Total, +Piezas, -Soluciones, -N), donde Soluciones representa una lista con todas las
%  soluciones de longitud Total obtenidas con construir1/3, y N indica la cantidad de soluciones totales.

todosConstruir1(_, _, _, _):- fail.


%%% Ejercicio 9

% todosConstruir2(+Total, +Piezas, -Soluciones, -N), donde Soluciones representa una lista con todas 
%  las soluciones de longitud Total obtenidas con construir2/3, y N indica la cantidad de soluciones totales.

todosConstruir2(_, _, _, _):- fail.


% ####################################
% Patrones
% ####################################

%%% Ejercicio 10

% construirConPatron(+Total, +Piezas, ?Patrón, -Solución) será verdadero cuando Solución sea una solución factible 
%  en los términos definidos anteriormente y, además, sus piezas respeten el patrón indicado en Patrón. 
%  Se sugiere definir un predicado tienePatrón(+Lista, ?Patrón) que decida si Lista presenta el Patrón especificado.

construirConPatron(_, _, _, _):- fail.
