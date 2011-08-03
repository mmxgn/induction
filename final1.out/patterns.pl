%:-add_pattern_to_wm((within_octave(V1,V2,P):-note(V1,P,Pi1), note(V2,P,Pi2), Di is Pi2 - Pi1, Di =<12, Di >= -12)).
:-add_pattern_to_wm((note(V,P,Pitch):-note(V,P,Pitch,_))).
:-add_pattern_to_wm((duration(V,P,Duration):-note(V,P,_,Duration))).
:-add_pattern_to_wm((next(V,P1,P2):-note(V1,P1,Pi1), note(V2,P2,Pi2), P2 is P1 + 1, V1 = V, V2 = V)).
%:-add_pattern_to_wm((over(V1,V2,P):-note(V1,P1,Pi1), note(V2,P2,Pi2), V2 is V1 + 1, P1 = P, P2 = P, Pi2 > Pi1)).
:-add_pattern_to_wm((over(V1,V2,P):-note(V1,P,Pi1), note(V2,P,Pi2), V2 is V1+1, Pi2 >= Pi1)).
%:-add_pattern_to_wm((melodic_interval(V,P1,P2,Pi):-note(V1,P1,Pi1), note(V2,P2,Pi2), P2 is P1 + 1, V1 = V, V2 = V, distance(Pi1,Pi2,Pi), V1 = V, V2 = V)).
%:-add_pattern_to_wm((harmonic_interval(V1,V2,P,Pi):-note(V1,P1,Pi1), note(V2,P2,Pi2), V2 is V1 + 1, P1 = P, P2 = P, distance(Pi1,Pi2,Pi), P1 = P, P2 = P)).

%:-add_pattern_to_wm((position(P):-note(_,P1,_), P1=P)).
%:-add_pattern_to_wm((voice(V):-note(V,_,_))).
%:-add_pattern_to_wm((pitch(Pi):-note(_,_,Pi)).
:-add_pattern_to_wm((melodic_interval(V,P1,P2,Pi):-note(V,P1,Pi1), note(V,P2,Pi2), P2 is P1 + 1,  distance(Pi1,Pi2,Pi))).
:-add_pattern_to_wm((harmonic_interval(V1,V2,P,Pi):-note(V1,P,Pi1), note(V2,P,Pi2), V2 is V1 + 1, distance(Pi1,Pi2,Pi))).


% Cmajor
:-add_pattern_to_wm((cmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 0)).
:-add_pattern_to_wm((cmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 2)).
:-add_pattern_to_wm((cmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 4)).
:-add_pattern_to_wm((cmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 5)).
:-add_pattern_to_wm((cmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 7)).
:-add_pattern_to_wm((cmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 9)).
:-add_pattern_to_wm((cmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 11)).

%:-add_pattern_to_wm((cmajorchord(P):-note(_,P,PiRoot), note(_,P,PiThird), note(_,P,PiDominant), PCRoot is PiRoot mod 12, PCThird is PiThird mod 12, PCDominant is PiDominant mod 12, PCRoot = 0, PCThird = 4, PCDominant = 7 )).

% Dmajor
:-add_pattern_to_wm((dmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 2)).
:-add_pattern_to_wm((dmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 4)).
:-add_pattern_to_wm((dmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 6)).
:-add_pattern_to_wm((dmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 7)).
:-add_pattern_to_wm((dmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 9)).
:-add_pattern_to_wm((dmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 11)).
:-add_pattern_to_wm((dmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 1)).

% Gmajor
:-add_pattern_to_wm((gmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 7)).
:-add_pattern_to_wm((gmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 9)).
:-add_pattern_to_wm((gmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 11)).
:-add_pattern_to_wm((gmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 0)).
:-add_pattern_to_wm((gmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 2)).
:-add_pattern_to_wm((gmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 4)).
:-add_pattern_to_wm((gmajor(V,P):-note(V,P,Pi), PC is Pi mod 12, PC = 6)).

%:-add_pattern_to_wm((melodic_interval_type(V,P1,P2,consonant):-melodic_interval(V,P1,P2,0))).
%:-add_pattern_to_wm((melodic_interval_type(V,P1,P2,consonant):-melodic_interval(V,P1,P2,5))).
%:-add_pattern_to_wm((melodic_interval_type(V,P1,P2,consonant):-melodic_interval(V,P1,P2,7))).
%:-add_pattern_to_wm((melodic_interval_type(V,P1,P2,consonant):-melodic_interval(V,P1,P2,12))).

%:-add_pattern_to_wm((harmonic_interval_type(V,P1,P2,consonant):-harmonic_interval(V,P1,P2,0))).
%:-add_pattern_to_wm((harmonic_interval_type(V,P1,P2,consonant):-harmonic_interval(V,P1,P2,5))).
%:-add_pattern_to_wm((harmonic_interval_type(V,P1,P2,consonant):-harmonic_interval(V,P1,P2,7))).
%:-add_pattern_to_wm((harmonic_interval_type(V,P1,P2,consonant):-harmonic_interval(V,P1,P2,12))).

%:-add_pattern_to_wm((melodic_interval_type(V1,V2,P,consonant):-melodic_interval(V1,V2,P,0))).
%:-add_pattern_to_wm((melodic_interval_type(V1,V2,P,consonant):-melodic_interval(V1,V2,P,5))).
%:-add_pattern_to_wm((melodic_interval_type(V1,V2,P,consonant):-melodic_interval(V1,V2,P,7))).
%:-add_pattern_to_wm((melodic_interval_type(V1,V2,P,consonant):-melodic_interval(V1,V2,P,12))).


:-add_pattern_to_wm((harmonic_perfect_consonance(V1,P11,P21):-harmonic_interval(V2,P12,P22,0), V1 = V2, P11 = P12, P21 = P22)). % unison

:-add_pattern_to_wm((harmonic_consonance(V,P1,P2):-harmonic_perfect_consonance(V,P1,P2))).
:-add_pattern_to_wm((harmonic_consonance(V,P1,P2):-harmonic_imperfect_consonance(V,P1,P2))).
:-add_pattern_to_wm((harmonic_perfect_consonance(V,P1,P2):-harmonic_interval(V,P1,P2,0))). % unison
:-add_pattern_to_wm((harmonic_perfect_consonance(V,P1,P2):-harmonic_interval(V,P1,P2,7))). % fifth
:-add_pattern_to_wm((harmonic_perfect_consonance(V,P1,P2):-harmonic_interval(V,P1,P2,12))). % octave

:-add_pattern_to_wm((harmonic_imperfect_consonance(V,P1,P2):-harmonic_interval(V,P1,P2,3))). %minor third
:-add_pattern_to_wm((harmonic_imperfect_consonance(V,P1,P2):-harmonic_interval(V,P1,P2,4))). %major third
:-add_pattern_to_wm((harmonic_imperfect_consonance(V,P1,P2):-harmonic_interval(V,P1,P2,8))). %minor sixth
:-add_pattern_to_wm((harmonic_imperfect_consonance(V,P1,P2):-harmonic_interval(V,P1,P2,9))). %major sixth

:-add_pattern_to_wm((harmonic_dissonance(V,P1,P2):-harmonic_interval(V,P1,P2,1))).	%minor second
:-add_pattern_to_wm((harmonic_dissonance(V,P1,P2):-harmonic_interval(V,P1,P2,2))).	%major second

:-add_pattern_to_wm((harmonic_dissonance(V,P1,P2):-harmonic_interval(V,P1,P2,5))).	%perfect fourth
:-add_pattern_to_wm((harmonic_dissonance(V,P1,P2):-harmonic_interval(V,P1,P2,6))).	%augmented fourth/diminished fifth
:-add_pattern_to_wm((harmonic_dissonance(V,P1,P2):-harmonic_interval(V,P1,P2,10))).	%minor seventh
:-add_pattern_to_wm((harmonic_dissonance(V,P1,P2):-harmonic_interval(V,P1,P2,11))).	%major seventh

%:-add_pattern_to_wm((melodic_consonance(V,P1,P2):-melodic_perfect_consonance(V,P1,P2))).
%:-add_pattern_to_wm((melodic_consonance(V,P1,P2):-melodic_imperfect_consonance(V,P1,P2))).
%:-add_pattern_to_wm((melodic_perfect_consonance(V,P1,P2):-melodic_interval(V,P1,P2,0))). % unison
%:-add_pattern_to_wm((melodic_perfect_consonance(V,P1,P2):-melodic_interval(V,P1,P2,7))). % fifth
%:-add_pattern_to_wm((melodic_perfect_consonance(V,P1,P2):-melodic_interval(V,P1,P2,12))). % octave

%:-add_pattern_to_wm((melodic_imperfect_consonance(V,P1,P2):-melodic_interval(V,%P1,P2,3))). %minor third
%:-add_pattern_to_wm((melodic_imperfect_consonance(V,P1,P2):-melodic_interval(V,P1,P2,4))). %major third
%:-add_pattern_to_wm((melodic_imperfect_consonance(V,P1,P2):-melodic_interval(V,P1,P2,8))). %minor sixth
%:-add_pattern_to_wm((melodic_imperfect_consonance(V,P1,P2):-melodic_interval(V,P1,P2,9))). %major sixth

%:-add_pattern_to_wm((melodic_dissonance(V,P1,P2):-melodic_interval(V,P1,P2,1))).	%minor second
%:-add_pattern_to_wm((melodic_dissonance(V,P1,P2):-melodic_interval(V,P1,P2,2))).	%major second

%:-add_pattern_to_wm((melodic_dissonance(V,P1,P2):-melodic_interval(V,P1,P2,5))).	%perfect fourth
%:-add_pattern_to_wm((melodic_dissonance(V,P1,P2):-melodic_interval(V,P1,P2,6))).	%augmented fourth/diminished fifth
%:-add_pattern_to_wm((melodic_dissonance(V,P1,P2):-melodic_interval(V,P1,P2,10))).	%minor seventh
%:-add_pattern_to_wm((melodic_dissonance(V,P1,P2):-melodic_interval(V,P1,P2,11))).	%major seventh

:-add_pattern_to_wm((melodic_upwards(V,P1,P2):-note(V,P1,Pi1), note(V,P2,Pi2), next(V,P1,P2), Pi2 > Pi1)).
:-add_pattern_to_wm((melodic_downwards(V,P1,P2):-note(V,P1,Pi1), note(V,P2,Pi2), next(V,P1,P2), Pi2 < Pi1)).
:-add_pattern_to_wm((melodic_steady(V,P1,P2):-note(V,P1,Pi1), note(V,P2,Pi2), next(V,P1,P2), Pi1 = Pi2)).


:-add_pattern_to_wm((melodic_step(V,P1,P2):-melodic_interval(V,P1,P2,I), I<5, I>0)).

:-add_pattern_to_wm((melodic_step(V,P1,P2):-note(V,P1,Pi1), note(V,P2,Pi2), next(V,P1,P2), I is Pi2 - Pi1, I > 0, I < 5).
:-add_pattern_to_wm((melodic_step(V,P1,P2):-note(V,P1,Pi1), note(V,P2,Pi2), next(V,P1,P2), I is Pi1 - Pi2, I > 0, I < 5).
:-add_pattern_to_wm((melodic_skip(V,P1,P2):-note(V,P1,Pi1), note(V,P2,Pi2), next(V,P1,P2), I is Pi2 - Pi1, I > 0, I >= 5).
:-add_pattern_to_wm((melodic_skip(V,P1,P2):-note(V,P1,Pi1), note(V,P2,Pi2), next(V,P1,P2), I is Pi1 - Pi2, I > 0, I >= 5).

%:-add_pattern_to_wm((valid_melodic_interval(V,P1,P2):- melodic_consonance(V,P1,P2))).

%:-add_pattern_to_wm((valid_melodic_interval(V,P1,P2):- melodic_dissonance(V,P1,P2), note(V1,P1,Pi1),note(V2,P2,Pi2), scale(PiIn1,S1), scale(PiIn2,S2), PiIn1=Pi1, PiIn2 = Pi2, S1=S2, P2 is P1 + 1, V1 = V, V2 = V, distance(Pi1,Pi2,Pi), V1 = V, V2 = V)).

:-add_pattern_to_wm((oblique_motion(V1,V2,P1,P2):-melodic_interval(V1,P1,P2,_),melodic_interval(V2,P1,P2,_),harmonic_interval(V1,V2,P1,_), harmonic_interval(V1,V2,P2,_),  note(V1,P1,V1Pi1), note(V2,P1,V2Pi1), note(V1,P2,V1Pi2), note(V2,P2,V2Pi2), V1Pi2 \= V1Pi1, V2Pi2 = V2Pi1 )).

:-add_pattern_to_wm((oblique_motion(V1,V2,P1,P2):-melodic_interval(V1,P1,P2,_),melodic_interval(V2,P1,P2,_),harmonic_interval(V1,V2,P1,_), harmonic_interval(V1,V2,P2,_),  note(V1,P1,V1Pi1), note(V2,P1,V2Pi1), note(V1,P2,V1Pi2), note(V2,P2,V2Pi2), V1Pi2 = V1Pi1, V2Pi2 \= V2Pi1 )).

:-add_pattern_to_wm((contrary_motion(V1,V2,P1,P2):-melodic_interval(V1,P1,P2,_),melodic_interval(V2,P1,P2,_),harmonic_interval(V1,V2,P1,_), harmonic_interval(V1,V2,P2,_),  note(V1,P1,V1Pi1), note(V2,P1,V2Pi1), note(V1,P2,V1Pi2), note(V2,P2,V2Pi2), V1Pi2 > V1Pi1, V2Pi2 < V2Pi1 )).

:-add_pattern_to_wm((contrary_motion(V1,V2,P1,P2):-melodic_interval(V1,P1,P2,_),melodic_interval(V2,P1,P2,_),harmonic_interval(V1,V2,P1,_), harmonic_interval(V1,V2,P2,_),  note(V1,P1,V1Pi1), note(V2,P1,V2Pi1), note(V1,P2,V1Pi2), note(V2,P2,V2Pi2), V1Pi2 < V1Pi1, V2Pi2 > V2Pi1 )).

:-add_pattern_to_wm((direct_motion(V1,V2,P1,P2):-melodic_interval(V1,P1,P2,_),melodic_interval(V2,P1,P2,_),harmonic_interval(V1,V2,P1,_), harmonic_interval(V1,V2,P2,_),  note(V1,P1,V1Pi1), note(V2,P1,V2Pi1), note(V1,P2,V1Pi2), note(V2,P2,V2Pi2), V1Pi2 > V1Pi1, V2Pi2 > V2Pi1 )).

:-add_pattern_to_wm((direct_motion(V1,V2,P1,P2):-melodic_interval(V1,P1,P2,_),melodic_interval(V2,P1,P2,_),harmonic_interval(V1,V2,P1,_), harmonic_interval(V1,V2,P2,_),  note(V1,P1,V1Pi1), note(V2,P1,V2Pi1), note(V1,P2,V1Pi2), note(V2,P2,V2Pi2), V1Pi2 < V1Pi1, V2Pi2 < V2Pi1 )).

:-add_pattern_to_wm((restrict_to_contrary_or_direct_motion(V1,V2,P1,P2):-direct_motion(V1,V2,P1,P2))).
:-add_pattern_to_wm((restrict_to_contrary_or_direct_motion(V1,V2,P1,P2):-contrary_motion(V1,V2,P1,P2))).
:-add_pattern_to_wm((restrict_to_contrary_or_oblique_motion(V1,V2,P1,P2):-contrary_motion(V1,V2,P1,P2))).
:-add_pattern_to_wm((restrict_to_contrary_or_oblique_motion(V1,V2,P1,P2):-oblique_motion(V1,V2,P1,P2))).
:-add_pattern_to_wm((restrict_to_direct_or_oblique_motion(V1,V2,P1,P2):-oblique_motion(V1,V2,P1,P2))).
:-add_pattern_to_wm((restrict_to_direct_or_oblique_motion(V1,V2,P1,P2):-direct_motion(V1,V2,P1,P2))).

:-add_pattern_to_wm((restrict_to_all_motions(V1,V2,P1,P2):-direct_motion(V1,V2,P1,P2))).
:-add_pattern_to_wm((restrict_to_all_motions(V1,V2,P1,P2):-contrary_motion(V1,V2,P1,P2))).
:-add_pattern_to_wm((restrict_to_all_motions(V1,V2,P1,P2):-oblique_motion(V1,V2,P1,P2))).
:-add_pattern_to_wm((oblique_motion(V1,V2,P1,P2):-melodic_interval(V11,P11,P21), melodic_interval(V21,P12,P22), V21=V11, P21=P22, P11=P22, P11=P1, P21=P2, P12=P1, P22=P2, V21=V2, V22=V2, V12=V1, V11=V1)).%, note(V1,P1,V1Pi1), note(V2,P1,V2Pi1), note(V1,P2,V1Pi2), note(V2,P2,V2Pi2), V1Pi2 \= V1P1, V2Pi2 = V2P1)). 
:-add_pattern_to_wm((oblique_motion(V1,V2,P1,P2):-melodic_interval(V1,P1,P2), melodic_interval(V2,P1,P2))).%, note(V1,P1,V1Pi1), note(V2,P1,V2Pi1), note(V1,P2,V1Pi2), note(V2,P2,V2Pi2), V1Pi2 = V1P1, V2Pi2 \= V2P1)). 

%:-add_pattern_to_wm((no_voice_cross(V1,V2,P1,P2) :-
%		     over(V1,V2,P1),
%		     over(V1,V2,P2),
%		     next(V1,P1,P2),
%		     next(V2,P1,P2),
%		     note(V1,P1,Pi11),
%		     note(V1,P2,Pi12),
%		     note(V2,P1,Pi21),
%		     note(V2,P2,Pi22),
%		     Pi11 >= Pi21,
%		     Pi12 >= Pi22)).

%:-add_pattern_to_wm((no_voice_cross(V1,V2,P1,P2) :-
%		     over(V1,V2,P1),
%		     over(V1,V2,P2),
%		     next(V1,P1,P2),
%		     next(V2,P1,P2),
%		     note(V1,P1,Pi11),
%		     note(V1,P2,Pi12),
%		     note(V2,P1,Pi21),
%		     note(V2,P2,Pi22),
%		     Pi11 =< Pi21,
%		     Pi12 =< Pi22)).

:-add_pattern_to_wm((different(V,P1,P2):-note(V,P1,Pi1), note(V,P2,Pi2), Pi1 \= Pi2)).
		     
