tuptolist(N,L) :-  N = (A,B), L = [A|C],tuptolist(B,C), !; L =[N].
mymember(X,[X|_]) :- !.
mymember(X,[_|T]) :- mymember(X,T).



set([],[]).
set([H|T],[H|Out]) :-
    not(mymember(H,T)),
    set(T,Out).
set([H|T],Out) :-
    mymember(H,T),
    set(T,Out).

humanize(genvar1, 'A').
humanize(genvar2, 'B').
humanize(genvar3, 'C').
humanize(genvar4, 'D').
humanize(genvar5, 'E').
humanize(genvar6, 'F').
humanize(genvar7, 'G').
humanize(genvar8, 'H').
humanize(genvar9, 'I').
humanize(genvar10, 'J').
humanize(genvar11, 'K').
humanize(genvar12, 'L').
humanize(genvar13, 'M').
humanize(genvar14, 'N').
humanize(genvar15, 'O').
humanize(genvar16, 'P').
humanize(genvar17, 'Q').
humanize(genvar18, 'R').
humanize(genvar19, 'S').
humanize(genvar20, 'T').
humanize(genvar21, 'U').
humanize(genvar22, 'V').
humanize(genvar23, 'W').
humanize(genvar24, 'X').
humanize(genvar25, 'Y').
humanize(genvar26, 'Z').



humanize_literal(L2,H) :- unlabel(L2,L), ( humanize(L,V), swritef(H,V),!; number(L), string_to_atom(H,L),!; functor(L,Name,Arity), 

				swritef(Sname,Name),
				%write(Sname),
				(Arity = 0, swritef(H,Sname), !; 
				 L =.. [Name|Args], 
				%write(Args),
				maplist(humanize_literal, Args, Args2) , atomic_list_concat(Args2,', ',LArgs), concat_atom([Name,'(',LArgs,')'],H),!) ).

humanize_hclause(PH :- PB, H) :- humanize_literal(PH,H1), tuptolist(PB, PBL0), set(PBL0,PBL), maplist(humanize_literal, PBL, PBL2), atomic_list_concat(PBL2, ', ', LPBL), concat_atom([H1,' :- ',LPBL,'.'],H).
