#!/usr/bin/ruby1.9
# encoding: utf-8

$LOAD_PATH << File.join(File.expand_path(File.dirname(__FILE__)), '..')
require 'typelists.rb'
require 'set'

fileName = ARGV[0]
baseFileName = fileName
if baseFileName.include?("/")
	baseFileName = baseFileName[baseFileName.rindex("/")+1..baseFileName.length]
end
repverbatim = true
$pConjugated = ""
$pBaseform = ""
$pPos = ""

def printAndClear()
	if $pConjugated != ""
		puts "#{$pConjugated} #{$pBaseform} #{$pPos}"
	end
	$pConjugated = ""
	$pBaseform = ""
	$pPos = ""
end

conjsuffix = Set.new ["ない", "ます", "しまう", "いる", "みる", "うる", "える", "なる", "れる"]

File.open(fileName).each { |line|
	if line.include?("===WORDS")
		printAndClear()
		puts line
		repverbatim = false
		next
	end
	if line.include?("===SENTENCE")
		printAndClear()
		puts line
		repverbatim = true
		next
	end
	if repverbatim
		puts line
		next
	end
	conjugated,baseform,pos = line.split(" ")
	if pos == "Suffix" && $pConjugated.length > 0 && allnum.include?($pConjugated[0])
		$pConjugated += conjugated
		$pBaseform += baseform
		next
	elsif pos == "Suffix" && conjsuffix.include?(baseform)
		$pConjugated += conjugated
		next
	else
		printAndClear()
		$pConjugated = conjugated
		$pBaseform = baseform
		$pPos = pos
		next
	end
	
}
printAndClear()

