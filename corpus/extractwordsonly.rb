#!/usr/bin/ruby1.9
# encoding: utf-8

printing = false
ARGF.each { |line|
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

