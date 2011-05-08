#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
reload(sys)
sys.setdefaultencoding('utf-8')
import codecs
from kimmo import *

def listtostr(l):
	if type(l) == type([]):
		return "[" + (",".join([listtostr(x) for x in l])) + "]"
	elif type(l) == type((3,2)):
		return "(" + ",".join([listtostr(x) for x in l]) + ")"
	else:
		return l

k = KimmoRuleSet.load('japanese.yaml')
recfile = codecs.open('japanese-words.txt', encoding='utf-8')
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

