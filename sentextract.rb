#!/usr/bin/ruby1.9
# encoding: utf-8

fileName = ARGV[0]
baseFileName = fileName
if baseFileName.include?("/")
	baseFileName = baseFileName[baseFileName.rindex("/")+1..baseFileName.length]
end
skip = false
skippedchars = ["*", "+", "#", "’", "　"]
punctuation = ["。", "、"]
words = []
posMapping = {"名詞" => "Noun", "動詞" => "Verb", "形容詞" => "IAdjective", "指示詞" => "Demonstrative", "助動詞" => "AuxillaryVerb", "連体詞" => "PreNounAdjectival", "接尾辞" => "Suffix", "副詞" => "Adverb", "助詞" => "Particle", "判定詞" => "Decision", "接続詞" => "Conjunction", "特殊" => "Special", "接頭辞" => "Prefix", "感動詞" => "Interjection", "未定義語" => "Undefined"}
bannedchars = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "ａ", "ｂ", "ｃ", "ｄ", "ｅ", "ｆ", "ｇ", "ｈ", "ｉ", "ｊ", "ｋ", "ｌ", "ｍ", "ｎ", "ｏ", "ｐ", "ｑ", "ｒ", "ｓ", "ｔ", "ｕ", "ｖ", "ｗ", "ｘ", "ｙ", "ｚ", "Ａ", "Ｂ", "Ｃ", "Ｄ", "Ｅ", "Ｆ", "Ｇ", "Ｈ", "Ｉ", "Ｊ", "Ｋ", "Ｌ", "Ｍ", "Ｎ", "Ｏ", "Ｐ", "Ｑ", "Ｒ", "Ｓ", "Ｔ", "Ｕ", "Ｖ", "Ｗ", "Ｘ", "Ｙ", "Ｚ", "д", "∀"]
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
	epos = posMapping[pos]
	if epos == nil
		puts "===ERROR:#{conjugated} #{baseform} #{pos} #{baseFileName}"
		exit(0)
	end
	words.push([conjugated, baseform, epos])
}
puts "===SENTENCE:#{baseFileName}"
puts words.map{|x| x[0]}.join("")
puts "===WORDS:#{baseFileName}"
words.each { |conjugated, baseform, pos|
	if punctuation.include?(conjugated)
		next
	end
	puts conjugated + " " + baseform + " " + pos
}

