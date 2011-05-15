#!/usr/bin/ruby1.9
# encoding: utf-8

fileName = ARGV[0]
baseFileName = fileName
if baseFileName.include?("/")
	baseFileName = baseFileName[baseFileName.rindex("/")+1..baseFileName.length]
end
printing = false
File.open(fileName).each { |line|
	if line.include?("===WORDS")
		printing = true
		next
	elsif line.include?("===SENTENCE")
		printing = false
		next
	end
	if printing
		puts line
	end
}

