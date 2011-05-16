#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
reload(sys)
sys.setdefaultencoding('utf-8')
from wordglossing import *

punctuation = ["。", "？", "、", "「", "」", "／", "◎", "．．．", "・", "・・", "・・・", "・・・・", "・・・・・", "………", "……", "（", "）", "！", "＆", "“", "…", "…………", "？？", "？？？", "！！", "！！！", "！！！！", "！！！！！", "！！！！！！！！", "、、", "、、、", "、、、、", "、、、、、、、、", "、、、、、、", "、、、、、、", "、、、、、、、、", "・・・・", "！！！！！！", "！！！！！！！！！！！！", "＊", "≒", "〇", "〇〇", "○", "○○", "●", "●●", "★", "★★", "★★★", "★★★★", "★★★★★", "☆", "☆☆", "☆☆☆", "☆☆☆☆", "☆☆☆☆☆", "—", "〜", "，", "。。", "。。。", "。。。。", "。。。。。", "♪", "♪♪", "♪♪♪", "♪♪♪♪", "♪♪♪♪♪", "『", "』", "”", "：", "＜", "＜＜", "＜＜＜", "＞", "＞＞", "＞＞＞", "←", "→", "＋", "↑", "↑↑", "↓", "↓↓", "−", "−−−", "＝", "×", "××", "〓", "〓〓", "〓〓〓", "■", "■■", "■■■", "（＞◆＜）", "＋＿＋", "（＾＾；）", "（＊＾−＾＊）", "（＞▽＜）", "＾＾；", "（＾□＾；）", "＾＾", "（−＿−；）", "＾＾；）", "（＞＜）", "＞＜"]

arabnum = frozenset(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "０", "１", "２", "３", "４", "５", "６", "７", "８", "９"])

def listtostr(l):
	if type(l) == type([]):
		return "[" + (",".join([listtostr(x) for x in l])) + "]"
	elif type(l) == type((3,2)):
		return "(" + ",".join([listtostr(x) for x in l]) + ")"
	else:
		return l

def splitbypunctuation(sen):
	for y in punctuation:
		sen = sen.replace(y, " ")
	nsen = []
	for i in range(len(sen)):
		c = sen[i]
		nextc = ""
		if i+1 < len(sen):
			nextc = sen[i+1]
		if c == "．" and (nextc not in arabnum):
			nsen.append(" ")
		else:
			nsen.append(c)
	sen = "".join(nsen)
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

def getgloss(k, word):
	baseform,pos,otherfeatures = get_base_pos_gloss_memoized(k, word)
	if baseform == None or pos == None or otherfeatures == None:
		return ""
	return "BASE:" + baseform + " POS:" + pos + " " + " ".join(otherfeatures)

def maxidx(l):
	return -max((v,-i) for i,v in enumerate(l))[1]

def mostoccupiedidx(sentence, possiblewords):
	occupancy = [0]*len(sentence)
	for offset,length in possiblewords:
		for i in range(offset, offset+length):
			occupancy[i] += 1
	return maxidx(occupancy)

def segmentsentence(k, sentence):
	possiblewords = []
	for length in range(1, min(len(sentence)+1, 8)):
		for offset in range(0, len(sentence)-length+1):
			fragment = sentence[offset:offset+length]
			if getgloss(k, fragment) != "":
				possiblewords.append((offset, length))
	while len(possiblewords) > 19:
		rmfromidx = mostoccupiedidx(sentence, possiblewords)
		for i in range(len(possiblewords)):
			firstidx = possiblewords[i][0]
			endidx = firstidx + possiblewords[i][1]
			if firstidx <= rmfromidx < endidx:
				del possiblewords[i]
				break
	bestrange = None
	bestcost = sys.maxint
	bestcovering = None
	for i in xrange(2**len(possiblewords)):
		cursubset = [y for j, y in enumerate(possiblewords) if (i >> j) & 1]
		cv = covering(sentence, cursubset)
		if cv == None:
			continue
		cost = coveringcost(sentence, cv)
		if cost < bestcost:
			bestcost = cost
			bestrange = cursubset
			bestcovering = cv
		elif cost == bestcost:
			if len(cursubset) < len(bestrange):
				bestcost = cost
				bestrange = cursubset
				bestcovering = cv
	if bestrange == None:
		return
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
		unknownend = len(sentence)
		if currangeidx < len(bestrange):
			unknownend = bestrange[currangeidx][0]
		word = sentence[curidx:unknownend]
		glossed.append((word,"!UNKNOWN"))
		curidx += len(word)
	return glossed,bestcost

def get_words_in_sentence_fragments(k, fragments):
	wordslist = []
	for fragment in fragments:
		gloss,cost = segmentsentence(k, fragment)
		for x in gloss:
			wordslist.append(x[0])
	return wordslist

def get_words_in_sentence(k, sentence):
	return get_words_in_sentence_fragments(k, splitbypunctuation(sentence))

