#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
reload(sys)
sys.setdefaultencoding('utf-8')
import codecs
from kimmo import *
import itertools

def listtostr(l):
	if type(l) == type([]):
		return "[" + (",".join([listtostr(x) for x in l])) + "]"
	elif type(l) == type((3,2)):
		return "(" + ",".join([listtostr(x) for x in l]) + ")"
	else:
		return l

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

possiblewords = []
k = KimmoRuleSet.load('japanese.yaml')
sentence = sys.argv[1].strip().decode("utf-8")
for length in range(1, min(len(sentence)+1, 10)):
	for offset in range(0, len(sentence)-length+1):
		fragment = sentence[offset:offset+length]
		featurelog = TextTrace(0)
		k.recognize(fragment, featurelog)
		success = False
		for feat in featurelog.features:
			if "SUCCESS" in feat:
				success = True
				print fragment
				feat.remove("SUCCESS")
				print " ".join(feat[::-1]),
		if success:
			print ""
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
    if cost < bestcost:
        bestcost = cost
        bestrange = x
        bestcovering = cv
if bestrange == None:
	exit(0)
print bestcost
print bestrange
curidx = 0
currangeidx = 0
while curidx < len(sentence):
	if currangeidx < len(bestrange) and curidx == bestrange[currangeidx][0]:
	    print sentence[curidx:curidx+bestrange[currangeidx][1]]
	    curidx += bestrange[currangeidx][1]
	    currangeidx += 1
	    continue
	print sentence[curidx], "unknown"
	curidx += 1

#print sentence
'''
k = KimmoRuleSet.load('japanese.yaml')
recfile = codecs.open('japanese.rec', encoding='utf-8')
for line in recfile:
	line = line.strip()
	if not line: continue
	if line.startswith(';'):
		print line
		continue
	featurelog = TextTrace(0)
	#print listtostr(k.recognize(line, featurelog)), '<=', line
	k.recognize(line, featurelog)
	print line,
	success = False
	for feat in featurelog.features:
		if "SUCCESS" in feat:
			success = True
			feat.remove("SUCCESS")
			print " ".join(feat[::-1]),
	if not success:
		print "[FAILURE]"
	else:
		print ""
	#print log

recfile.close()
'''
