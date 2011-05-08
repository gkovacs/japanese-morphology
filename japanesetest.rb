#!/usr/bin/ruby1.9
# encoding: utf-8

usedictionary = ARGV.include?("usedictionary")
noregen = ARGV.include?("noregen")
if !noregen
	if usedictionary
		system("./generatelexfile.rb usedictionary > japanese-dictionary.lex")
	else
		system("./generatelexfile.rb > japanese-dictionary.lex")
	end
end
system("cat japanese-rules.lex japanese-dictionary.lex > japanese.lex")
system("./generateyamlfile.rb > japanese.yaml")
system("./japanesetest.py")

