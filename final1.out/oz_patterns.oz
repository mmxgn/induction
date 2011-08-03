proc {NOTE Voice Position Pitch}
   {{Nth {{Nth {Solution getItems($)} Voice} getItems($)} Position} getPitch($)} = Pitch   
end

proc {DURATION Voice Position Duration}
   {{Nth {{Nth {Solution getItems($)} Voice} getItems($)} Position} getDuration($)} = Duration
end


proc {HARMONIC_INTERVAL V1 V2 P INT}
   Pi1 Pi2 in
   {NOTE V1 P Pi1}
   {NOTE V2 P Pi2}
   {FD.distance Pi1 Pi2 '=:' INT}
end

proc {HARMONIC_INTERVAL_MOD V1 V2 P INT}
   Pi1 Pi2 Aux = {FD.decl} in
   {NOTE V1 P Pi1}
   {NOTE V2 P Pi2}
   Aux =: Pi2 - Pi1 + 12
   {FD.modI Aux 12 INT}
   
end

proc {DIFFERENT V P1 P2}
   Pi1 Pi2 in
   {NOTE V P1 Pi1}
   {NOTE V P2 Pi2}
   Pi1 \=: Pi2
end


   


proc {MELODIC_INTERVAL V P1 P2 INT}
   if P2 \= P1 + 1 then skip
   else
      
   Pi1 Pi2 in
   {NOTE V P1 Pi1}
   {NOTE V P2 Pi2}
      {FD.distance Pi1 Pi2 '=:' INT}
   end
   
end


     % proc {HARMONIC_DISSONANCE Voice1 Voice2 Pos}
     % 	 {HARMONIC_INTERVAL Voice1 Voice2 Pos {FD.int [1 2 5 6 10 11]}}
     %  end

      
     %  proc {MELODIC_DISSONANCE Voice Pos1 Pos2}
     % 	 {MELODIC_INTERVAL Voice Pos1 Pos2 {FD.int [1 2 5 6 10 11]}}
     %  end

      % proc {VALID_MELODIC_INTERVAL Voice Pos1 Pos2}
      % 	 choice
      % 	    {CMAJOR Voice Pos1}
      % 	    {CMAJOR Voice Pos2}
      % 	 []
      % 	    {CSMAJOR Voice Pos1}
	    
      % 	    {CSMAJOR Voice Pos2}
      % 	 []
      % 	    {DFMAJOR Voice Pos1}
      % 	    {DFMAJOR Voice Pos2}
      % 	 []
      % 	    {EMAJOR Voice Pos1}
      % 	    {EMAJOR Voice Pos2}
      % 	 []
      % 	    {FMAJOR Voice Pos1}
      % 	    {FMAJOR Voice Pos2}
      % 	 []
      % 	    {FSMAJOR Voice Pos1}
      % 	    {FSMAJOR Voice Pos2}
      % 	 []
	    
      % 	    {GSMAJOR Voice Pos1}
      % 	    {GSMAJOR Voice Pos2}
		   
      % 	 []
      % 	    {AFMAJOR Voice Pos1}
      % 	    {AFMAJOR Voice Pos2}
      % 	 []
      % 	    {BMAJOR Voice Pos1}
      % 	    {BMAJOR Voice Pos2}
      % 	 []	    
      % 	    {DMAJOR Voice Pos1}
      % 	    {DMAJOR Voice Pos2}
      % 	 []
      % 	    {GMAJOR Voice Pos1}
      % 	    {GMAJOR Voice Pos2}
      % 	 end
	 
      % end

      proc {MELODIC_CONSONANCE Voice Pos1 Pos2}
	 %case {OS.rand} mod 2 of 0 then
	 choice
	    {MELODIC_PERFECT_CONSONANCE Voice Pos1 Pos2}
	 []% 1 then
	    {MELODIC_IMPERFECT_CONSONANCE Voice Pos1 Pos2}
	 end
      end
      

%      proc {HARMONIC_CONSONANCE Voice1 Voice2 Pos}
%	 {HINT Voice1 Voice2 Pos {FD.int [3 4 8 9 0 7 12]}}

%	 choice% {OS.rand} mod 2 of 0 then
%	    {HARMONIC_PERFECT_CONSONANCE Voice1 Voice2 Pos}
%	 [] %1 then
%	    {HARMONIC_IMPERFECT_CONSONANCE Voice1 Voice2 Pos}
%	 end
      proc {HARMONIC_CONSONANCE Voice1 Voice2 Pos}
	 {HARMONIC_INTERVAL Voice1 Voice2 Pos {FD.int [0 3 4 7 8 9 12]}}
      end
      
	 

      
      proc {MELODIC_PERFECT_CONSONANCE Voice Pos1 Pos2}
	 {MELODIC_INTERVAL Voice Pos1 Pos2 {FD.int [0 7 12]}}
      end
      proc {MELODIC_IMPERFECT_CONSONANCE Voice Pos1 Pos2}
	 {MELODIC_INTERVAL Voice Pos1 Pos2 {FD.int [3 4 8 9]}}
      end

      
      proc {HARMONIC_PERFECT_CONSONANCE Voice1 Voice2 Pos}
	 
	 {HARMONIC_INTERVAL Voice1 Voice2 Pos {FD.int [0 7 12]}}
      end
     
      proc {HARMONIC_IMPERFECT_CONSONANCE Voice1 Voice2 Pos}
	 %dis Voice1 \=: Voice2 []
	    {HARMONIC_INTERVAL Voice1 Voice2 Pos {FD.int [3 4 8 9]}}
	 %end
	 
	 
      end    
      
 
proc {HARMONIC_DISSONANCE Voice1 Voice2 Pos}
   {HARMONIC_INTERVAL Voice1 Voice2 Pos {FD.int [1 2 6 10 11]}}   
end

proc {MELODIC_DISSONANCE Voice Pos1 Pos2}
   
   {MELODIC_INTERVAL Voice Pos1 Pos2 {FD.int [1 2 5 6 10 11]}}
   
end


proc {NEXT V P1 P2}
   
%   {NOTE V P1 _}
%   {NOTE V P2 _}
  % dis
      P2 = P1 + 1
  % []
   %   skip
  % end
   
  
%      fail
%      skip
%  end
%   
end
proc {OVER V1 V2 P}
   %choice
      
   Pi1 Pi2 in 
   {NOTE V1 P Pi1}
   {NOTE V2 P Pi2}

   V2 = V1 + 1
   Pi2 >=: Pi1
   %[]
   %   skip
   %end
   
end

proc {CMAJOR V P}
   Pitch in 
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [0 2 4 5 7 9 11]}
end
proc {CMAJORCHORD P}
%   V1 V2 V3
   Pi1 Pi2 Pi3 in
   %ase {OS.rand} mod 6 of 0 then
   choice
      {NOTE 1 P Pi1}
      {NOTE 2 P Pi2}
      {NOTE 3 P Pi3}
   []% 1 then
      {NOTE 2 P Pi1}
      {NOTE 1 P Pi2}
      {NOTE 3 P Pi3}
   []% 2 then
      {NOTE 3 P Pi1}
      {NOTE 1 P Pi2}
      {NOTE 2 P Pi3}
   []% 3 then
      {NOTE 3 P Pi1}
      {NOTE 2 P Pi2}
      {NOTE 1 P Pi3}
   []% 4 then
      {NOTE 1 P Pi1}
      {NOTE 3 P Pi2}
      {NOTE 2 P Pi3}
   []% 5 then
      {NOTE 2 P Pi1}
      {NOTE 3 P Pi2}
      {NOTE 1 P Pi3}
   end
   {FD.modI Pi1 12} =:  0
   {FD.modI Pi2 12} =:  4
   {FD.modI Pi3 12} =:  7
   skip
end


   
proc {CSMAJOR V P}
   Pitch in 
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [1 3 5 6 8 10 0]}
end
proc {CSMAJORCHORD P}
%   V1 V2 V3
   Pi1 Pi2 Pi3 in
   case {OS.rand} mod 6 of 0 then
      {NOTE 1 P Pi1}
      {NOTE 2 P Pi2}
      {NOTE 3 P Pi3}
   [] 1 then
      {NOTE 2 P Pi1}
      {NOTE 1 P Pi2}
      {NOTE 3 P Pi3}
   [] 2 then
      {NOTE 3 P Pi1}
      {NOTE 1 P Pi2}
      {NOTE 2 P Pi3}
   [] 3 then
      {NOTE 3 P Pi1}
      {NOTE 2 P Pi2}
      {NOTE 1 P Pi3}
   [] 4 then
      {NOTE 1 P Pi1}
      {NOTE 3 P Pi2}
      {NOTE 2 P Pi3}
   [] 5 then
      {NOTE 2 P Pi1}
      {NOTE 3 P Pi2}
      {NOTE 1 P Pi3}
   end
   {FD.modI Pi1 12} =:  1
   {FD.modI Pi2 12} =:  5
   {FD.modI Pi3 12} =:  8
   skip
end
proc {DFMAJOR V P}
   Pitch in 
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [1 3 5 6 8 10 0]}
end
proc {DFMAJORCHORD P}
%   V1 V2 V3
   Pi1 Pi2 Pi3 in
   case {OS.rand} mod 6 of 0 then
      {NOTE 1 P Pi1}
      {NOTE 2 P Pi2}
      {NOTE 3 P Pi3}
   [] 1 then
      {NOTE 2 P Pi1}
      {NOTE 1 P Pi2}
      {NOTE 3 P Pi3}
   [] 2 then
      {NOTE 3 P Pi1}
      {NOTE 1 P Pi2}
      {NOTE 2 P Pi3}
   [] 3 then
      {NOTE 3 P Pi1}
      {NOTE 2 P Pi2}
      {NOTE 1 P Pi3}
   [] 4 then
      {NOTE 1 P Pi1}
      {NOTE 3 P Pi2}
      {NOTE 2 P Pi3}
   [] 5 then
      {NOTE 2 P Pi1}
      {NOTE 3 P Pi2}
      {NOTE 1 P Pi3}
   end
   {FD.modI Pi1 12} =:  1
   {FD.modI Pi2 12} =:  5
   {FD.modI Pi3 12} =:  8
   skip
end
proc {DMAJOR V P}
   Pitch in 
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [2 4 6 7 9 11 1]}
   
end
proc {DMAJORCHORD P}
%   V1 V2 V3
   Pi1 Pi2 Pi3 in
   case {OS.rand} mod 6 of 0 then
      {NOTE 1 P Pi1}
      {NOTE 2 P Pi2}
      {NOTE 3 P Pi3}
   [] 1 then
      {NOTE 2 P Pi1}
      {NOTE 1 P Pi2}
      {NOTE 3 P Pi3}
   [] 2 then
      {NOTE 3 P Pi1}
      {NOTE 1 P Pi2}
      {NOTE 2 P Pi3}
   [] 3 then
      {NOTE 3 P Pi1}
      {NOTE 2 P Pi2}
      {NOTE 1 P Pi3}
   [] 4 then
      {NOTE 1 P Pi1}
      {NOTE 3 P Pi2}
      {NOTE 2 P Pi3}
   [] 5 then
      {NOTE 2 P Pi1}
      {NOTE 3 P Pi2}
      {NOTE 1 P Pi3}
   end
   {FD.modI Pi1 12} =:  2
   {FD.modI Pi2 12} =:  6
   {FD.modI Pi3 12} =:  9
   skip
end


proc {DSMAJOR V P}
   Pitch in 
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [3 5 7 8 10 0 2]}
end
proc {EFMAJOR V P}
   Pitch in 
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [3 5 7 8 10 0 2]}
end
proc {EMAJOR V P}
   Pitch in 
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [4 6 8 9 11 1 3]}
end
proc {FMAJOR V P}
   Pitch in 
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [5 7 9 10 0 2 4]}
end
proc {FSMAJOR V P}
   Pitch in 
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [6 8 10 11 1 3 5]}
end
proc {GFMAJOR V P}
   Pitch in 
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [6 8 10 11 1 3 5]}
end
proc {GMAJOR V P}
   Pitch in
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [7 9 11 0 2 4 6]}
end
proc {GSMAJOR V P}
   Pitch in
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [8 10 0 1 3 5 7]}
end
proc {AFMAJOR V P}
   Pitch in
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [8 10 0 1 3 5 7]}
end
proc {AMAJOR V P}
   Pitch in
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [9 11 1 2 4 6 8]}
end
proc {ASMAJOR V P}
   Pitch in
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [10 0 2 3 5 7 9]}
end
proc {BFMAJOR V P}
   Pitch in
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [10 0 2 3 5 7 9]}
end
proc {BMAJOR V P}
   Pitch in
   {NOTE V P Pitch}
   {FD.modI Pitch 12} =: {FD.int [11 1 3 4 6 8 10]}
end

proc {MELODIC_SKIP Voice Pos1 Pos2}
   Pi1 Pi2 in
   {NOTE Voice Pos1 Pi1}
   {NOTE Voice Pos2 Pi2}
   {FD.distance Pi1 Pi2 '>:' 5}
end
proc {MELODIC_STEP Voice Pos1 Pos2}

 %  dis
 %    Pos1 \=: Pos2
 %     Pi1 Pi2 in
   if Pos1 == Pos2 then
      Pi1 Pi2 in 
   {NOTE Voice Pos1 Pi1}
   {NOTE Voice Pos2 Pi2}
   {FD.distance Pi1 Pi2 '=<:' 5}
      {FD.distance Pi1 Pi2 '>=:' 0}
   else skip end
   
 %  [] Pos1 = Pos2 end 
end


% Motions
     % proc {DIRECT_MOTION Voice1 Voice2 Position1 Position2}
     % 	 V1Pi1 V2Pi1 V1Pi2 V2Pi2 in
     % 	 {NOTE Voice1 Position1 V1Pi1}
     % 	 {NOTE Voice1 Position2 V1Pi2}
     % 	 {NOTE Voice2 Position1 V2Pi1}
     % 	 {NOTE Voice2 Position2 V2Pi2}
     % 	    {CHOICEFROMLIST [proc {$}
     % 				V1Pi2 <: V1Pi1
     % 				V2Pi2 <: V2Pi1
     % 			     end

     % 			     proc{$}
     % 				V1Pi2 >: V1Pi1
     % 				V2Pi2 >: V2Pi1
     % 			     end
     % 			    ]
     % 	     nil
     % 	     }

%	 case {OS.rand} mod 2 of
%	    0 then
	%choice
	    
%	    V1Pi2 >: V1Pi1
%	    V2Pi2 >: V2Pi1
%	 [] 1 then 
%	    V1Pi2 <: V1Pi1
%	    V2Pi2 <: V2Pi1
%	 end
%     end
      T
      proc {TP}
	 T=:3
      end

      proc {OBLIQUE_MOTION V1 V2 P1 P2}
	    {CHOICEFROMLIST [proc {$}
				{NOTE V1 P1+1} \=: {NOTE V1 P1}
				{NOTE V1+1 P1+1} =: {NOTE V1+1 P1}
			     end

			     proc{$}
				{NOTE V1 P1+1} =: {NOTE V1 P1}
				{NOTE V1+1 P1+1} \=: {NOTE V1+1 P1}
			     end

			     proc{$}
				{NOTE V1 P1+1} =: {NOTE V1 P1}
				{NOTE V1+1 P1+1} =: {NOTE V1+1 P1}
			     end			     
			    ]

	     
	    nil
	    }				
	 end
      proc {DIRECT_MOTION V1 V2 P1 P2}
	    {CHOICEFROMLIST [proc {$}
				{NOTE V1 P1+1} >: {NOTE V1 P1}
				{NOTE V1+1 P1+1} >: {NOTE V1+1 P1}
			     end

			     proc{$}
				{NOTE V1 P1+1} <: {NOTE V1 P1}
				{NOTE V1+1 P1+1} <: {NOTE V1+1 P1}
			     end
			    ]
	    nil
	    }				
      end
      
     proc {CONTRARY_MOTION V1 V2 P1 P2}
	    {CHOICEFROMLIST [proc {$}
				{NOTE V1 P1+1} >: {NOTE V1 P1}
				{NOTE V1+1 P1+1} <: {NOTE V1+1 P1}
			     end

			     proc{$}
				{NOTE V1 P1+1} <: {NOTE V1 P1}
				{NOTE V1+1 P1+1} >: {NOTE V1+1 P1}
			     end
			    ]
	    nil
	    }				
	 end

      % proc {CONTRARY_MOTION V1 V2 P1 P2}
      % 	 case {OS.rand} mod 2 of 0 then
      % 				{NOTE V1 P1+1} >=: {NOTE V1 P1}
      % 				{NOTE V1+1 P1+1} =<: {NOTE V1+1 P1}
      % 	 [] 1 then
      % 				{NOTE V1 P1+1} =<: {NOTE V1 P1}
      % 				{NOTE V1+1 P1+1} >=: {NOTE V1+1 P1}
      % 	 end
	 
      % end
      

      
      % proc {OBLIQUE_MOTION Voice1 Voice2 Position1 Position2}
      % 	    Voice1 \=: Voice2
      % 	    Position1 \=: Position2
	    
      % 	 V1Pi1 V2Pi1 V1Pi2 V2Pi2 in
      % 	 {NOTE Voice1 Position1 V1Pi1}
      % 	 {NOTE Voice1 Position2 V1Pi2}
      % 	 {NOTE Voice2 Position1 V2Pi1}
      % 	 {NOTE Voice2 Position2 V2Pi2}
	
      % 	    {CHOICEFROMLIST [proc {$}
      % 				V1Pi2 \=: V1Pi1
      % 				V2Pi2 = V2Pi1
      % 			     end

      % 			     proc{$}
      % 				V1Pi2 = V1Pi1
      % 				V2Pi2 \=: V2Pi1
      % 			     end
      % 			    ]
      % 	     nil
      % 	     }
				
      % 	 end
	 
      
      proc {RESTRICT_TO_ALL_MOTIONS Voice1 Voice2 Position1 Position2}
	 skip
      end
	 
   

proc {RESTRICT_TO_CONTRARY_OR_DIRECT_MOTION Voice1 Voice2 Position1 Position2}
   choice {CONTRARY_MOTION Voice1 Voice2 Position1 Position2}
   []  {DIRECT_MOTION Voice1 Voice2 Position1 Position2}
   end
   
end

proc {RESTRICT_TO_CONTRARY_OR_OBLIQUE_MOTION V1 V2 P1 P2}
	    {CHOICEFROMLIST [proc {$}
				{NOTE V1 P1+1} >: {NOTE V1 P1}
				{NOTE V1+1 P1+1} =<: {NOTE V1+1 P1}
			     end

			     proc{$}
				{NOTE V1 P1+1} <: {NOTE V1 P1}
				{NOTE V1+1 P1+1} >=: {NOTE V1+1 P1}
			     end
			    ]
	    nil
	    }
   
   end

      proc {RESTRICT_TO_DIRECT_OR_OBLIQUE_MOTION Voice1 Voice2 Position1 Position2}
%	 case {OS.rand} mod 2 of 0 then
	 choice
	    {OBLIQUE_MOTION Voice1 Voice2 Position1 Position2}
	 []% 1 then
	    {DIRECT_MOTION Voice1 Voice2 Position1 Position2}
	 end
      end

      proc {MELODIC_STEADY V P1 P2}
	 Pi1 Pi2 in
	 	 {NEXT V P1 P2}
	 {NOTE V P1 Pi1}
	 {NOTE V P2 Pi2}

	 Pi1 = Pi2
      end

      proc {MELODIC_DOWNWARDS V P1 P2}
	 Pi1 Pi2 in
	 %dis
	    P2 = P1 + 1
	 {NOTE V P1 Pi1}
	 {NOTE V P2 Pi2}
	    Pi2 <: Pi1
	 %[]
	 %   skip
	 %end
	 
      end

      proc {MELODIC_UPWARDS V P1 P2}
	  Pi1 Pi2 in 
	% dis
	    P2 = P1 + 1
	
	 {NOTE V P1 Pi1}
	 {NOTE V P2 Pi2}
	    Pi2 >: Pi1
%	    [] skip
%	 end
	 
      end
      proc {WITHIN_OCTAVE2 V1 V2 P}
	 Pi1 Pi2 in
	 {NOTE V1 P Pi1}
	 {NOTE V2 P Pi2}
	 {FD.distance Pi1 Pi2 '=<:' 12}
      end
      proc {WITHIN_OCTAVE V P1 P2}
	 Pi1 Pi2 in
	 {NOTE V P1 Pi1}
	 {NOTE V P2 Pi2}
	 {FD.distance Pi1 Pi2 '=<:' 12}
      end
      
      
      proc {ALL_CMAJOR}
	 for V in 1..NV do
	    for P in 1..NP do
	       {CMAJOR V P}
	    end
	 end
      end

      proc {ALL_GMAJOR}
	 for V in 1..NV do
	    for P in 1..NP do
	       {GMAJOR V P}
	    end
	 end
      end