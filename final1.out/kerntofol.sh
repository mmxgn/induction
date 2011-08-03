#!/bin/bash
LANG="el_GR.ISO-8859-7"
INFILE=$1
FILENAME=`echo $1 | cut -d'.' -f1`
OUTFILE="$FILENAME.in.pl"
MINDUR="$2"
TMPDIR=$FILENAME.tmp

echo "Converting $INFILE to $OUTFILE"

mkdir $TMPDIR

echo "a) Converting to a constant time base."
TIMEBASE=$TMPDIR/$FILENAME.tb
timebase -t $MINDUR $INFILE > $TIMEBASE
echo "b) Creating numeric position."
#num -a '**pos' -s "^=" -R "^=" chor001.krn | extract -i '**pos' | ditto

POSITIONS=$TMPDIR/$FILENAME.pos.tmp
num -a '**pos' -n "([1-9]+[.A-Ga-g]+)" -s "(=[0-9]+)" -R "(=[0-9]+)"  $TIMEBASE | sed 's/\t\t/\t/' | extract -i '**pos' > $POSITIONS
ditto $POSITIONS > $POSITIONS.2
POSITIONS2=$TMPDIR/$FILENAME.pos
assemble $TIMEBASE $POSITIONS.2 | sed 's/\t\t/\t/' > $POSITIONS2
echo "c.i) Extracting notes"
echo "c.i.1) Converting to intermediate form 1."
INTERM0=$TMPDIR/$FILENAME.im0
INTERM1=$TMPDIR/$FILENAME.im1
extract -i '**kern,**pos' $POSITIONS2 | humsed 's/\([1-9^=^.][1-9^=^.]*\.*\)\([A-Ga-g][A-Ga-g]*\)/\\2,\\1/g' | semits > $INTERM1
echo "d) Converting to first order logic form."
#rid -GIL $INTERM1 | awk '{str=""; for (i=1;i<=NF-1;i++) if($i~"^[^=.]") {str=str"note("i","$NF","$i"). "} else if ($i~"^="){str=str"barline("$NF"). "}; print str}' | sed 's/[^0-9A-Za-z,(). ]//g' > $OUTFILE

rid -GIL $INTERM1 | awk '{str=""; for (i=1;i<=NF-1;i++) if($i~"-?[0-9][0-9]*,[0-9][0-9]*\.?") {split($i,A,","); if(A[2]~"[0-9][0-9]*\\.") {match(A[2],"[0-9][0-9]*",B); C=1/B[0]+1/B[0]/2} else C=1/A[2]; str=str"note("i","$NF","A[1]+60","C*'$MINDUR'"). "} else if ($i~"^="){str=str"barline("$NF"). "}; print str} END {print "info("NF-1","$NF",'$MINDUR')."} ' | sed 's/[^0-9A-Za-z,(). -]//g' > $OUTFILE

echo "e) Appending additional temporal information."
echo "mindur("$MINDUR")." >> $OUTFILE
echo "Wrote "$OUTFILE
echo "finished."
# Emeina edw.


# End

#rm -R $TMPDIR

