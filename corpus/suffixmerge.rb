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

conjsuffix = Set.new ["ない", "ます", "しまう", "いる", "みる", "うる", "える", "なる", "れる", "おく", "たい", "ほしい", "られる", "せる", "そうだ", "くれる", "あげる", "もらう", "すぎる", "やすい", "にくい", "ある", "る", "する", "的だ"]
changepos = {}

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
	elsif pos == "Suffix" && $pPos != "Particle" && conjsuffix.include?(baseform)
		$pConjugated += conjugated
		next
	elsif pos == "Suffix" && changepos.include?(baseform)
		printAndClear()
		$pConjugated = conjugated
		$pBaseform = baseform
		$pPos = changepos[baseform]
	else
		printAndClear()
		$pConjugated = conjugated
		$pBaseform = baseform
		$pPos = pos
		next
	end
	
}
printAndClear()

