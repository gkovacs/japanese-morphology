#!/usr/bin/ruby1.9
# encoding: utf-8

$LOAD_PATH << File.join(File.expand_path(File.dirname(__FILE__)), '.')
require 'typelists.rb'

word = ARGV[0]

posCounts = {}
partsOfSpeech.each { |pos| posCounts[pos] = {} }
File.open("corpus/corpus-allwords-base-pos.txt").each { |line|
	spl = line.split(" ")
	conjform = spl[0]
	if conjform != word
		next
	end
	baseform = spl[1]
	pos = spl[2]
	if !posCounts[pos].include?(baseform)
		posCounts[pos][baseform] = 0
	end
	posCounts[pos][baseform] += 1
}
counts = []
posCounts.each { |pos,bfcount|
	bfcount.each { |baseform,count|
		counts.push([count, baseform, pos])
	}
}
counts.sort! {|a,b| b[0] <=> a[0] }
counts.each { |count, baseform, pos|
	puts baseform + " " + pos + " " + count.to_s
}
