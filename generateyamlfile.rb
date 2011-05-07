#!/usr/bin/ruby1.9
# encoding: utf-8

arabnum = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

punctuation = ["。", "？", "、", "「", "」", "・"]

romaji = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

hiragana = ["ぁ", "あ", "ぃ", "い", "ぅ", "う", "ぇ", "え", "ぉ", "お", "か", "が", "き", "ぎ", "く ぐ", "け", "げ", "こ", "ご", "さ", "ざ", "し", "じ", "す", "ず", "せ", "ぜ", "そ", "ぞ", "た だ", "ち", "ぢ", "っ", "つ", "づ", "て で", "と", "ど", "な", "に", "ぬ", "ね", "の", "は ば", "ぱ", "ひ", "び", "ぴ", "ふ", "ぶ", "ぷ", "へ", "べ", "ぺ", "ほ", "ぼ", "ぽ", "ま", "み む", "め", "も", "ゃ", "や", "ゅ", "ゆ", "ょ", "よ", "ら", "り", "る", "れ", "ろ", "ゎ", "わ ゐ", "ゑ", "を", "ん", "ゔ", "ゕ", "ゖ", "ゝ", "ゞ", "ゟ"]

katakana = []

kanji = []

File.open("japanese.rec", "r") { |f|
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
