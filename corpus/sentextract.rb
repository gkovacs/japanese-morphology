#!/usr/bin/ruby1.9
# encoding: utf-8

$LOAD_PATH << File.join(File.expand_path(File.dirname(__FILE__)), '..')
require 'typelists.rb'

fileName = ARGV[0]
baseFileName = fileName
if baseFileName.include?("/")
	baseFileName = baseFileName[baseFileName.rindex("/")+1..baseFileName.length]
end
skip = false
skippedchars = ["*", "+", "#", "’", "　"]
replacement = {"ぁ" => "あ", "ぃ" => "い", "ぇ" => "え", "ぅ" => "う", "ぉ" => "お"}
words = []
posMapping = {"名詞" => "Noun", "動詞" => "Verb", "形容詞" => "Adjective", "指示詞" => "Demonstrative", "助動詞" => "AuxillaryVerb", "連体詞" => "PreNounAdjectival", "接尾辞" => "Suffix", "副詞" => "Adverb", "助詞" => "Particle", "判定詞" => "Decision", "接続詞" => "Conjunction", "特殊" => "Special", "接頭辞" => "Prefix", "感動詞" => "Interjection", "未定義語" => "Undefined"}
bannedchars = romaji + ["д", "∀"]
File.open(fileName).each { |line|
	if line[0] == "［"
		skip = true
		next
	end
	if line[0] == "］"
		skip = false
		next
	end
	if skip || skippedchars.include?(line[0]) || line.strip == "EOS"
		next
	end
	spl = line.split(" ")
	spl.delete("")
	conjugated = spl[0]
	baseform = spl[2]
	pos = spl[3]
	if bannedchars.map{|x| conjugated == nil || baseform == nil || pos == nil || conjugated.include?(x) || baseform.include?(x) || pos.include?(x)}.include?(true) # filter out URLs and mathematical equations
		puts "===BANNED:#{conjugated} #{baseform} #{pos} #{baseFileName}"
		exit(0)
	end
	replacement.each { |k,v|
		conjugated = conjugated.sub(k, v)
		baseform = baseform.sub(k, v)
	}
	epos = posMapping[pos]
	if epos == nil
		puts "===ERROR:#{conjugated} #{baseform} #{pos} #{baseFileName}"
		exit(0)
	end
	if epos == "Adjective"
		if baseform[baseform.length-1] == "だ"
			epos = "NaAdjective"
		elsif baseform[baseform.length-1] == "い"
			epos = "IAdjective"
		elsif baseform[baseform.length-1] == "る"
			epos = "TaruAdjective"
		else
			epos = "UnknownAdjective"
		end
	end
	words.push([conjugated, baseform, epos])
}
if words.length == 0
	puts "===BANNED:LACKSWORDS #{baseFileName}"
	exit(0)
end
puts "===SENTENCE:#{baseFileName}"
puts words.map{|x| x[0]}.join("")
puts "===WORDS:#{baseFileName}"
words.each { |conjugated, baseform, pos|
	if punctuation.include?(conjugated)
		next
	end
	puts conjugated + " " + baseform + " " + pos
}

