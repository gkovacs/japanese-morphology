#!/usr/bin/ruby1.9
# encoding: utf-8

$LOAD_PATH << File.join(File.expand_path(File.dirname(__FILE__)), '.')
require 'typelists.rb'
require 'successrate.rb'

def printPerPOSSuccessRate(inputLines)
	partsOfSpeech.each { |pos|
		puts "==="+pos
		printSuccessRate(inputLines.select {|x| x.include?(pos) } )
		puts ""
	}
end

if __FILE__ == $0
	inputLines = []
	ARGF.each { |line| inputLines.push(line) }
	printPerPOSSuccessRate(inputLines)
end

