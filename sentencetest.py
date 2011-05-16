#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
reload(sys)
sys.setdefaultencoding('utf-8')
import codecs
from kimmo import *
import itertools
from wordglossing import *

punctuation = ["。", "？", "、", "「", "」", "・"]

def splitbypunctuation(sen):
	for y in punctuation:
		sen = sen.replace(y, " ")
	presplit = sen.split(" ")
	if "" in presplit:
		presplit.remove("")
	return presplit

def covering(sen, covering):
	covered = [False for x in sen]
	for offset,length in covering:
		for i in range(offset, offset+length):
			if covered[i]:
				return None # not a valid covering
			else:
				covered[i] = True
	return covered

def coveringcost(sen, covered):
	return sum([int(not x) for x in covered])

def allsubsets(x):
	lx = len(x)
	return [[y for j, y in enumerate(x) if (i >> j) & 1] for i in range(2**lx)]

def getgloss(k, word):
	baseform,pos,otherfeatures = get_base_pos_gloss_memoized(k, word)
	if baseform == None or pos == None or otherfeatures == None:
		return
	return "BASE:" + baseform + " POS:" + pos + " " + " ".join(otherfeatures)

def segmentsentence(k, sentence):
	possiblewords = []
	for length in range(1, min(len(sentence)+1, 10)):
		for offset in range(0, len(sentence)-length+1):
			fragment = sentence[offset:offset+length]
			if getgloss(k, fragment) != None:
				possiblewords.append((offset, length))
	possiblesubsets = allsubsets(possiblewords)
	bestrange = None
	bestcost = sys.maxint
	bestcovering = None
	for x in possiblesubsets:
		cv = covering(sentence, x)
		if cv == None:
			continue
		cost = coveringcost(sentence, cv)
		if cost < bestcost or (cost == bestcost and len(x) < len(bestrange)):
			bestcost = cost
			bestrange = x
			bestcovering = cv
	if bestrange == None:
		return
	print bestcost
	print bestrange
	bestrange.sort()
	curidx = 0
	currangeidx = 0
	glossed = []
	while curidx < len(sentence):
		if currangeidx < len(bestrange) and curidx == bestrange[currangeidx][0]:
			word = sentence[curidx:curidx+bestrange[currangeidx][1]]
			glossed.append((word,getgloss(k, word)))
			curidx += bestrange[currangeidx][1]
			currangeidx += 1
			continue
		word = sentence[curidx]
		glossed.append((word,"!UNKNOWN"))
		curidx += 1
	return glossed,bestcost

def analyzeSentence(k, sentence):
	print "===SENTENCE===" + sentence
	totalcost = 0
	for fragment in splitbypunctuation(sentence):
		gloss,cost = segmentsentence(k, fragment)
		totalcost += cost
		for x in gloss:
			print listtostr(x)
	print "~~~COST~~~" + str(totalcost)
	return totalcost

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

