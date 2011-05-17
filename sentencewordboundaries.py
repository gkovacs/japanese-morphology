#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
reload(sys)
sys.setdefaultencoding('utf-8')
import codecs
from kimmo import *
import itertools
from sentenceglossing import *

def main():
	k = KimmoRuleSet.load('japanese.yaml')
	if len(sys.argv) >= 2:
		passedsen = sys.argv[1].strip().decode("utf-8")
		words = get_words_in_sentence(k, passedsen)
		print listtostr(words)
		print sorted(list(wordboundaries(words, passedsen)))
	else:
		senfile = codecs.open('corpus/extracted-corpus-prefixsuffixmerged.txt', encoding='utf-8')
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
			print "===STAT", str(i).rjust(4, "0"), totalL, missingL, superfluousL, "~COMPL~"
			totalB += totalL
			missingB += missingL
			superfluousB += superfluousL
			print i, "of", len(sentw), "total", totalB, "mis", missingB, "supf", superfluousB

if __name__ == "__main__":
	main()

