#!/usr/bin/ruby1.9
# encoding: utf-8

$LOAD_PATH << File.join(File.expand_path(File.dirname(__FILE__)), '.')
require 'typelists.rb'

katakana = []

kanji = []

File.open("japanese-words.txt", "r") { |f|
    while line = f.gets()
        line.strip().each_char { |c|
            if !hiragana.include?(c) and !katakana.include?(c) and !romaji.include?(c) and !kanji.include?(c)
                kanji.push(c)
            end
        }
    end
}

File.open("japanese-sentences.txt", "r") { |f|
    while line = f.gets()
        line.strip().each_char { |c|
            if !hiragana.include?(c) and !katakana.include?(c) and !romaji.include?(c) and !kanji.include?(c)
                kanji.push(c)
            end
        }
    end
}

all = hiragana + katakana + romaji + kanji

generateddocument = <<EOSSTRING
# this is a comment at the top of my spanish.yaml file
boundary: '#'
lexicon: japanese.lex
defaults: "#{all.join(" ")} +:0 #"
subsets:
 "ARABNUM": 0 1 2 3 4 5 6 7 8 9
 "HIRAGANA": #{hiragana.join(" ")}
 "@": "#{all.join(" ")} + # 0"
rules:
  norules:
   start:
    '@': start
EOSSTRING

puts generateddocument
