#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
reload(sys)
sys.setdefaultencoding('utf-8')
import codecs
from kimmo import *
import itertools
from sentenceglossing import *

def wordboundaries(wordslist, sentence):
	iwl = 0
	boundaries = set()
	for i in range(len(sentence)):
		if iwl >= len(wordslist):
			boundaries.add(len(sentence))
			break
		else:
			curword = wordslist[iwl]
			if sentence[i:i+len(curword)] == curword:
				boundaries.add(i)
				boundaries.add(i+len(curword))
				i += len(curword)
				iwl += 1
	return boundaries

def sentences_and_words(lines):
	sentw = []
	curwords = []
	cursentence = None
	expectsentence = False
	for line in lines:
		line = line.strip()
		if "===SENTENCE" in line:
			if cursentence == None:
				curwords = []
			else:
				sentw.append((cursentence, curwords))
				curwords = []
				cursentence = None
			expectsentence = True
		elif "===WORDS" in line:
			assert (not expectsentence)
		elif expectsentence:
			cursentence = line
			expectsentence = False
		else:
			conjform,baseform,pos = line.split(" ")
			curwords.append(conjform)
	if cursentence != None:
		sentw.append((cursentence, curwords))
	return sentw

def main():
	k = KimmoRuleSet.load('japanese.yaml')
	if len(sys.argv) >= 2:
		passedsen = sys.argv[1].strip().decode("utf-8")
		wordboundaries(get_words_in_sentence(k, passedsen), passedsen)
	else:
		senfile = codecs.open('corpus/extracted-raw-corpus.txt', encoding='utf-8')
		sentw = sentences_and_words(senfile.readlines())
		totalB = 0
		superfluousB = 0
		missingB = 0
		for i in range(len(sentw)):
			sentence,words = sentw[i]
			print sentence
			refboundaries = wordboundaries(words, sentence)
			mywords = get_words_in_sentence(k, sentence)
			myboundaries = wordboundaries(mywords, sentence)
			print listtostr(words)
			print listtostr(mywords)
			print sorted(list(refboundaries))
			print sorted(list(myboundaries))
			totalL = len(refboundaries)
			missingL = 0
			superfluousL = 0
			for x in refboundaries:
				if x not in myboundaries:
					missingL += 1
			for x in myboundaries:
				if x not in refboundaries:
					superfluousL += 1
			print "===STAT", i, totalL, missingL, superfluousL
			totalB += totalL
			missingB += missingL
			superfluousB += superfluousL
			print i, "of", len(sentw), "total", totalB, "mis", missingB, "supf", superfluousB

if __name__ == "__main__":
	main()

