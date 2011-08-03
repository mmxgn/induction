:- dynamic example_set/2.

%%% Helper Functions
mymember(X,[X|_]) :- !.
mymember(X,[_|T]) :- mymember(X,T).


set([],[]).
set([H|T],[H|Out]) :-
    not(mymember(H,T)),
    set(T,Out).
set([H|T],Out) :-
    mymember(H,T),
    set(T,Out).

arguments_helper(F, A) :- F =.. [_|A].
arguments([], []).
%arguments([LH|LT], A) :- LH=note(V,P,_),AH=[voice(V),position(P)], arguments(LT,AT), flatten([AH|AT],A), ! ; arguments_helper(LH, AH), arguments(LT, AT), flatten([AH|AT],A), !.
arguments([LH|LT], A) :- arguments_helper(LH, AH), arguments(LT, AT), flatten([AH|AT],A), !.

%arguments([note(V,P,_)|LT],A) :- AH=[voice(V),position(P)], arguments(LT,AT), flatten([AH|AT],A).

domain(Name, []) :- assert(type(Name,Name)).
domain(Name, [Head|Tail]):- 	X =.. [Name|[Head]], 
				assert(X), 
				assert(type(Head,Name)),
				domain(Name,Tail).

% Creates a conjunction from a list

conjlist([H|T],L) :- conjlist(T,T2), L=','(H,T2), !.
conjlist([H|[]],L):- L=H, !.

% Try for a counter

:- dynamic fcounter/1.
fcounter(0).
forcounter(X) :- fcounter(Z), X is Z + 1, assert(fcounter(X)), retract(fcounter(Z)).
forcounterdown(X) :- fcounter(Z), X is Z - 1, assert(fcounter(X)), retract(fcounter(Z)).
reset_forcounter :- retractall(fcounter(_)), assert(fcounter(0)).

:- dynamic ncounter/1.
ncounter(0).
counter(X) :- ncounter(Z), X is Z + 1, assert(ncounter(X)), retract(ncounter(Z)).
reset_counter :- retractall(ncounter(_)), assert(ncounter(0)).

:- dynamic gcounter/1.
gcounter(0).
genvarcounter(X) :- gcounter(Z), X is Z + 1, assert(gcounter(X)), retract(gcounter(Z)).
reset_genvarcounter :- retractall(gcounter(_)), assert(gcounter(0)).


:- dynamic varcounter/2.
addvarcounter(X) :- gvcounter(X,N), N2 is N + 1, assert(gvcounter(X,N2)), retract(gvcounter(X,N)).
reset_varcounter(X) :- retractall(gvcounter(_,_)), assert(gvcounter(X,0)). 


reset_all_counters :- reset_forcounter, reset_genvarcounter, retractall(nc(_)), !.

% Tuple to list

tuptolist(N,L) :-  N = (A,B), L = [A|C],tuptolist(B,C), !; L =[N].
%%%
:-consult(oops).
:-consult(humanize).
listand([],O) :- O = true.
listand([H|T], Out) :- listand(T, O1), term_to_atom(H and O1,Out).

%pattern((a(X):-b(X),c(Y))).
add_pattern_to_wm(PH :- PB) :- Label is random(65535), atom_concat(rule,Label,RuleName), rand(PB, B), assert(RuleName case B then PH).
%pattern((head(X):-body1(X),body2(X),body3(X))).
%pattern(PH :- PB).
%rand(T,X):-X = T.

rand((H,T),X):-rand(T,O), X = and(H,O), !.
rand(T,X):-X=T, !.



:-consult(patterns).
%:-add_pattern_to_wm((melodic_interval_type(V,P1,P2,'unison'):-melodic_interval(V,P1,P2,0))).

%:-add_pattern_to_wm((step(V,P1,P2):-melodic_interval(V,P1,P2,Pi), Pi < 3)).
%:-add_pattern_to_wm((skip(V,P1,P2):-melodic_interval(V,P1,P2,Pi), Pi >= 3)).
%case note(V,P1,Pi1) and note(V,P2,Pi2) and next(V,P1,P2) and distance(Pi1, Pi2, Pi) then interval(V,P1,P2,Pi).

%wm(note(1,1,6)).
%wm(note(1,2,7)).
%wm(note(1,3,9)).
%wm(note(1,4,10)).
%wm(next(1,1,2)).


%% Examples


:-consult(examples).


%% Background Knowledge
:-consult(backgroundknowledge).

%example([note(1,1,6),note(2,1,8)]).
%example([note(1,2,6),note(2,2,8)]).
%example([note(1,3,6),note(2,3,8)]).

%example([note(1,1,6),note(1,2,9),note(2,1,6),note(2,2,9)]).
%example([note(1,2,9),note(1,3,6),note(2,2,9),note(2,3,6)]).
%example([note(1,3,6),note(1,4,9),note(2,3,6),note(2,4,9)]).
%example([note(1,4,9),note(1,5,5),note(2,4,9),note(2,5,5)]).

%example([note(1,1,1),note(1,2,1),note(2,1,1),note(2,2,1)]).
%example([note(1,3,1),note(1,3,1),note(2,2,1),note(2,3,1)]).
%example([note(1,4,1),note(1,3,1),note(2,2,1),note(2,3,1)]).
%example([note(1,1,1),note(1,2,1),note(2,4,1),note(2,2,1)]).
%example([note(1,2,1),note(1,4,1),note(2,2,1),note(2,3,1)]).
%example([note(1,2,1),note(1,3,1),note(2,2,1),note(2,3,1)]).
% wm(examplename, Fact) is the fact that is related to that particular example


process_one_example(Ex, PN, NewClauseHead :- NewClauseBody) :- arguments(Ex,Args), NewClauseHead =.. [PN|Args],  retractall(last_run(_)), forall(member(E, Ex), assert(wm(E))), run, setof(NF, last_run(NF),NewFacts), append(Ex,NewFacts,NewClauseBodyList), conjlist(NewClauseBodyList,NewClauseBody) ,forall(member(E,Ex),retract(wm(E))), setof(wm(NF),last_run(NF),NewFacts2), maplist(retract, NewFacts2).

label_and_process_one_example(S,NewClauseHead :- NewClauseBody):-  label_example(S,Ex), RandNum is random(65535), atom_concat(pn_,RandNum,PN), arguments(Ex,Args), NewClauseHead =.. [PN|Args],  retractall(last_run(_)), forall(member(E, Ex), add_to_wm(E)), run, forall(member(E,Ex),remove_from_wm(E)), setof(NF, last_run(NF),NewFacts), append(Ex,NewFacts,NewClauseBodyList), conjlist(NewClauseBodyList,NewClauseBody) , setof(NF,last_run(NF),NewFacts2), maplist(remove_from_wm, NewFacts2).

label_and_process_one_example(S, PN, NewClauseHead :- NewClauseBody):-  label_example(S,Ex), arguments(Ex,Args), NewClauseHead =.. [PN|Args],  retractall(last_run(_)), forall(member(E, Ex), add_to_wm(E)), run, forall(member(E,Ex),remove_from_wm(E)), setof(NF, last_run(NF),NewFacts), append(Ex,NewFacts,NewClauseBodyList), conjlist(NewClauseBodyList,NewClauseBody) , setof(NF,last_run(NF),NewFacts2), maplist(remove_from_wm, NewFacts2).


process_one_example(Ex,NewClauseHead :- NewClauseBody):-  RandNum is random(65535), atom_concat(pn_,RandNum,PN), arguments(Ex,Args), NewClauseHead =.. [PN|Args],  retractall(last_run(_)), forall(member(E, Ex), assert(wm(E))), run, setof(NF, last_run(NF),NewFacts), append(Ex,NewFacts,NewClauseBodyList), conjlist(NewClauseBodyList,NewClauseBody) ,forall(member(E,Ex),retract(wm(E))), setof(wm(NF),last_run(NF),NewFacts2), maplist(retract, NewFacts2).

%label_example(OldEx,Ex),

% watch it here!!!!

label_atom(X1,Y) :- term_to_atom(X1, X), counter(RN), concat_atom([X,'_label',RN],Y), type(X, T), assert(type(Y, T)).
% 4 Apr 2011 -- New Predicate Names, Stamatisa edw. Ftiakse ta labels.

label_literal(Literal,NewLiteral) :- var(Literal), NewLiteral=Literal, !; functor(Literal, _, Arity),
					(Arity=0, label_atom(Literal,NewLiteral),!
					 ;
					 Literal=..[Head|Body], maplist(label_literal,Body,NewLiteralBody), NewLiteral =.. [Head|NewLiteralBody],!).
label_example(Ex,NewEx):- reset_counter, maplist(label_literal, Ex, NewEx).


%
%
%OldEx = [note(1,1,6),note(1,2,7)], label_example(OldEx,Ex), RandNum is random(65535), atom_concat(pn_,RandNum,PN), arguments(Ex,Args), NewClauseHead =.. [PN|Args],  retractall(last_run(_)), forall(member(E, Ex), assert(wm(E))), run, setof(NF, last_run(NF),NewFacts), append(Ex,NewFacts,NewClauseBodyList), conjlist(NewClauseBodyList,NewClauseBody) ,forall(member(E,Ex),retract(wm(E))).


% Lgg.

lit(X) :- not(var(X)), functor(X, Name, Arity), Arity > 0, !.

lgg(Op1,Op2,LGG) :- Op1 = Op2, LGG=Op1,! ;type(Op1,X), type(Op2, X),newgenvar([Op1,Op2],Gen), LGG=Gen, !; lit(Op1), lit(Op2), Op1 =.. [Name1|Args1], Op2 =..[Name2|Args2], Name1 = Name2, maplist(lgg, Args1, Args2, ArgsOut), LGG =..[Name1|ArgsOut],!; Op1 = (Head1 :- Body1), Op2 = (Head2 :- Body2), tuptolist(Body1,LBody1), tuptolist(Body2,LBody2), setof([P,Q],(member(P,LBody1),member(Q,LBody2)), ToLgg), bagof(T,K^J^(member(K,LBody1),member(J,LBody2),lgg(K,J,T)),Setlist), lgg(Head1,Head2,Head), conjlist(Setlist,Body), LGG = (Head :- Body). 

clgg(Op1,Op2,LGG) :- get_lit_labels(Op1, X), get_lit_labels(Op2, X), unlabel(Op1,O1), unlabel(Op2,O2), lgg(O1, O2,LGG), !.

clgg(Op1,Op2,LGG) :- Op1 = Op2, unlabel(Op1, O1), unlabel(Op2,O2), LGG=O1,! ;get_lit_labels(Op1,Labels), get_lit_labels(Op2,Labels), type(Op1,X), type(Op2, X),newgenvar([Op1,Op2],Gen), LGG=Gen, !; lit(Op1), lit(Op2), Op1 =.. [Name1|Args1], Op2 =..[Name2|Args2], Name1 = Name2, maplist(clgg, Args1, Args2, ArgsOut), LGG =..[Name1|ArgsOut],!; Op1 = (Head1 :- Body1), Op2 = (Head2 :- Body2), tuptolist(Body1,LBody1), tuptolist(Body2,LBody2), setof([P,Q],(member(P,LBody1),member(Q,LBody2)), ToLgg), bagof(T,K^J^(member(K,LBody1),member(J,LBody2),clgg(K,J,T)),Setlist), clgg(Head1,Head2,Head), conjlist(Setlist,Body), LGG = (Head :- Body). 
%
%?- bagof(Z,X^Y^(member(X,[a(rook),a(queen)]),member(Y,[a(rook),b(king)]),lgg(X,Y,Z)),Setlist).
%Setlist = [a(rook), a(piece)].

% test.

%% Filter out singletons

:-dynamic vcounter/2.

% True if all in list are true
all([]).
all([A|Tail]) :- A, all(Tail).

% True if any in list is true
any([A|Tail]) :- A,!; any(Tail).

count_variable(X) :- atom(X), 
					atom_concat(genvar,_,X), 
					(\+ vcounter(X,_), 
					assert(vcounter(X,1)),!; 
					vcounter(X,N), 
					N2 is N + 1, 
					assert(vcounter(X,N2)),
					retract(vcounter(X,N)), !). 
					
reset_vcounter(X) :- retract(vcounter(X, _)).
reset_vcounter :- retractall(vcounter(_,_)).

count_literal_variables(L) :- 	functor(L, _, Arity), 
								(Arity=0, count_variable(L), !;
								L =.. [_|LB],
								maplist(count_literal_variables, LB), !).
								
%Old has not singleton. 
%hasnotSingleton(L) :- hasnotSingleton(L,T), T=true.
%hasnotSingleton(L,T) :- number(L), T=true, !; atom(L), ((atom_concat(genvar, _, L),  vcounter(L, N), (N>1, T=true, !; T=false,!)); \+atom_concat(genvar,_,L), T=true) ; 	L =..[_|LB], LB \= [], maplist(hasnotSingleton, LB, TL), all(TL), T=true, !; 	T=false.


hasnotSingleton(L) :- hasnotSingleton(L,T), T=true.
hasnotSingleton(L,T) :- number(L), T=true, !; atom(L), ((atom_concat(genvar, _, L),  vcounter(L, N), (N>0, T=true, !; T=false,!)); \+atom_concat(genvar,_,L), T=true) ; 	L =..[_|LB], LB \= [], maplist(hasnotSingleton, LB, TL), all(TL), T=true, !; 	T=false.
					 
hasVariable(L) :- hasVariable(L,T), T=true, !.
hasVariable(L,T) :- number(L), T=false, !; atom(L), atom_concat(genvar, _, L), T=true, !;  L=..[_|LB], LB \= [], maplist(hasVariable, LB, TL), any(TL), T=true,!; T=false,!.


count_clause_variables(Head :- Body) :- count_literal_variables(Head), count_literal_variables(Body).
%Old Filter_singletons f
%filter_singletons(Head:-Body, Head:-Body2) :- reset_vcounter, count_clause_variables(Head:-Body), tuptolist(Body,LBody), include(hasnotSingleton, LBody, LBody2), conjlist(LBody2,Body2). 
filter_singletons(Head:-Body, Head:-Body2) :- reset_vcounter, count_clause_variables(Head:-true), tuptolist(Body,LBody), include(hasnotSingleton, LBody, LBody2), conjlist(LBody2,Body2).    
filter_head(Head:-Body, Head2:-Body) :- Head =.. [H|Args0], set(Args0,Args1), include(hasVariable, Args1, Args2), Head2 =..[H|Args2],!.
%

:- count_clause_variables((head(genvar1, genvar2) :- body1(genvar1), body1(genvar1,genvar2))).

%% End filter out singletons.

%generalisation variable
:-dynamic genvar/3.

newgenvar([W,P],G) :- genvar([W,P],_,G), !;genvarcounter(C), atom_concat(genvar,C,A), type(W,Domain), type(P,Domain), assert(type(A,Domain)), assert(genvar([W,P],Domain,A)), G=A, !.

innerloop([],[]).
innerloop([H|T],NC) :- process_one_example(H,NC1), innerloop(T,NC2), (lgg(NC1,NC2,NC),!;NC2=[],NC=NC1).


getpn(Head :- Body, PN) :- Head =.. [PN|_]. 


:- dynamic pal_buffer/1.
:- dynamic pal_nc/1.

pal_push(E) :- assert(pal_buffer(E)).
pal_pop(E) :- pal_buffer(E), retract(pal_buffer(E)), !.


pal_init:- setof(E, example(E), Elist), maplist(pal_push, Elist).
pal_head:- pal_pop(E), process_one_example(E, NC), assert(nc(NC)).

pal_loop:- pal_pop(E), nc(NCIn), getpn(NCIn,PN),  process_one_example(E,PN,NC), retract(nc(NCIn)), lgg(NCIn,NC,NCOut), assert(nc(NCOut)), pal_loop. 

pal:-pal_init, pal_head, pal_loop.

% Pal with labels
lpal_head:-  pal_pop(E), label_and_process_one_example(E, NC), assert(nc(NC)).
lpal_loop:- pal_pop(E), nc(NCIn), getpn(NCIn,PN),  label_and_process_one_example(E,PN,NC), retract(nc(NCIn)),  clgg(NCIn,NC,NCOut), filter_singletons(NCOut,NCOut2), assert(nc(NCOut2)), lpal_loop. 

:-dynamic palout/2.
lpal(Out):-pal_init, lpal_head, lpal_loop; nc(X), filter_singletons(X,X2), filter_head(X,X3), humanize_hclause(X3,S), write(S), Out=X3, !.

:- domain(piece,[king,queen,rook]).				
%:- domain(int,[0,1,2,3,4,5,6,7,8,9,10]).


% Create examples from examplesets

create_examples_from_set(Set) :- setof(example(Ex), Set^example_set(Set, Ex), Exlist), maplist(assert, Exlist).
run_lpal_with_set(Set) :- reset_all_counters, retractall(nc(_)), retractall(example(_)), retractall(last_run(_)), retractall(pal_buffer(_)), create_examples_from_set(Set), lpal(Out), assert(lpalout(Set,Out)).
run_all_sets :- setof(Name, Ex^example_set(Name,Ex), Exlist), maplist(run_lpal_with_set, Exlist).

arange(Max,Max, []) :- !.
arange(Min,Max,R) :- Min2 is Min + 1, R = [Min | T], arange(Min2, Max,T).

:- arange(-10,200,R), domain(int, R).
%:- run_all_sets.
beautify_results([Name,Pattern]):-write('Set with name"'), write(Name), write('" gave pattern:'), nl, write(Pattern), nl.
%:- nl,nl, setof([Name, Pattern], lpalout(Name,Pattern), Plist), maplist(beautify_results, Plist).
%:- halt.

transform_genvar(X,Y) :- atom_concat(genvar,Z,X), atom_concat('G',Z,Y), !; Y = X.
transform_genvar2(X,Y) :- atom_concat(genvar,Z,X),not(cur_voices(X)),not(cur_positions(X)),Y='_',!; atom_concat(genvar,Z,X), upcase_atom(X,Y), !; Y = X.

write_call_to_oz(Call) :- Call =.. [H|Args], maplist(transform_genvar, Args, ArgsU), upcase_atom(H,HU), write('\t{'), write(HU), write(' '),
							atomic_list_concat(ArgsU,' ',ArgsS),
							write(ArgsS), write('}'), nl, !.
write_call_to_oz2(Call) :- Call =.. [H|Args], maplist(transform_genvar2, Args, ArgsU), upcase_atom(H,HU), write('choice {'), write(HU), write(' '),
							atomic_list_concat(ArgsU,' ',ArgsS),
							write(ArgsS), write('} [] skip end '), !.
write_clause_to_oz(Head:-Body) :-	Head =.. [H|Args], tuptolist(Body,LBody), maplist(transform_genvar, Args, ArgsU), upcase_atom(H,HU), 
									write('proc {'), write(HU), write(' '), atomic_list_concat(ArgsU,' ',ArgsS),
									write(ArgsS), write('}'), nl, maplist(write_call_to_oz, LBody), write('end'), nl, 
									!.

:-dynamic cur_voices/1.
:-dynamic cur_positions/1.
:-dynamic oz_patterns/1.
:-dynamic oz_forloops/1.
generate_loop_str([P|T],S):- T=[],S,!; P=..[H|_], H\=note, S, !; P =.. [H|A], H=note, A=[Voice|[Position|_]], (not(number(Voice)), not(cur_voices(Voice)), write('for '), upcase_atom(Voice, Voice2), write(Voice2), write(' in 1..NV do\n '), assert(cur_voices(Voice)), forcounter(_); true), (not(number(Position)), not(cur_positions(Position)), write('for '), upcase_atom(Position, Position2), write(Position2), write(' in 1..NP do '), assert(cur_positions(Position)), forcounter(_); true), generate_loop_str(T,S),(not(number(Voice)), fcounter(X), X > 0, forcounterdown(_), write(' end '); true),(not(number(Position)), fcounter(Y), Y > 0, forcounterdown(_), write('end\n'); true), !.


% write_to_oz :- reset_forcounter, retractall(cur_voices(_)), retractall(cur_positions(_)), lpalout(X,Y), Y=(A:-B), tuptolist(B,LB), write('% For set: '), write(X), write('\n'), write_clause_to_oz(Y), write('\n'), generate_loop_str(LB,write_call_to_oz2(A)).

write_to_oz :- reset_forcounter, open('oz_pal.oz',write,FP), write(FP,''), close(FP), open('oz_loops.oz',write,FL), write(FL,''), close(FL),  retractall(cur_voices(_)), retractall(cur_positions(_)), setof(Y,X^lpalout(X,Y),L), maplist(write_one_to_oz,L).

write_one_to_oz(Y) :- retractall(cur_voices(_)), retractall(cur_positions(_)), reset_forcounter, open('oz_pal.oz',append,FP), open('oz_loops.oz',append,FL), Y=(A:-B), tuptolist(B,LB), write(FP, '% For set: '), write(FP, X), write(FP,'\n'), with_output_to(FP,write_clause_to_oz(Y)), write(FP,'\n'), with_output_to(FL,generate_loop_str(LB,write_call_to_oz2(A))), close(FP), close(FL).



write_one_to_file(Y) :- write(Y), write('.'), nl.	
write_to_file :- setof(Y,X^lpalout(X,Y),Xset), maplist(write_one_to_file,Xset).
	

%:- profile(run_all_sets).
:- run_all_sets.
:- open('pal_out.pl',write,FP), with_output_to(FP,write_to_file), close(FP).
%:- write_to_oz.
:- halt.
