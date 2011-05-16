#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
reload(sys)
sys.setdefaultencoding('utf-8')
import codecs
from kimmo import *
from wordglossing import *

sargs = sys.argv[:]
wordcorpusfn = 'japanese-words.txt'
if "corpus" in sargs:
	sargs.remove("corpus")
	wordcorpusfn = 'corpus/corpus-allwords-base-pos.txt'
passedword = ""
if len(sargs) > 1:
	passedword = sargs[1].decode("utf-8")

k = KimmoRuleSet.load('japanese.yaml')
if passedword != "":
	nbase,npos = get_base_pos_memoized(k, passedword)
	if nbase == None or npos == None:
		print passedword + " [FAILURE]"
	else:
		print passedword + " " + nbase + " " + npos
	exit(0)

recfile = codecs.open(wordcorpusfn, encoding='utf-8')
for line in recfile:
	line = line.strip()
	if not line: continue
	if line.startswith(';'):
		print line
		continue
	spl = line.split(" ")
	word = spl[0]
	base = spl[1]
	if "/" in base:
		base = base.split("/")[0]
	pos = spl[2]
	if "/" in pos:
		pos = pos.split("/")[0]
	nbase,npos = get_base_pos_memoized(k, word)
	if nbase == None or npos == None:
		print word + " " + base + " " + pos + " [FAILURE]"
	elif base != nbase and pos != npos:
		print word + " " + base + "/" + nbase + " " + pos + "/" + npos + " [BPFAIL]"		
	elif base != nbase:
		print word + " " + base + "/" + nbase + " " + pos + " [BASEFAIL]"
	elif pos != npos:
		print word + " " + base + " " + pos + "/" + npos + " [POSFAIL]"
	else:
		print word + " " + base + " " + pos + " [SUCCESS]"
recfile.close()

