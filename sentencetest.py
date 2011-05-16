#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
reload(sys)
sys.setdefaultencoding('utf-8')
import codecs
from kimmo import *
import itertools
from sentenceglossing import *

def analyzeSentence(k, sentence):
	print "===SENTENCE===" + sentence
	totalcost = 0
	wordslist = []
	for fragment in splitbypunctuation(sentence):
		gloss,cost = segmentsentence(k, fragment)
		totalcost += cost
		for x in gloss:
			wordslist.append(x[0])
			print listtostr(x)
	print "~~~COST~~~" + str(totalcost)
	return wordslist

def main():
	k = KimmoRuleSet.load('japanese.yaml')
	if len(sys.argv) >= 2:
		analyzeSentence(k, sys.argv[1].strip().decode("utf-8"))
	else:
		senfile = codecs.open('japanese-sentences.txt', encoding='utf-8')
		for line in senfile:
			line = line.strip()
			if line == "":
				continue
			analyzeSentence(k, line)

if __name__ == "__main__":
	main()

