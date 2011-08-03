local
   P1 = proc {$ A} {Browse A} end
   P2 = proc {$} {Browse proc2} end
   P3 = proc {$} {Browse proc3} end
   
   L = [P1 P2 P3]
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
   
in
   {Procedure.apply P1 [2]}
   %{ForAll {SHUFFLE L} proc {$ A} {A} end}
   case {Browse h} of nil then
      {Browse helloworld}
   [] [3 4] then
      {Browse [3 4]}
       
   end
   
end
