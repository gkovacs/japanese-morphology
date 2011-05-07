#!/usr/bin/ruby1.9
# encoding: utf-8

system("./generatelexfile.rb > japanese.lex")
system("./generateyamlfile.rb > japanese.yaml")
system("./japanesetest.py")
