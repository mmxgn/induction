% Helper functions
intersection([X|Y],M,[X|Z]) :- member(X,M), intersection(Y,M,Z).
intersection([X|Y],M,Z) :- \+ member(X,M), intersection(Y,M,Z).
intersection([],M,[]).

arange(Max,Max, []) :- !.
arange(Min,Max,R) :- Min2 is Min + 1, R = [Min | T], arange(Min2, Max,T).


nth(N, List, Element):-
        N1 is N - 1,
        length(Head, N1),
        append(Head, [Element|_Rest], List).


:-consult(input).
:- [library(clpfd)].

test(A,B,C) :- C is A + B, !.
map2neighbours([_],_,[]) :- !.
map2neighbours([H|T],F,[OH|OT]) :- T=[TH|_], Fc =.. [F,H,TH,OH], call(Fc), map2neighbours(T,F,OT).

get_sim_notes(Pos,Notelist) :- setof(note(X,Y,Z,W),(note(X,Y,Z,W), Y=<Pos, Y+W>Pos),Notelist).
%get_sim_notes2(Pos,Notelist) :- setof(note(X,Pos,Z),(X^note(X,Y,Z,W), Y=<Pos, Y+W>Pos),Notelist).
get_sim_notes2(Pos,Notelist) :- info(Voices,_,_), U is Voices + 1, arange(1,U,Vr), maplist(get_note3(Pos),Vr,Notelist), !.
get_seq_notes(Voice, Notelist) :- setof(note(Voice,Y,Z,W),note(Voice,Y,Z,W),Notelist).

get_seq_notes2(Voice,Notelist) :- info(_,Positions,_), arange(1,Positions,Posrange), maplist(get_note(Voice), Posrange, X), maplist(assign_pos, X, Notelist, Posrange), !.
assign_pos(N1, N2, Pos) :- N1 = note(Voice, _ , Pitch, _), N2 = note(Voice, Pos, Pitch).
% Ftiakse to get_seq_notes2
get_note(Voice,Pos,Note) :- note(Voice,Y,Z,W), Y=<Pos, Y+W>Pos, Note = note(Voice,Y,Z,W), !.
get_note2(Voice,Pos,Note) :- note(Voice,Y,Z,W), Y=<Pos, Y+W>Pos, Note = note(Voice, Pos, Z), !.
get_note3(Pos,Voice,Note) :- note(Voice,Y,Z,W), Y=<Pos, Y+W>Pos, Note = note(Voice, Pos, Z), !.
get_simseq_notes(Voices,Positions, Notelist) :- maplist(get_sim_notes, Positions, SimNotes), 
													flatten(SimNotes, SimNotesFlat),
													maplist(get_seq_notes, Voices, SeqNotes),
													flatten(SeqNotes, SeqNotesFlat),
													intersection(SeqNotesFlat, SimNotesFlat, Notelist), !.
													
get_simseq_notes2(Voices,Positions, Notelist) :- maplist(get_sim_notes2, Positions, SimNotes), 
													flatten(SimNotes, SimNotesFlat),
													maplist(get_seq_notes2, Voices, SeqNotes),
													flatten(SeqNotes, SeqNotesFlat),
													intersection(SeqNotesFlat, SimNotesFlat, Notelist), !.
													
get_two_slices(Pos1,Pos2,L) :- L1=[A,B], get_sim_notes2(Pos1,A), get_sim_notes2(Pos2,B), flatten(L1,L),!.
generate_harmony_examples :- info(_,Positions,_), arange(1,Positions,Posrange), maplist(get_sim_notes2, Posrange, X), map2neighbours(X,append,Examples), maplist(assert_example(harmony1), Examples), !.
assert_example(Name, Ex) :- assert(example_set(Name,Ex)), !.

generate_positional_examples :-  info(_,Positions,_), arange(1,Positions,Range), maplist(get_sim_notes2,Range,L), flatten(L, Out), assert_example(position1, Out), !.

generate_positional_wholenote_examples :- setof(note(A,B,C,D),note(A,B,C,D),L), assert_example(position1, L), !.

write_example(Ex) :- write(Ex), write('.'), nl, !.
write_examples :- setof(example_set(Name, Ex), example_set(Name,Ex), Exlist), maplist(write_example, Exlist), !.

:- generate_positional_wholenote_examples.
%:- generate_positional_examples.
:- write_examples.
:- halt.

