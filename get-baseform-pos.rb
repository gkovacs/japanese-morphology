#!/usr/bin/ruby1.9
# encoding: utf-8

usedictionary = ARGV.include?("usedictionary")
if usedictionary
	ARGV.delete("usedictionary")
end
reduced = ARGV.include?("reduced")
if reduced
	ARGV.delete("reduced")
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
	if reduced
		system("./generatelexfile.rb usedictionary reduced > japanese-dictionary.lex")
	elsif usedictionary
		system("./generatelexfile.rb usedictionary > japanese-dictionary.lex")
	else
		system("./generatelexfile.rb > japanese-dictionary.lex")
	end
end
system("cat japanese-rules.lex japanese-dictionary.lex > japanese.lex")
#system("./generateyamlfile.rb > japanese.yaml")
if corpus
	system("./get-baseform-pos.py corpus")
elsif passedword == ""
	system("./get-baseform-pos.py")
else
	system("./get-baseform-pos.py #{passedword}")
end

