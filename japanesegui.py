#!/usr/bin/env python
# runs the tk gui on spanish.yaml

from kimmo import *
import sys

k = KimmoRuleSet.load('japanese.yaml')
k.gui()

