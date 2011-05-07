#!/usr/bin/env python2.5
# a simple script that takes a surface form (word)
# as input and runs the kimmo recognizer on it
# using spanish.yaml as the configuration file.

from kimmo import *
import sys

k = KimmoRuleSet.load('spanish.yaml')
if len(sys.argv[1:]) == 0:
    print "usage: %s <word> [<trace>]" %(sys.argv[0])
    sys.exit()

word = sys.argv[1]
trace = 1

if len(sys.argv) > 2:
  trace = sys.argv[2]

print list(k.recognize(word, TextTrace(trace))), '<=', word

