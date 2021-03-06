local
   MD = 1

   proc {CHOICEFROMLIST LIN Args}
      L in
      
      L = {SHUFFLE LIN}
      case L of nil then skip
      [] H|T then
	 
	 dis
	       {Procedure.apply H Args}
	       
	[]
	      {CHOICEFROMLIST T Args}
	 end
	 
	 
      end
   end
   
	    
  
	 
 
	
   fun {SHUFFLE L}
      % Shuffling algorithm taken as is from
      % http://www.mail-archive.com/mozart-users@mozart-oz.org/msg01828.html
      % Kari Pahula's message.
      
      {List.map {List.sort
   		 {List.map
   		  L
   		  fun {$ A} A#{OS.rand} end
   		 }
   		 fun {$ A B} M N in
   		    A = _#N
   		    B = _#M N>M end}
       fun {$ A} B in A = B#_ B end}
   end
%   fun {SHUFFLE L}
%      L
%   end
   
   fun {MakeVoice Pitches Duration}
      {Score.makeScore2 seq(items:
			       {Map Pitches fun {$ P}
				  note(pitch: P duration: 1)
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
      
      NP = 24
      L = 24
      NV = 1
     
   in
  %    Solution = {Score.makeScore sim(items:[{MakeVoice {FD.list NP 40#59} L} {MakeVoice {FD.list NP 48#69} L} {MakeVoice {FD.list NP 57#76} L} {MakeVoice {FD.list NP 60#81} L} ]  timeUnit:beats) unit}
    %Solution = {Score.makeScore sim(items:[{MakeVoice {FD.list NP 40#81} L} {MakeVoice {FD.list NP 40#81} L} {MakeVoice {FD.list NP 40#100} L} {MakeVoice {FD.list NP 40#81} L} ]  timeUnit:beats) unit}
  
      
      %Solution = {Score.makeScore sim(items:[{MakeVoice {FD.list NP 60#72} L} {MakeVoice {FD.list NP 60#72} L} ]  timeUnit:beats) unit}

         Solution = {Score.makeScore sim(items:[{MakeVoice {FD.list NP 30#100} L} ]  timeUnit:beats(2)) unit}  
 
      \insert 'oz_loops.oz'
     % {FD.distribute ff Solution}
   end
   

   FinalScore
   Sc
in
   Sc = {SDistro.makeSearchScript Script unit(value:random)}
   {SDistro.exploreOne Sc unit}
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
