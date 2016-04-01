#!/usr/bin/python
# -*- coding: utf-8 -*-

# convert <a><b><c>. to a,b,c
import sys

def converter(line):
    token = ''
    result = ''
    for i in range(len(line)):
        if line[i] == '<':
            i += 1
            j = i
            while line[j] != '>' and line[j] != '.':
                if line[j] == ',':
                    token = token + ' '
                    j += 1
		elif line[j] == '"':
                    token = token + ''
                    j += 1                
		else:
                    token = token + line[j]
                    j += 1
            result += token + ','
            token = ''
        i = j
    if result.endswith(','):
        result = result[:-1]
    return result


# main

f = open(sys.argv[1], 'r')
o = open('tnoc.csv', 'a')

line = f.readline()
while line != '':
    nline = converter(line)
    line = f.readline()
    if line == '':
        o.write(nline)
    else:
        o.write(nline + '\n')

o.close()


			
