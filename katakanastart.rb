#!/usr/bin/ruby1.9
# encoding: utf-8

$LOAD_PATH << File.join(File.expand_path(File.dirname(__FILE__)), '.')
require 'typelists.rb'

ARGF.each { |line|
	if katakana.include?(line[0..0])
		puts line
	end
}

