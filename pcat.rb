#!/usr/bin/ruby1.9
# encoding: utf-8

ARGF.each { |line|
	if line[line.length-1] == "\n"
		puts line
	end
}

