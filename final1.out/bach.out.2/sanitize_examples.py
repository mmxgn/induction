#!/usr/bin/python

import re
import string

def main():
    f = open('examples.pl')
    lines = f.readlines()
    f.close()

    dictionary = {}
    lengths = []
    sets = set([])
    for i in lines:
        if not i == '\n':
            s = re.match(\
                'example_set\((?P<name>[a-z][A-Za-z0-9_]*),\[(?P<elements>[A-Za-z0-9_,()]+)\]\)\.',\
                i).groupdict()
            name = s['name']
            elements = re.findall('[a-zA-Z0-9_]+\([a-zA-Z0-9_,]+\)',s['elements'])

            sets.add(name)
          #  dlist.append({'name':name, 'elements': elements})
            if name in dictionary:
                dictionary[name].append(elements)
            else:
                dictionary[name] = [elements]

    for L in dictionary:

        lengths = []
        for l in dictionary[L]:
            lengths.append(len(l))

        minimum = min(lengths)

        for l in range(0,len(dictionary[L])):
            dictionary[L][l] = dictionary[L][l][1:minimum]

    strout = ""
    for name in dictionary:
        for l in dictionary[name]:
            strout += "example_set("+name+",["+string.join(l, ',')+"]).\n"
    fout = open('examples_pre.pl','w')
    fout.write(strout)
    fout.close()
    
        
        


            

if __name__=="__main__":
    main()
