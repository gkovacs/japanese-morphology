#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
reload(sys)
sys.setdefaultencoding('utf-8')
from kimmo import *

def get_base_pos_gloss(k, word):
	featurelog = TextTrace(0)
	k.recognize(word, featurelog)
	success = False
	baseform = ""
	pos = ""
	newbaseform = False
	newpos = False
	otherfeatures = []
	for feat in featurelog.features:
		if "SUCCESS" in feat:
			success = True
			feat.remove("SUCCESS")
			for z in feat:
				if z[:5] == "BASE:" and not newbaseform:
					baseform = z[5:]
				elif z[:4] == "POS:" and not newpos:
					pos = z[4:]
				elif z[:8] == "NEWBASE:" and not newbaseform:
					baseform = z[8:]
					newbaseform = True
				elif z[:7] == "NEWPOS:" and not newpos:
					pos = z[:7]
					newpos = True
				else:
					otherfeatures.append(z)
	otherfeatures.reverse()
	if pos == "Number":
		baseform = word
		pos = "Noun"
	if not success:
		return None, None, None
	else:
		return baseform, pos, otherfeatures

resmemo1 = {}
resmemo2 = {}

def get_base_pos_memoized(k, word):
	global resmomo
	if word in resmemo1:
		return resmemo1[word]
	tmpres1,tmpres2,tmpres3 = get_base_pos_gloss(k, word)
	resmemo1[word] = tmpres1,tmpres2
	return tmpres1,tmpres2

def get_base_pos_gloss_memoized(k, word):
	global resmomo
	if word in resmemo2:
		return resmemo2[word]
	tmpres = get_base_pos_gloss(k, word)
	resmemo2[word] = tmpres
	return tmpres

def listtostr(l):
	if type(l) == type([]):
		return "[" + (",".join([listtostr(x) for x in l])) + "]"
	elif type(l) == type((3,2)):
		return "(" + ",".join([listtostr(x) for x in l]) + ")"
	else:
		return l

