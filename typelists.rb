#!/usr/bin/ruby1.9
# encoding: utf-8

$Lpunctuation = ["。", "？", "、", "「", "」", "／", "◎", "．", "．．．", "・", "・・", "・・・", "・・・・", "・・・・・", "………", "……", "（", "）", "！", "＆", "“", "…", "…………", "？？", "？？？", "！！", "！！！", "！！！！", "！！！！！", "！！！！！！！！", "、、", "、、、", "、、、、", "、、、、、、、、", "、、、、、、", "、、、、、、", "、、、、、、、、", "・・・・", "〇〇", "○○", "●●", "★", "★★", "★★★", "★★★★", "★★★★★", "☆", "☆☆", "☆☆☆", "☆☆☆☆", "☆☆☆☆☆", "—", "〜", "，", "。。", "。。。", "。。。。", "。。。。。", "♪", "♪♪", "♪♪♪", "♪♪♪♪", "♪♪♪♪♪", "『", "』", "”", "：", "＜", "＜＜", "＜＜＜", "＞", "＞＞", "＞＞＞", "←", "→", "＋", "↑", "↑↑", "↓", "↓↓", "−", "−−−", "＝", "×", "××", "〓", "〓〓", "〓〓〓", "■", "■■", "■■■", "（＞◆＜）", "＋＿＋", "（＾＾；）", "（＊＾−＾＊）", "（＞▽＜）", "＾＾；", "（＾□＾；）", "＾＾", "（−＿−；）", "＾＾；）", "（＞＜）", "＞＜"]

$Larabnum = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "０", "１", "２", "３", "４", "５", "６", "７", "８", "９"]

$Lromaji = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "ａ", "ｂ", "ｃ", "ｄ", "ｅ", "ｆ", "ｇ", "ｈ", "ｉ", "ｊ", "ｋ", "ｌ", "ｍ", "ｎ", "ｏ", "ｐ", "ｑ", "ｒ", "ｓ", "ｔ", "ｕ", "ｖ", "ｗ", "ｘ", "ｙ", "ｚ", "Ａ", "Ｂ", "Ｃ", "Ｄ", "Ｅ", "Ｆ", "Ｇ", "Ｈ", "Ｉ", "Ｊ", "Ｋ", "Ｌ", "Ｍ", "Ｎ", "Ｏ", "Ｐ", "Ｑ", "Ｒ", "Ｓ", "Ｔ", "Ｕ", "Ｖ", "Ｗ", "Ｘ", "Ｙ", "Ｚ"]

$Lhiragana = ["ぁ", "あ", "ぃ", "い", "ぅ", "う", "ぇ", "え", "ぉ", "お", "か", "が", "き", "ぎ", "く ぐ", "け", "げ", "こ", "ご", "さ", "ざ", "し", "じ", "す", "ず", "せ", "ぜ", "そ", "ぞ", "た だ", "ち", "ぢ", "っ", "つ", "づ", "て で", "と", "ど", "な", "に", "ぬ", "ね", "の", "は ば", "ぱ", "ひ", "び", "ぴ", "ふ", "ぶ", "ぷ", "へ", "べ", "ぺ", "ほ", "ぼ", "ぽ", "ま", "み む", "め", "も", "ゃ", "や", "ゅ", "ゆ", "ょ", "よ", "ら", "り", "る", "れ", "ろ", "ゎ", "わ ゐ", "ゑ", "を", "ん", "ゔ", "ゕ", "ゖ", "ゝ", "ゞ", "ゟ"]

def punctuation
	return $Lpunctuation
end

def arabnum
	return $Larabnum
end

def romaji
	return $Lromaji
end

def hiragana
	return $Lhiragana
end
