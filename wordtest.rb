#!/usr/bin/ruby1.9
# encoding: utf-8

usedictionary = ARGV.include?("usedictionary")
if usedictionary
	ARGV.delete("usedictionary")
end
noregen = ARGV.include?("noregen")
if noregen
	ARGV.delete("noregen")
end
corpus = ARGV.include?("corpus")
if corpus
	ARGV.delete("corpus")
end
passedword = ""
if ARGV.length > 0
	passedword = ARGV[0]
end
if !noregen
	if usedictionary
		system("./generatelexfile.rb usedictionary > japanese-dictionary.lex")
	else
		system("./generatelexfile.rb > japanese-dictionary.lex")
	end
end
system("cat japanese-rules.lex japanese-dictionary.lex japanese-auxiliary.lex > japanese.lex")
#system("./generateyamlfile.rb > japanese.yaml")
if corpus
	system("./wordtest.py corpus")
elsif passedword == ""
	system("./wordtest.py")
else
	system("./wordtest.py #{passedword}")
end

