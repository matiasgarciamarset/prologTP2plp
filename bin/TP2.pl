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

%%% Ejercicio 2

% nPiezasDeCada(+Cant, +Tamaños, -Piezas), que instancia a Piezas con una lista que contiene 
%  una cantidad Cant de cada tamaño en la lista Tamaños.

% Unifica Piezas con una lista de una pirza por cada elemento de Tamaños.
% Asume que Tamaños no tiene repetidos.
nPiezasDeCada(_, [], []).
nPiezasDeCada(N, [L|K], [H|T]) :- H = pieza(L, N), nPiezasDeCada(N, K, T).


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
*/
% ####################################
% Enfoque naïve
% ####################################

%%% Ejercicio 4

% Predicado auxiliar:
% isOrdered(+L): Tiene exito sii L esta ordenada.
isOrdered([]).
isOrdered([H|T]) :- min_list([H|T], H), isOrdered(T).

% Predicado auxiliar:
% sumOPListFrom(-L, +N, +F): Unifica L con una lista ordenada de enteros positivos
% cuya suma sea N y cuyo primer elemento sea menor o igual a F.
sumOPListFrom([], 0, _).
sumOPListFrom([H|T], N, F) :- between(F, N, H), Q is N - H, sumOPListFrom(T, Q, H).

% Predicado auxiliar:
% sumOPList(?L, ?N): Unifica L, una lista ordenada de enteros positivos,
% con la suma de sus elementos igual a N.
sumOPList(L, N) :- nonvar(N), var(L), sumOPListFrom(L, N, 1).
sumOPList(L, N) :- nonvar(L), isOrdered(L), sum_list(L, N).
sumOPList(L, N) :- var(L), var(N), between(1, inf, N), sumOPList(L, N).

% generar(+Total,+Piezas,-Solución), donde Solución representa una lista de piezas
%  cuyos valores suman Total. Aquí no se pide controlar que la cantidad de cada pieza
%  esté acorde con la disponibilidad.
generar(T, _, S) :- sumOPList(L, T), resumenPiezas(L, S).

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

construirwork(0,_,[]).
construirwork(SUMA,PIEZAS,[X|XS]) :- SUMA>0,
				      generar2(SUMA,PIEZAS,ACTUAL,TOMO,REEMPLAZO,RESTO), 	
				pieza(_,CANT) = REEMPLAZO, 
				CANT =:= 0 , 
				select(ACTUAL,PIEZAS,RESTOPIEZAS),
				X = TOMO,
				construirwork(RESTO,RESTOPIEZAS,XS),
				sinPiezasIgualesContiguas([X|XS]).
construirwork(SUMA,PIEZAS,[X|XS]) :- SUMA>0,  generar2(SUMA,PIEZAS,ACTUAL,TOMO,REEMPLAZO,RESTO), 
				pieza(_,CANT) = REEMPLAZO, 
				CANT > 0 , 
				select(ACTUAL,PIEZAS,REEMPLAZO,RESTOPIEZAS),
				X = TOMO,
				construirwork(RESTO,RESTOPIEZAS,XS),
				sinPiezasIgualesContiguas([X|XS]).

% construir1(+Total,+Piezas,-Solución), donde Solución representa una lista de piezas cuyos valores 
%  suman Total y, además, las cantidades utilizadas de cada pieza no exceden los declarados en Piezas.
construir1(T, P, S) :- construirwork(T, P, S2), piezasEnLista(S2,S).

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
% term_hash me da una key en base a el predicado (X,Y) para generar el indice en la base de datos
% recorded se fija si esta almacenado un resultaod con ese indice
% recorda hace el store de un predicado con una key determinada.


construir2(SUMA,PIEZAS,RESULTADO) :- construir2dinamico(SUMA,PIEZAS,COMPRIMIDO), piezasEnLista(COMPRIMIDO,RESULTADO).

construir2dinamico(X,Y,Z) :- term_hash( (X,Y) ,H), recorded(H,V,_), Z = V .
construir2dinamico(X,Y,Z) :- term_hash( (X,Y) ,H), \+ recorded(H,_,_ ),  construir2work(X,Y,Z),  recorda(H, Z  ,_).


sinPiezasIgualesContiguas([]).
sinPiezasIgualesContiguas([_]).
sinPiezasIgualesContiguas([X,Y|ZS]) :- pieza(A,_) = X, pieza(C,_) = Y , A =\= C, sinPiezasIgualesContiguas([Y|ZS])  .

piezasEnLista([],[]).
piezasEnLista([P|PS],[X|XS]) :- pieza(VAL,CANT) = P, CANT =:= 1 , X = VAL, piezasEnLista(PS,XS). 
piezasEnLista([P|PS],[X|XS]) :- pieza(VAL,CANT) = P, CANT > 1 , X = VAL , CANTMENOS is CANT - 1 , 
				piezasEnLista( [ pieza(VAL,CANTMENOS) | PS] , XS).

%generar2(+SUMA,+PIEZAS,-ACTUAL,-REEMPLAZO,-RESTO)
generar2( SUMA, PIEZAS,PACTUAL, PTOMO,PRESTO, SUMARESTO) :-  length(PIEZAS,LEN), 
					   LEN>0, 
					   member(PACTUAL,PIEZAS), 
					       pieza(P,G) = PACTUAL, 
					       between(P,SUMA,N), 
					       divmod(N,P,C,R), 
					       R =:= 0, 
					       C =< G, 
					       RESTOPIEZAS is G - C,
					       PRESTO = pieza(P,RESTOPIEZAS), 
					       PTOMO = pieza(P,C),
					       SUMARESTO is SUMA-N.

construir2work(0,_,[]).
construir2work(SUMA,PIEZAS,[X|XS]) :- SUMA>0,
				      generar2(SUMA,PIEZAS,ACTUAL,TOMO,REEMPLAZO,RESTO), 	
				pieza(_,CANT) = REEMPLAZO, 
				CANT =:= 0 , 
				select(ACTUAL,PIEZAS,RESTOPIEZAS),
				X = TOMO,
				construir2dinamico(RESTO,RESTOPIEZAS,XS),
				sinPiezasIgualesContiguas([X|XS]).


construir2work(SUMA,PIEZAS,[X|XS]) :- SUMA>0,  generar2(SUMA,PIEZAS,ACTUAL,TOMO,REEMPLAZO,RESTO), 
				pieza(_,CANT) = REEMPLAZO, 
				CANT > 0 , 
				select(ACTUAL,PIEZAS,REEMPLAZO,RESTOPIEZAS),
				X = TOMO,
				construir2dinamico(RESTO,RESTOPIEZAS,XS),
				sinPiezasIgualesContiguas([X|XS]).


% ####################################
% Comparación de resultados y tiempos
% ####################################

%%% Ejercicio 8

% todosConstruir1(+Total, +Piezas, -Soluciones, -N), donde Soluciones representa una lista con todas las
%  soluciones de longitud Total obtenidas con construir1/3, y N indica la cantidad de soluciones totales.

todosConstruir1(T, P, Z, N):- findall(X,construir1(T,P,X),Z),  length(Z, N) .

%%% Ejercicio 9

% todosConstruir2(+Total, +Piezas, -Soluciones, -N), donde Soluciones representa una lista con todas 
%  las soluciones de longitud Total obtenidas con construir2/3, y N indica la cantidad de soluciones totales.

todosConstruir2(T, P, Z, N) :- findall(X,construir2(T,P,X),Z),  length(Z, N) .

% ####################################
% Patrones
% ####################################

%%% Ejercicio 10

% construirConPatron(+Total, +Piezas, ?Patrón, -Solución) será verdadero cuando Solución sea una solución factible 
%  en los términos definidos anteriormente y, además, sus piezas respeten el patrón indicado en Patrón. 
%  Se sugiere definir un predicado tienePatrón(+Lista, ?Patrón) que decida si Lista presenta el Patrón especificado.

construirConPatron(TOTAL,PIEZAS,PATRON,SOLUCION):- construir2(TOTAL,PIEZAS,SOLUCION), tienePatron(PATRON,SOLUCION).


tienePatron([],[]). 
tienePatron(X,Y) :-           length(X,XLEN),
			      length(Y,YLEN), 			      
			      divmod(YLEN,XLEN,COSIENTE,RESTO),
			      RESTO =:= 0,
			      COSIENTE > 1,
		              append(HEADSOLUTION,TAILPATTERN,Y),
			      length(HEADSOLUTION,XLEN),
			      unifiable(X,HEADSOLUTION,_),
			      X=HEADSOLUTION,
			      tienePatron(X,TAILPATTERN).
			      
tienePatron(X,Y) :- length(X,XLEN),
			      length(Y,YLEN), 			      
			      divmod(YLEN,XLEN,COSIENTE,RESTO),
			      RESTO =:= 0,
			      COSIENTE =:= 1,
		              append(HEADSOLUTION,_,Y),
			      length(HEADSOLUTION,XLEN),
			      unifiable(X,HEADSOLUTION,_).
			      
% La siguiente funcion es para test:

generaok(T,Z) :- findall(X,generar(T,_,X),Z) .
