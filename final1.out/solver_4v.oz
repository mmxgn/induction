local

   %% Tentatively executes a constraint C (represented as a procedure).
   %% If it is already entailed by the current constraint store, returns false.
   %% Otherwise merges the space (and thereby finally executes the constraint)
   %% and returns true.
   fun {ExecuteConstraint C}
      %% create a compuation space which tentatively executes C
      S = {Space.new
	   proc {$ Root}
	      {C}
	      Root = unit
	   end
	  }
   in
      %% check whether the computation space is entailed
      case {Space.askVerbose S}
      of succeeded(entailed) then false
      else
	 {Wait {Space.merge S}}
	 true
      end
   end

   fun {MakeVoice Pitches Duration}
      {Score.makeScore2 seq(items:
			       {Map Pitches fun {$ P}
				  note(pitch: P duration: {FD.int 1#4})
					    end }
			    startTime: 0
			    duration:Duration
			   ) unit }
   end
   proc {Script Solution}
      \insert 'oz_patterns.oz'



      %Patterns learnt by PAL

      \insert 'oz_pal.oz'



	
      I2 J2
      L = 51
      NP = 51
      NV = 4
     
   in
                  Solution = {Score.makeScore sim(items:[{MakeVoice {FD.list NP 40#82} NP} {MakeVoice {FD.list NP 40#82} NP} {MakeVoice {FD.list NP 40#82} NP} {MakeVoice {FD.list NP 40#82} NP} ]  timeUnit:beats(4)) unit}
      \insert 'oz_loops.oz'
   end
   

  FinalScore
in
   {SDistro.exploreOne Script unit(value:random)}
   {Show '%** Searching for a solution...'}
 %  FinalScore = {Score.makeScore {SDistro.searchOne Script unit(value:random)} unit}.1
  % {FinalScore wait}
  % {Show '%** Done.'}
   
 %  {Inspect FinalScore}
 %  {Show '%** Rendering midi file...'}
 %  thread
 %  {Out.midi.renderAndPlayMidiFile FinalScore
 %  unit(file:'strasheelaout'
 %        midiDir:'/tmp/'
%	csvDir:'/tmp/')}
 %  end

% {Show '%** Rendering lilypond...'}
  % thread
  % {Out.renderAndShowLilypond FinalScore
  %  unit(file:'strasheelaout'
%	 dir:'/tmp/')}
 %  end
   

   
%   {Inspect {Score.makeSeq unit}}
end
