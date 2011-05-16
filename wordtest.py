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

def printWordGloss(k, passedword):
	baseform,pos,otherfeatures = get_base_pos_gloss(k, line)
	if baseform == None or pos == None or otherfeatures == None:
		print passedword + " [FAILURE]"
	else:
		print passedword + " BASE:" + baseform + " POS:" + pos + " " + " ".join(otherfeatures)

k = KimmoRuleSet.load('japanese.yaml')
if passedword != "":
	printWordGloss(k, passedword)
	exit(0)

recfile = codecs.open(wordcorpusfn, encoding='utf-8')
for line in recfile:
	line = line.strip()
	if not line: continue
	if line.startswith(';'):
		print line
		continue
	if " " in line:
		line = line.split(" ")[0]
	printWordGloss(k, line)

recfile.close()

