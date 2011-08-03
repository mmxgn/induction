import re





def main():
    def characterize_example(e, ch):
        oldch = re.findall('example_set\(([A-Za-z0-9_]+),.*', e)
        print "Oldch: "+str(oldch)
        e = e.replace('example_set('+oldch[0],'example_set('+ch)
        return e
    print "Characterizing examples:"
    f = open('examples.pl')
    examples = f.readlines()
    
    choices = []
    for i in examples:
        if not re.match('example_set\(',i):
            examples.remove(i)
        else:
            ch = re.findall('example_set\(([A-Za-z0-9_]+),.*', i)
            if ch[0] not in choices:
                choices.append(ch[0])
    
    f.close()
    
    new_examples = []
    print examples
    for e in examples:
        newexample = e
        print "Example string:"
        print e
        print "\n"
        print "Characterize as:"
        print
        default = re.findall('example_set\(([A-Za-z0-9_]+),.*', e)
        print "return) Default: `"+default[0] +"'."
        for i in range(0,len(choices)):
            print str(i)+") Characterize as `" + str(choices[i]) +"'."
        print str(len(choices))+") Enter new."
        print "d) Skip/Delete example."
        print 
        print "all) Characterize all, as the same."
        print "abort) Keep old names. Do not characterize differently."
        print
        c = raw_input('in>').strip()
        if c == "abort":
            print "Keeping the old characterizations."
            new_examples = examples
            break
        
        if c == "all":
            print "Characterizing all the same."
            print "Enter string:"
            s = raw_input('in>').strip()
            for i in examples:
                enew = characterize_example(i, s)
                new_examples.append(enew)
            print "Exiting."
            break
        
        if c == "d":
            print "Skipping example."
            continue
            
        if c == "":
            print "Leaving default: `" + default[0] + "'"
            new_examples.append(e)
            continue
        
        if int(c)>=0 and int(c)<len(choices):
            print "Characterizing as: `"+choices[int(c)]+"'."
            enew = characterize_example(e, choices[int(c)])
            new_examples.append(enew)
            
        if int(c) == len(choices):
            print "Enter new string."
            newstr = raw_input().strip()
            print "Characterizing as: `"+newstr
            enew = characterize_example(e,newstr)
            if newstr not in choices:
                choices.append(newstr)
            new_examples.append(enew)
            
    print "The new example sets are:"
    f = open('examples_new.pl','w')
    for n in new_examples:
        print n
        f.write(n)
    f.write('\n')
    f.close()
    
if __name__=="__main__":
    main()
