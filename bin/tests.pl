% Se ejecuta cargando el archivo en el interprete 
% y corriento "run_tests."

:- ['TP2.pl'].

no_effect(true).


:- begin_tests(ejercicio1).

    test(casovacio) :- listaNats(6,1,[]).

    test(casobase) :- listaNats(1,1,[1]).

    test(casonormal) :- listaNats(1,6,[1,2,3,4,5,6]).

:- end_tests(ejercicio1).

:- begin_tests(ejercicio2).

	test(casovacio) :- nPiezasDeCada(3,[],[]).

    test(casonormal) :- nPiezasDeCada(3,[1,2,3],[pieza(1, 3), pieza(2, 3), pieza(3, 3)] ).

:- end_tests(ejercicio2).

:- begin_tests(ejercicio3).

	test(casonvacio) :- resumenPiezas([],[]).

	test(casonormal1) :- resumenPiezas([2,2,1,2,3,10,1],[pieza(1,2),pieza(2,3),pieza(3,1),pieza(10,1)]).

	test(casonormal2) :- resumenPiezas([4,4,4,4],[pieza(4, 4)]).
	
	test(casonormal3) :- resumenPiezas([4,4,1,2,10,100], [pieza(1, 1), pieza(2, 1), pieza(4, 2), pieza(10, 1), pieza(100, 1)]) .

:- end_tests(ejercicio3).


:- begin_tests(ejercicio4).

	test(casonvacio) :- resumenPiezas([],[]).

	test(casonormal1) :- generar(4000,[pieza(4, 2), pieza(10, 1), pieza(100, 1)],[pieza(1, 4000)]).

	test(casogeneral2) :- generaok(2,[[pieza(1, 2)], [pieza(2, 1)]]).

	test(casogeneral4) :- generaok(4,[[pieza(1, 4)], [pieza(1, 2), pieza(2, 1)], [pieza(1, 1), pieza(3, 1)], [pieza(2, 2)], [pieza(4, 1)]]).

:- end_tests(ejercicio4).

:- begin_tests(ejercicio5).

	test(casonvacio) :- cumpleLimite([pieza(1,2),pieza(2,3)],S),subset(S,[]).

	test(casonormal1) :- cumpleLimite([pieza(1,2),pieza(2,3)],S),subset(S,[pieza(1,1)]).

	test(casogeneral2) :- cumpleLimite([pieza(1,2),pieza(2,3)],S),subset(S,[pieza(1,1),pieza(2,2)]).

:- end_tests(ejercicio5).

% NOTAR que los tests del ejecicio8 y ejercicio9 son los mismos salvo que utilizando la funcion construir1 y construir2, respectivamente.
% Esto se debe a que de ambos deberian retornar los mismos resultados.
% Abajo de cada test se puede observar comentado el tiempo de ejecucion. 

% Aqui tambien se testea el 6
:- begin_tests(ejercicio8).

	test(correctitud1) :- todosConstruir1(1,[pieza(1,3)],S,1), subset(S,[[1]]).

	test(correctitud2) :- todosConstruir1(4,[pieza(1,3),pieza(2,4)],S,4), subset(S,[[1, 2, 1], [1, 1, 2], [2, 1, 1], [2, 2]]).

	test(correctitud3) :- todosConstruir1(8,[pieza(3,2),pieza(2,4),pieza(1,1)],S,16), subset(S,[[3, 3, 2],[2, 2, 2, 2],[1, 3, 2, 2],[1, 2, 3, 2],[1, 2, 2, 3],[3, 1, 2, 2],[3, 2, 3],[3, 2, 1, 2],[3, 2, 2, 1],[2, 3, 3],[2, 1, 3, 2],[2, 1, 2, 3],[2, 3, 1, 2],[2, 3, 2, 1],[2, 2, 1, 3],[2, 2, 3, 1]]).

	test(casonormal0) :- todosConstruir1(5,[pieza(1,3),pieza(2,2)],S,7), subset([[1, 1, 1, 2],[2, 2, 1],[1, 2, 2],[1, 2, 1, 1],[1, 1, 2, 1],[2, 1, 1, 1],[2, 1, 2]],S).
	%Tiempo: 

	test(casonormal1) :- todosConstruir1(10,[pieza(2,2),pieza(1,2),pieza(3,2)],S,36), subset(S,[[2, 2, 3, 3],[1, 1, 3, 3, 2],[1, 1, 2, 3, 3],[1, 1, 3, 2, 3],[3, 3, 2, 2],[3, 3, 1, 1, 2],[3, 3, 2, 1, 1],[3, 3, 1, 2, 1],[2, 1, 1, 3, 3],[2, 3, 3, 1, 1],[2, 3, 3, 2],[2, 1, 3, 3, 1],[2, 1, 3, 1, 3],[2, 3, 2, 3],[2, 3, 1, 1, 3],[2, 3, 1, 3, 1],[1, 3, 3, 2, 1],[1, 3, 3, 1, 2],[1, 2, 3, 1, 3],[1, 2, 3, 3, 1],[1, 2, 1, 3, 3],[1, 3, 1, 2, 3],[1, 3, 1, 3, 2],[1, 3, 2, 3, 1],[1, 3, 2, 1, 3],[3, 2, 2, 3],[3, 1, 1, 2, 3],[3, 1, 1, 3, 2],[3, 2, 1, 3, 1],[3, 2, 3, 2],[3, 2, 3, 1, 1],[3, 2, 1, 1, 3],[3, 1, 2, 1, 3],[3, 1, 2, 3, 1],[3, 1, 3, 1, 2],[3, 1, 3, 2, 1]]).
	%Tiempo: 

	test(casonormal2) :- todosConstruir1(20,[pieza(3,2),pieza(4,2),pieza(5,2),pieza(7,2)],S,60), subset(S,[[7, 5, 4, 4],[7, 5, 3, 5],[7, 4, 5, 4],[7, 3, 5, 5] ,[7, 3, 7, 3],[7, 5, 5, 3],[7, 4, 4, 5],[7, 3, 3, 7],[5, 7, 3, 5],[5, 7, 5, 3],[5, 7, 4, 4],[5, 4, 3, 3, 5],[5, 4, 5, 3, 3],[5, 4, 3, 5, 3],[5, 4, 7, 4],[5, 3, 5, 7],[5, 3, 5, 4, 3],[5, 3, 5, 3, 4],[5, 3, 4, 5, 3],[5, 3, 4, 3, 5],[5, 3, 7, 5],[5, 4, 4, 7],[5, 3, 3, 5, 4],[5, 3, 3, 4, 5],[4, 7, 5, 4],[4, 7, 4, 5],[4, 5, 7, 4],[4, 5, 3, 5, 3],[4, 5, 4, 7],[4, 5, 3, 3, 5],[4, 3, 5, 5, 3],[4, 3, 5, 3, 5],[4, 5, 5, 3, 3],[4, 3, 3, 5, 5],[3, 7, 5, 5],[3, 7, 3, 7],[3, 5, 7, 5],[3, 5, 4, 3, 5],[3, 5, 4, 5, 3],[3, 5, 3, 5, 4],[3, 5, 3, 4, 5],[3, 4, 5, 3, 5],[3, 4, 5, 5, 3],[3, 4, 3, 5, 5],[3, 7, 7, 3],[3, 5, 5, 3, 4],[3, 5, 5, 4, 3],[3, 5, 5, 7],[7, 7, 3, 3],[5, 5, 7, 3],[5, 5, 4, 3, 3],[5, 5, 3, 7],[5, 5, 3, 4, 3],[5, 5, 3, 3, 4],[4, 4, 7, 5],[4, 4, 5, 7],[3, 3, 5, 4, 5],[3, 3, 4, 5, 5],[3, 3, 7, 7],[3, 3, 5, 5, 4]]).
	%Tiempo: 

	test(casonormal3) :- todosConstruir1(30,[pieza(5,2),pieza(7,2),pieza(9,2),pieza(8,1),pieza(10,2)],S,42), subset(S,[[10, 7, 8, 5],[10, 7, 5, 8],[10, 5, 8, 7],[10, 5, 10, 5],[10, 5, 7, 8],[10, 8, 5, 7],[10, 8, 7, 5],[10, 5, 5, 10],[9, 7, 9, 5],[9, 7, 5, 9],[9, 5, 9, 7],[9, 5, 7, 9],[7, 10, 5, 8],[7, 10, 8, 5],[7, 9, 5, 9],[7, 5, 9, 9],[7, 5, 8, 10],[7, 5, 10, 8],[7, 8, 5, 10],[7, 8, 10, 5],[7, 9, 9, 5],[5, 10, 7, 8],[5, 10, 8, 7],[5, 10, 5, 10],[5, 9, 7, 9],[5, 7, 10, 8],[5, 7, 8, 10],[5, 7, 9, 9],[5, 10, 10, 5],[5, 8, 7, 10],[5, 8, 10, 7],[5, 9, 9, 7],[10, 10, 5, 5],[8, 10, 7, 5],[8, 10, 5, 7],[8, 7, 10, 5],[8, 7, 5, 10],[8, 5, 10, 7],[8, 5, 7, 10],[9, 9, 7, 5],[9, 9, 5, 7],[5, 5, 10, 10]]).
	%Tiempo: 

:- end_tests(ejercicio8).

% Aqui tambien se testea el 7
:- begin_tests(ejercicio9).

	test(correctitud1) :- todosConstruir2(1,[pieza(1,3)],S,1), subset(S,[[1]]).

	test(correctitud2) :- todosConstruir2(4,[pieza(1,3),pieza(2,4)],S,4), subset(S,[[1, 2, 1], [1, 1, 2], [2, 1, 1], [2, 2]]).

	test(correctitud3) :- todosConstruir2(8,[pieza(3,2),pieza(2,4),pieza(1,1)],S,16), subset(S,[[3, 3, 2],[2, 2, 2, 2],[1, 3, 2, 2],[1, 2, 3, 2],[1, 2, 2, 3],[3, 1, 2, 2],[3, 2, 3],[3, 2, 1, 2],[3, 2, 2, 1],[2, 3, 3],[2, 1, 3, 2],[2, 1, 2, 3],[2, 3, 1, 2],[2, 3, 2, 1],[2, 2, 1, 3],[2, 2, 3, 1]]).

	test(casonormal0) :- todosConstruir2(5,[pieza(1,3),pieza(2,2)],S,7), subset([[1, 1, 1, 2],[2, 2, 1],[1, 2, 2],[1, 2, 1, 1],[1, 1, 2, 1],[2, 1, 1, 1],[2, 1, 2]],S).
	%Tiempo: 

	test(casonormal1) :- todosConstruir2(10,[pieza(2,2),pieza(1,2),pieza(3,2)],S,36), subset(S,[[2, 2, 3, 3],[1, 1, 3, 3, 2],[1, 1, 2, 3, 3],[1, 1, 3, 2, 3],[3, 3, 2, 2],[3, 3, 1, 1, 2],[3, 3, 2, 1, 1],[3, 3, 1, 2, 1],[2, 1, 1, 3, 3],[2, 3, 3, 1, 1],[2, 3, 3, 2],[2, 1, 3, 3, 1],[2, 1, 3, 1, 3],[2, 3, 2, 3],[2, 3, 1, 1, 3],[2, 3, 1, 3, 1],[1, 3, 3, 2, 1],[1, 3, 3, 1, 2],[1, 2, 3, 1, 3],[1, 2, 3, 3, 1],[1, 2, 1, 3, 3],[1, 3, 1, 2, 3],[1, 3, 1, 3, 2],[1, 3, 2, 3, 1],[1, 3, 2, 1, 3],[3, 2, 2, 3],[3, 1, 1, 2, 3],[3, 1, 1, 3, 2],[3, 2, 1, 3, 1],[3, 2, 3, 2],[3, 2, 3, 1, 1],[3, 2, 1, 1, 3],[3, 1, 2, 1, 3],[3, 1, 2, 3, 1],[3, 1, 3, 1, 2],[3, 1, 3, 2, 1]]).
	%Tiempo: 

	test(casonormal2) :- todosConstruir2(20,[pieza(3,2),pieza(4,2),pieza(5,2),pieza(7,2)],S,60), subset(S,[[7, 5, 4, 4],[7, 5, 3, 5],[7, 4, 5, 4],[7, 3, 5, 5] ,[7, 3, 7, 3],[7, 5, 5, 3],[7, 4, 4, 5],[7, 3, 3, 7],[5, 7, 3, 5],[5, 7, 5, 3],[5, 7, 4, 4],[5, 4, 3, 3, 5],[5, 4, 5, 3, 3],[5, 4, 3, 5, 3],[5, 4, 7, 4],[5, 3, 5, 7],[5, 3, 5, 4, 3],[5, 3, 5, 3, 4],[5, 3, 4, 5, 3],[5, 3, 4, 3, 5],[5, 3, 7, 5],[5, 4, 4, 7],[5, 3, 3, 5, 4],[5, 3, 3, 4, 5],[4, 7, 5, 4],[4, 7, 4, 5],[4, 5, 7, 4],[4, 5, 3, 5, 3],[4, 5, 4, 7],[4, 5, 3, 3, 5],[4, 3, 5, 5, 3],[4, 3, 5, 3, 5],[4, 5, 5, 3, 3],[4, 3, 3, 5, 5],[3, 7, 5, 5],[3, 7, 3, 7],[3, 5, 7, 5],[3, 5, 4, 3, 5],[3, 5, 4, 5, 3],[3, 5, 3, 5, 4],[3, 5, 3, 4, 5],[3, 4, 5, 3, 5],[3, 4, 5, 5, 3],[3, 4, 3, 5, 5],[3, 7, 7, 3],[3, 5, 5, 3, 4],[3, 5, 5, 4, 3],[3, 5, 5, 7],[7, 7, 3, 3],[5, 5, 7, 3],[5, 5, 4, 3, 3],[5, 5, 3, 7],[5, 5, 3, 4, 3],[5, 5, 3, 3, 4],[4, 4, 7, 5],[4, 4, 5, 7],[3, 3, 5, 4, 5],[3, 3, 4, 5, 5],[3, 3, 7, 7],[3, 3, 5, 5, 4]]).
	%Tiempo: 

	test(casonormal3) :- todosConstruir2(30,[pieza(5,2),pieza(7,2),pieza(9,2),pieza(8,1),pieza(10,2)],S,42), subset(S,[[10, 7, 8, 5],[10, 7, 5, 8],[10, 5, 8, 7],[10, 5, 10, 5],[10, 5, 7, 8],[10, 8, 5, 7],[10, 8, 7, 5],[10, 5, 5, 10],[9, 7, 9, 5],[9, 7, 5, 9],[9, 5, 9, 7],[9, 5, 7, 9],[7, 10, 5, 8],[7, 10, 8, 5],[7, 9, 5, 9],[7, 5, 9, 9],[7, 5, 8, 10],[7, 5, 10, 8],[7, 8, 5, 10],[7, 8, 10, 5],[7, 9, 9, 5],[5, 10, 7, 8],[5, 10, 8, 7],[5, 10, 5, 10],[5, 9, 7, 9],[5, 7, 10, 8],[5, 7, 8, 10],[5, 7, 9, 9],[5, 10, 10, 5],[5, 8, 7, 10],[5, 8, 10, 7],[5, 9, 9, 7],[10, 10, 5, 5],[8, 10, 7, 5],[8, 10, 5, 7],[8, 7, 10, 5],[8, 7, 5, 10],[8, 5, 10, 7],[8, 5, 7, 10],[9, 9, 7, 5],[9, 9, 5, 7],[5, 5, 10, 10]]).
	%Tiempo: 
	
:- end_tests(ejercicio9).

:- begin_tests(ejercicio10).

	test(correctitud1) :- tienePatron([A, A], [1,1,1,1]), A is 1.

	test(correctitud2) :- tienePatron([A, 1, B, 2, C], [2,1,3,2,7]), A is 2, B = 3, C = 7.

	test(correctitud3) :- tienePatron([A, B], [2,1,2,1]), A is 2, B is 1 .

:- end_tests(ejercicio10).
