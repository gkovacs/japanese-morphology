#!/usr/bin/ruby1.9
# encoding: utf-8

numsents = `cat ../corpus/extracted-corpus-prefixsuffixmerged.txt  | grep "===SENTENCE" | wc -l`.to_i
allresults = `../pcat.rb *.swb | grep "===STAT" | grep "~COMPL~" | sort | uniq`.split("\n")
totalB = 0
misB = 0
supfB = 0
0.upto(numsents-1) { |sentnum|
	cur = allresults[sentnum]
	if cur == nil
		puts "ERROR: missing #{sentnum}"
		exit(0)
	end
	stat,num,total,mis,supf,compl = cur.split(" ")
	num = num.to_i
	if num != sentnum
		puts "ERROR: missing #{sentnum}"
		exit(0)
	end
	total = total.to_i
	mis = mis.to_i
	supf = supf.to_i
	totalB += total
	misB += mis
	supfB += supf
}
puts "total: #{totalB}"
puts "missed: #{misB}"
puts "superfluous: #{supfB}"
puts "accuracy: #{((totalB-(misB+supfB))*100.0/totalB).round}%"
