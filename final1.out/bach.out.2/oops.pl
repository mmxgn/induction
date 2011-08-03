% Welcome to rules-swi.pl (~cs9414/public_html/notes/kr/rules/rules-swi.pl).
% To run the system, save a copy in your home directory, then (on a host that
% runs SWI Prolog), do:
%    % prolog -s rules.pl
%    ?- wm(X). % should reply that the only working memory facts are a, b, c.
%    ?- trace. % optional - this makes Prolog show the goals its executing
%    ?- run.   % runs rule-based system. See note below.
%    ?- notrace. % turn off tracing
%    ?- wm(X). % this time it should say that a, b, c, d, & e are all facts.
%    ?- ^D
% Note: as there there are two rules (rule1 and rule2), and they are both
%       eligible to fire given that a, b, and c are all true, both rules should
%       fire, and the conclusion d of rule1 and the conclusion e of rule2
%       should both be facts when execution finishes.
%
% Original code by Claude Sammut, date lost in the mists of time.
% Modified for iProlog by Bill Wilson, October 2001.
% Modified for SWI Prolog by Bill Wilson, April 2006.

:- dynamic wm/1. % this allows inferred wm-facts to be asserted.
:- dynamic case/2.
:- dynamic then/2.
:- dynamic and/2.
:- dynamic last_run/1.

% Helper Functions

distance(X,Y,Z) :- X > Y, Z is X - Y, !; Z is  Y - X, !.

unlabel_atom(X,Y) :-  atom(X), (atom_to_term(X,Y,[]), number(Y), !; concat_atom(L,'_',X), L = [Y2,_], atom_to_term(Y2,Y,[]), !); Y = X.

unlabel(X,Y) :-  ( var(X), X = Y, !; not(var(X)), functor(X,Name,Arity), (Arity=0, unlabel_atom(X,Y),!
					 ;
					 X=..[Head|Body], maplist(unlabel,Body,NewLiteralBody), Y =.. [Head|NewLiteralBody],!) ).

get_label(X,Y) :- concat_atom(L,'_',X), L = [_,Y].

get_lit_labels(X,Y) :- (var(X), Y=none,!;not(var(X)), functor(X,Name,Arity), (Arity=0, get_label(X,Y),!
					;
					X=..[Head|Body], maplist(get_lit_labels,Body,NewLiteralBody), Y=NewLiteralBody,!)).

name_and_label(X,Name,Label) :- concat_atom([Name, Label],'_',X),! ; Name = X, Label = none.


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To express rules in a natural way, we define some operators
% First argument to op is the precedence
% Second argument is the associativity (left, right, nonassoc)
% Third argument is operator name (or list of names)
% This is basically a cosmetic trick to avoid writing the rules as
% case(rule1, then(and(a, and(b, c)), d).
% case(rule2, then(and(a, b), e).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- push_operators([
op(900, xfx ,case),
op(800, xfx, then),
op(700, xfy, and)]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example Rules
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%rule1
%case a and b and c then d.

%rule2
%case a and b then e.

%rule3
%case a(X) and b(X) then c(X).

%rule4
%case c(X) and d(X) then e(X).

%rule4
%case father(X,Y) and father(Y,Z) then grandfather(X,Z).

%rule5
%case one(X) and two(Y) and Y is X + 1 then three(X,Y).

%rule6
%case note(V,P1,Pi1) and note(V,P2,Pi2) and next(V,P1,P2) and distance(Pi1, Pi2, Pi) then interval(V,P1,P2,Pi).

%rule65
%case note(V,P1,_) and note(V,P2,_) and (P2 is P1 + 1) then next(V,P1,P2).

%ruleinf
%case a and true then cool.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial Working memory
% We use "wm" to distinguish working memory elements from
% other entries in Prolog's data basedistance(X,Y,Z) :- X > Y, Z is X - Y, !; Z is  Y - X, !.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%wm(a).
%wm(b).
%wm(c).
%wm(a(2)).
%wm(a(3)).
%wm(b(3)).
%wm(father(ann,john)).
%wm(father(john,jim)).

%wm(note(1,1,6)).
%wm(note(1,2,7)).
%wm(note(1,3,9)).
%wm(note(1,4,10)).
%wm(next(1,1,2)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Assert a dummy already_fired(_,_) fact so retract will not fail if there
%    are no real such facts to retract.
% 2. Next retract all already_fired(_,_) assertions, in case we are rerunning
%    the system and there are some old assertions lying around from last time.
% 3. Now re-assert the dummy already_fired(_,_) fact so that "can_fire" will
%    be confused by the fact that there is no such predicate as already_fired
%    the first time around the match-resolve-act cycle.
% 4. Finally, the cut prevents this predicate endlessly cycling, asserting and
%    retracting.

init :-
        assert(already_fired(null, false, false)),
        retract(already_fired(_, _, _)),
        assert(already_fired(null, false, false)), !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start execution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

run :-
	init,
        exec.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Select a rule, fire it and repeat until no rules are satisfied
% f "fire" succeeds, cut will prevent backtracking
% If "fire" fails, the cycle will repeat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exec :-
    repeat,                % Always succeeds on backtracking
    select_rule(R),        % Select a single rule for firing
    fire(R), !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% "findall" collects all solutions to "can_fire"
% resolve selects one of those rules
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

select_rule(SelectedRule) :-
    findall(Rule, can_fire(Rule), Candidates),
    resolve(Candidates, SelectedRule).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find a rule that hasnt fired before and has its conditions satisfied
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

can_fire(RuleName case Condition then Conclusion) :-
    RuleName case Condition then Conclusion,  % Look up rule in data base
    satisfied(Condition),                     % Are all conditions satisfied?
    not(already_fired(RuleName, Condition, Conclusion)).  % Has it already fired?



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If pattern is "A and ..." then look for A in working memory
% then check rest recursively.
%
%    (A and B) = (x and y and z)
%    A = x
%    B = y and Z
%
% If pattern is a single predicate. Look it up.
% Note that "!" prevents a conjunction reaching the second clause
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

satisfied(A and B) :- !,

    satisfied(A),
    satisfied(B).
satisfied(distance(A,B,C)) :- unlabel(A,A2), unlabel(B,B2), distance(A2,B2,C).
satisfied(A = B) :-
	unlabel(A, A2),
	unlabel(B, B2),
	A2 = B2.
satisfied(A is B) :- 
	%write(A),nl,write(B),nl,
	unlabel(A, A2),
	unlabel(B, B2),
	%write(A2),write(' is '),write(B2), nl,
	A2 is B2.
satisfied(A < B) :- unlabel(A,A2), unlabel(B,B2),A2 < B2.
satisfied(A > B) :- unlabel(A,A2), unlabel(B,B2),A2 > B2.
satisfied(A \= B) :- unlabel(A,A2), unlabel(B,B2), A2 \= B2.
satisfied(A >= B) :- unlabel(A,A2), unlabel(B,B2),A2 >= B2.

satisfied(true).
satisfied(A) :-
   % write('satisfied('),write(A),write(')\n'),
    %unlabel(A,A2),
    wm(A).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Very simple conflict resolution strategy: pick the first rule
% Also check in case no rules were found
%
% Exercise: rewrite this to choose the rule which has the most conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

resolve([], []).
resolve([X|_], X).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add "already_fired" clause to data base so that this instance of the rule
%    is never fired again.
% Add all terms in conclusion to database, if not already there
% Fail to force backtracking so that a new execution cycle begins
%
% If there is no rule to fire, succeed. This terminates execution cycle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fire(RuleName case Condition then Conclusion) :- !,
    RuleName case Condition then Conclusion,
    
    add_to_wm(Conclusion), 
    add_to_last_run(Conclusion),
    assert(already_fired(RuleName, Condition, Conclusion)),
    fail.
fire(_).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For each term in condition
%    add it to workking memory if it is not already there.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

add_to_wm(A and B) :- !,
%    unlabel(A,A2),
%    unlabel(B,B2),
    assert_if_not_present(A),
    add_to_wm(B).
add_to_wm(A) :-
   % unlabel(A,A2),
    write('Asserting: '), write(A), nl,
    assert_if_not_present(A).



remove_from_wm(A) :-
  %  unlabel(A,A2),
    write('Retracting: '), write(A), nl,
    retract(wm(A)), !.
remove_from_wm(A) :-
    \+ wm(A), !.
add_to_last_run(A and B) :- !,
    assert_if_not_present_last_run(A),
    add_to_last_run(B).

add_to_last_run(A) :-
    assert_if_not_present_last_run(A).

remove_from_last_run(A) :-
    retract(last_run(A)), !.
remove_from_last_run(A) :-
    \+ last_run(A), !.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If term is in working memory, dont do anything
% Otherwise, add new term to working memory.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
assert_if_not_present_last_run(A) :-
    last_run(A), !.
assert_if_not_present_last_run(A) :-
    assert(last_run(A)).

assert_if_not_present(A) :-
%    unlabel(A,A2),
    wm(A), !.
assert_if_not_present(A) :-
%    unlabel(A,A2),
    assert(wm(A)).
