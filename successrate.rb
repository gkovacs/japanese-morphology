#!/usr/bin/ruby1.9
# encoding: utf-8

success = 0
failure = 0
posfail = 0
bpfail = 0

ARGF.each { |line|
	if line.include?("[SUCCESS]")
		success += 1
	elsif line.include?("[POSFAIL]")
		posfail += 1
	elsif line.include?("[BPFAIL]")
		bpfail += 1
	elsif line.include?("[FAILURE]")
		failure += 1
	end
}

total = success+failure+posfail+bpfail
printme = -> v {"#{v} (#{(v*100/total)}%)"}
puts "total w: #{total}"
puts "success: #{printme.(success)}"
puts "failure: #{printme.(failure)}"
puts "posfail: #{printme.(posfail)}"
puts "bpfail:  #{printme.(bpfail)}"
