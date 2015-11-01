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

	test(casonormal1) :- generar(4000,[pieza(4, 2), pieza(10, 1), pieza(100, 1)],[pieza(1, 4000)]).

	test(casogeneral2) :- generaok(2,[[pieza(1, 2)], [pieza(2, 1)]]).

	test(casogeneral4) :- generaok(4,[[pieza(1, 4)], [pieza(1, 2), pieza(2, 1)], [pieza(1, 1), pieza(3, 1)], [pieza(2, 2)], [pieza(4, 1)]]).

:- end_tests(ejercicio4).

:- begin_tests(ejercicio5).

	test(casonvacio) :- cumpleLimite([pieza(1,2),pieza(2,3)],[]).

	test(casonormal1) :- cumpleLimite([pieza(1,2),pieza(2,3)],[pieza(1,1)]).

	test(casogeneral2) :- cumpleLimite([pieza(1,2),pieza(2,3)],[pieza(1,1),pieza(2,2)]).

:- end_tests(ejercicio5).

:- begin_tests(ejercicio6).

	test(casonormal1) :- construir1(10,[pieza(2,2),pieza(1,2),pieza(3,2)],[pieza(2, 2), pieza(3, 2)]).

	test(casonormal2) :- construir1(30,[pieza(2,2),pieza(1,2),pieza(3,2),pieza(4,2),pieza(5,2),pieza(7,2)],[pieza(2, 2), pieza(1, 2), pieza(3, 2), pieza(4, 2), pieza(5, 2)]).

	%Esta comentado porque tarda mucho
	%test(casolento1) :- construir1(250,[pieza(4,2),pieza(5,2),pieza(7,2),pieza(9,2),pieza(8,1),pieza(10,2),pieza(40,10),pieza(50,6),pieza(11,6)],[pieza(4, 2), pieza(5, 2), pieza(7, 2), pieza(9, 2), pieza(8, 1), pieza(10, 2), pieza(50, 1), pieza(11, 1), pieza(50, 1), pieza(11, 1), pieza(50, 1)] ).

	%Esta comentado porque tarda mucho
	%test(casolento2) :- construir1(500,[pieza(2,2),pieza(1,200),pieza(3,2),pieza(4,2),pieza(5,2),pieza(7,2),pieza(9,2),pieza(8,1),pieza(10,2),pieza(40,10),pieza(50,6),pieza(11,6)],[pieza(2, 2), pieza(1, 200), pieza(3, 2), pieza(4, 2), pieza(5, 2), pieza(7, 2), pieza(9, 2), pieza(8, 1), pieza(10, 2), pieza(40, 1), pieza(50, 1), pieza(11, 1), pieza(50, 1), pieza(11, 1), pieza(50, 1)]).

:- end_tests(ejercicio6).

:- begin_tests(ejercicio7).

	test(casonormal1) :- construir2(10,[pieza(2,2),pieza(1,2),pieza(3,2)],[pieza(2, 2), pieza(3, 2)]).

	test(casonormal2) :- construir2(30,[pieza(2,2),pieza(1,2),pieza(3,2),pieza(4,2),pieza(5,2),pieza(7,2)],[pieza(2, 2), pieza(1, 2), pieza(3, 2), pieza(4, 2), pieza(5, 2)]).

	test(casolento1) :- construir2(250,[pieza(4,2),pieza(5,2),pieza(7,2),pieza(9,2),pieza(8,1),pieza(10,2),pieza(40,10),pieza(50,6),pieza(11,6)],[pieza(4, 2), pieza(5, 2), pieza(7, 2), pieza(9, 2), pieza(8, 1), pieza(10, 2), pieza(50, 1), pieza(11, 1), pieza(50, 1), pieza(11, 1), pieza(50, 1)] ).

	test(casolento2) :- construir2(500,[pieza(2,2),pieza(1,200),pieza(3,2),pieza(4,2),pieza(5,2),pieza(7,2),pieza(9,2),pieza(8,1),pieza(10,2),pieza(40,10),pieza(50,6),pieza(11,6)],[pieza(2, 2), pieza(1, 200), pieza(3, 2), pieza(4, 2), pieza(5, 2), pieza(7, 2), pieza(9, 2), pieza(8, 1), pieza(10, 2), pieza(40, 1), pieza(50, 1), pieza(11, 1), pieza(50, 1), pieza(11, 1), pieza(50, 1)]).

:- end_tests(ejercicio7).

:- begin_tests(ejercicio8y9).

	test(casonormal1) :- construir2(10,[pieza(2,2),pieza(1,2),pieza(3,2)],[pieza(2, 2), pieza(3, 2)]).

	test(casonormal2) :- construir2(30,[pieza(2,2),pieza(1,2),pieza(3,2),pieza(4,2),pieza(5,2),pieza(7,2)],[pieza(2, 2), pieza(1, 2), pieza(3, 2), pieza(4, 2), pieza(5, 2)]).

	test(casolento1) :- construir2(250,[pieza(4,2),pieza(5,2),pieza(7,2),pieza(9,2),pieza(8,1),pieza(10,2),pieza(40,10),pieza(50,6),pieza(11,6)],[pieza(4, 2), pieza(5, 2), pieza(7, 2), pieza(9, 2), pieza(8, 1), pieza(10, 2), pieza(50, 1), pieza(11, 1), pieza(50, 1), pieza(11, 1), pieza(50, 1)] ).

	test(casolento2) :- construir2(500,[pieza(2,2),pieza(1,200),pieza(3,2),pieza(4,2),pieza(5,2),pieza(7,2),pieza(9,2),pieza(8,1),pieza(10,2),pieza(40,10),pieza(50,6),pieza(11,6)],[pieza(2, 2), pieza(1, 200), pieza(3, 2), pieza(4, 2), pieza(5, 2), pieza(7, 2), pieza(9, 2), pieza(8, 1), pieza(10, 2), pieza(40, 1), pieza(50, 1), pieza(11, 1), pieza(50, 1), pieza(11, 1), pieza(50, 1)]).

:- end_tests(ejercicio8y9).
