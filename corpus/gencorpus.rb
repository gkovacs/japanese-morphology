#!/usr/bin/ruby1.9

Dir.chdir("orig")
filenames = `ls KN*`.split("\n")
banned = []
successful = []
filenames.each {|fn|
	output = `../sentextract.rb #{fn}`
	if output.include?("===BANNED")
		banned.push(output)
	else
		successful.push(output)
	end
}
Dir.chdir("..")
File.delete("extracted-raw-corpus.txt")
File.delete("extracted-raw-corpus-banned.txt")
File.open("extracted-raw-corpus.txt", "w") {|f|
	f.puts(successful.join(""))
}
File.open("extracted-raw-corpus-banned.txt", "w") {|f|
	f.puts(banned.join(""))
}

#system("./corpus-setup.sh")
