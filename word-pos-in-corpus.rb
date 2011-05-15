#!/usr/bin/ruby1.9
# encoding: utf-8

$LOAD_PATH << File.join(File.expand_path(File.dirname(__FILE__)), '.')
require 'typelists.rb'

word = ARGV[0]

posCounts = {}
partsOfSpeech.each { |pos| posCounts[pos] = 0 }
File.open("corpus/corpus-allwords-base-pos.txt").each { |line|
	spl = line.split(" ")
	baseform = spl[1]
	if baseform != word
		next
	end
	pos = spl[2]
	posCounts[pos] += 1
}
maxcount = 0
bestpos = ""
posCounts.each { |pos,count|
	if count > maxcount
		bestpos = pos
		maxcount = count
	end
}
puts bestpos

