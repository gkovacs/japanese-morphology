#!/usr/bin/ruby1.9
# encoding: utf-8

$LOAD_PATH << File.join(File.expand_path(File.dirname(__FILE__)), '..')
require 'typelists.rb'
require 'set'

repverbatim = true
$pPrefix = ""

def printAndClear()
	if $pPrefix != ""
		puts "#{pPrefix} #{pPrefix} Prefix"
	end
	$pPrefix = ""
end

prefixes = Set.new ["お", "ご", "御"]

ARGF.each { |line|
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
	if pos == "Prefix" && prefixes.include?(baseform)
		$pPrefix += conjugated
		next
	else
		puts "#{$pPrefix+conjugated} #{baseform} #{pos}"
		$pPrefix = ""
		next
	end
	
}
printAndClear()

