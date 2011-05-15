#!/usr/bin/ruby1.9
# encoding: utf-8

def printSuccessRate(inputLines)
	success = 0
	failure = 0
	posfail = 0
	bpfail = 0
	inputLines.each { |line|
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
	printme = -> v {
		if total == 0
			"0 (0%)"
		else
			"#{v} (#{(v*100/total)}%)"
		end
	}
	puts "total w: #{total}"
	puts "success: #{printme.(success)}"
	puts "failure: #{printme.(failure)}"
	puts "posfail: #{printme.(posfail)}"
	puts "bpfail:  #{printme.(bpfail)}"
end

if __FILE__ == $0
	inputLines = []
	ARGF.each { |line| inputLines.push(line) }
	printSuccessRate(inputLines)
end

