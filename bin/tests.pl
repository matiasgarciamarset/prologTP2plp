% Se ejecuta cargando el archivo en el interprete 
% y corriento "run_tests."

:- ['TP2.pl'].


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

	test(casonormal1) :- generar(4000,[pieza(4, 2), pieza(10, 1), pieza(100, 1)],[pieza(1, 4000)], [pieza(1, 4000)] ).

:- end_tests(ejercicio4).

