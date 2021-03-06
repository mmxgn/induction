"""Transforms prolog patterns to Oz constraints.

Usage:
    python genpats.py <input> where:
        input:     file extension: .pl
                   Provides patterns in prolog
                   horn clauses form.

    outputs oz_loops.oz, oz_pal.oz.
"""
import re
import sys
import getopt


def main():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "h", ["help"])
    except getopt.error, msg:
        print msg
        print "for help use --help"
        sys.exit(2)
    for o, a in opts:
        if o in ("-h", "--help"):
            print __doc__
            sys.exit(0)

    process(args[0])
def clause_prologtooz(clause):
    """ input: a clause as a string in prolog format
        output: a clause as a string in Oz format
    """

    # 0. Sanitize. Remove dot and spaces.

    clause = clause.replace(' ','').replace('.','')
    
    # 1. Split to head and body.

    Head, Body = clause.split(':-')

    # 2.1 Capitalize Head.

    HeadOz = lit_prologtooz(Head)
    
    # 2.2

    # 2.2.1 Split literals

    m = re.findall('[a-zA-Z][a-zA-Z0-9_]+\([A-Za-z0-9,_]+\)',\
                   Body)

    BodyOz = ""
    for i in m:
        iOz = lit_prologtooz(i)
        BodyOz += "\tthread "+iOz+" end\n"

    toOz = "proc " + HeadOz + "\n" + BodyOz + 'end'

    return toOz

def clause_headprologtooz(clause):
    """ input: a clause as a string in prolog format
        output: the head of a clause as a string in Oz format
    """

    # 0. Sanitize. Remove dot and spaces.
    clause = clause.replace(' ','').replace('.','')
    
    # 1. Split to head and body.

    Head, Body = clause.split(':-')

    # 2.1 Capitalize Head.

    HeadOz = lit_prologtooz(Head)
    return HeadOz

def ozlit_sanitize(lit):
    """ Will replace non VOICES and non POSITIONS with don't
    care variables ( `_' )
    """
    lit2 = lit
    lit2 = lit2.replace('{','').replace('}','')

    l = lit2.split(' ')
    l = l[1:]
    voices = 0
    positions = 0
    for i in l:
        if re.match('(POSITION[0-9]+)',i):
            if positions >= 1:
                lit = lit.replace(i,'_')
            else:
                lit = lit.replace(i,'POSITION')

            positions += 1
        if re.match('(VOICE[0-9]+)',i):
            if voices >= 1:
                lit = lit.replace(i,'_')
            else:
                lit = lit.replace(i,'POSITION')

            voices += 1
        if not re.match('(POSITION[0-9]+)|(VOICE[0-9]+)',i):
            lit = lit.replace(i,'_')
    return lit

def lit_prologtooz(lit):
    """ input: a string as a literal in prolog format
        output: a string as a literal in Oz format
    """

    # 1. Capitalize

    lit = lit.upper()

    # 2. Replace commas with spaces
    lit = lit.replace(',',' ')

    # 3. Remove parentheses
    lit = lit.replace('(',' ').replace(')','')

    # 4. Place them into brackets
    lit = '{' + lit + '}'

    return lit
    
def process(arg):
    voiceset = set([])
    posset = set([])
    f = open(arg)
    lines = f.readlines()
    f.close()
    newlist=[]

    for i in lines:
        curvoices = set([])
        curpositions = set([])
        m = re.findall('note\((genvar\d+|\d+),(genvar\d+|\d+),[a-zA-Z0-9,]+\)',i)
        print i
        print m
        for j in m:
            counter = 0
            if re.match('genvar\d+', j[0]):
                curvoices.add(j[0])
            if re.match('genvar\d+', j[1]):
                curpositions.add(j[1])
        print curvoices
        print curpositions
        I = i
        curvoices_l = list(curvoices)
        curpositions_l = list(curpositions)
        
        for v in range(0, len(curvoices_l)):
          #  print I
            
            I = I.replace(curvoices_l[v]+",","Voice"+str(v)+",")
       #     print I
            I = I.replace(curvoices_l[v]+")","Voice"+str(v)+")")

            voiceset.add("Voice"+str(v))
            
        for p in range(0, len(curpositions_l)):
         #   print I
            I = I.replace(curpositions_l[p]+",", "Position"+str(p)+",")
         #   print I
            I = I.replace(curpositions_l[p]+")", "Position"+str(p)+")")

            posset.add("Position"+str(p))
        newlist.append(I)
        print I
    print voiceset
    print posset

    print "For oz_pal.oz:\n"

    palstr = ""
    for i in newlist:
        palstr+= clause_prologtooz(i) + "\n"

    print "\n"
    print newlist
    print "For oz_loops.oz:\n"

    loopstr=""
    for i in newlist:
        h, b = i.split(':-')
        hc = clause_headprologtooz(i)
        if '(' not in h:
            loopstr+="dis " + ozlit_sanitize(hc) + " [] skip end \n"
            newlist.remove(i)
            
    if len(voiceset)+len(posset)>0:
        #for i in voiceset:
        #    loopstr+="for "+i.upper()+" in 1..NV do\n"
        #for i in posset:
        #    loopstr+="for "+i.upper()+" in 1..NP do\n"

        if len(voiceset)>0:
            loopstr+="for VOICE in 1..NV do\n"
        if len(posset)>0:
            loopstr+="for POSITION in 1..NP do\n"

        loopstr +="dis \n case {OS.rand} mod "+ str(len(newlist)) + "\n"
        for i in newlist:
            if newlist.index(i) == 0:
                loopstr += "of 0 then"
            else:
                loopstr += "[] " + str(newlist.index(i)) + " then "
            hc = clause_headprologtooz(i)
            loopstr += ozlit_sanitize(hc) + "\n"
        loopstr +="end \n"
        loopstr +="[] skip\nend\n"

#        for i in range(0,len(voiceset)):
 #           loopstr+="end\n"
  #      for i in range(0,len(posset)):
   #         loopstr+="end\n"
        if len(voiceset)>0:
            loopstr+="end\n"
        if len(posset)>0:
            loopstr+="end\n"

    print loopstr
    
    ozloops = open('oz_loops.oz','w')
    ozpal = open('oz_pal.oz','w')

    ozloops.write(loopstr)
    ozloops.close()

    ozpal.write(palstr)
    ozpal.close()

    print "Finished."
            
            
        

if __name__=="__main__":
    main()
