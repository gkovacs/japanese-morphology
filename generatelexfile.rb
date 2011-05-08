#!/usr/bin/ruby1.9
# encoding: utf-8

usedictionary = ARGV.include?("usedictionary")

numbers = {"0" => "0", "1" => "1", "2" => "2", "3" => "3", "4" => "4", "5" => "5", "6" => "6", "7" => "7", "8" => "8", "9" => "9", "０" => "0", "１" => "1", "２" => "2", "３" => "3", "４" => "4", "５" => "5", "６" => "6", "７" => "7", "８" => "8", "９" => "9", "〇" => "0", "零" => "0", "一" => "1", "二" => "2", "三" => "3", "四" => "4", "五" => "5", "六" => "6", "七" => "7", "八" => "8", "九" => "9", "十" => "10", "百" => "100", "千" => "1000", "万" => "10000"}
counters = {"つ" => "generic objects", "個" => "small objects", "人" => "people", "匹" => "small animals", "台" => "machines", "冊" => "books", "本" => "long objects", "枚" => "flat objects",  "足" => "shoes", "杯" => "cups", "頁" => "page", "ページ" => "page", "丁目" => "address", "円" => "yen", "ドル" => "dollars", "セント" => "cents", "歳" => "years of age", "回" => "times", "度" => "degrees", "年" => "year", "月" => "month number", "ヶ月" => "months", "日" => "day", "時" => "hour", "分" => "minute", "秒" => "second"}
nouns = {"漢字" => "kanji", "結婚式" => "wedding ceremony", "日本人" => "Japanese person", "日本語" => "Japanese language", "学生" => "student", "先生" => "teacher", "夏" => "summer", "予約" => "reservation"}
iadjs = {"恥ずかし" => "embarrasing", "広" => "spacious", "面白" => "interesting", "強" => "strong", "寒" => "cold", "難し" => "difficult", "楽し" => "fun"}
naadjs = {"簡単" => "simple", "きれい" => "clean", "好き" => "like", "元気" => "lively", "親切" => "kind"}
ichidanverbs = {"食べ" => "eat", "見" => "see", "覚え" => "remember", "寝" => "sleep", "開け" => "open", "借り" => "borrow", "遅れ" => "be late", "忘れ" => "foget"}
suruverbs = {"結婚" => "get married", "卒業" => "graduate", "勉強" => "study", "予約" => "reserve", "運転" => "drive"}
kuruverbs = {"連れて" => "bring someone along", "持って" => "bring something"}
aruverbs = {"事が" => "has occurred", "ことが" => "has occurred"}
ikuverbs = {"連れて" => "take someone along", "持って" => "carry something away"}
kuverbs = {"歩" => "walk", "書" => "write", "聞" => "listen"}
suverbs = {"話" => "speak", "貸" => "lend"}
uverbs = {"買" => "buy", "手伝" => "assist", "歌" => "sing"}
guverbs = {"泳" => "swim"}
buverbs = {"遊" => "play"}
tsuverbs = {"持" => "carry", "待" => "wait"}
muverbs = {"読" => "read", "飲" => "drink"}
nuverbs = {"死" => "die"}
ruverbs = {"取" => "take", "降" => "fall", "閉ま" => "close"}

def extractparenthesis(sen)
    haveparen = false
    output = []
    parenthesized = []
    sen.each_char { |c|
        if c == "("
            haveparen = true
            parenthesized.push([])
        elsif c == ")"
            haveparen = false
        elsif haveparen
            parenthesized[-1].push(c)
        else
            output.push(c)
        end
    }
    parenthesized = parenthesized.map { |x| x.join("") }
    parenthesized.delete("")
    tags = []
    parenthesized.each { |x|
        x.split(",").each { |y|
            tags.push(y)
        }
    }
    return [output.join(""), tags]
end

if usedictionary
File.open("edict2-utf8", "r") { |f|
    while line = f.gets()
        line = line.strip()
        if line[0..2] == "？？？"
            next
        end
        line,tags = extractparenthesis(line)
        readings = []
        if !line.include?("[")
            kanji = ""
            kana = line[0 .. line.index("/") - 1 ] 
        else
	        kanji = line[0 .. line.index("[") - 1].strip()
	        kana = line[line.index("[")+1 .. line.index("]")-1].strip()
        end
        english = line[line.index("/")+1 .. line.length].strip()
        english = english.split("/")[0]
        kanji.split(";").each { |x|
            readings.push(x.strip())
        }
        kana.split(";").each { |x|
            readings.push(x.strip())
        }
        readings.delete("")
        if readings.length == 0
            next
        end
        if english.length == 0
            next
        end
        if tags.include?("v5k")
            readings.each { |x|
                x = x[0..x.length-2]
                kuverbs[x] = english
            }
        end
        if tags.include?("v5s")
            readings.each { |x|
                x = x[0..x.length-2]
                suverbs[x] = english
            }
        end
        if tags.include?("v5u")
            readings.each { |x|
                x = x[0..x.length-2]
                uverbs[x] = english
            }
        end
        if tags.include?("v5b")
            readings.each { |x|
                x = x[0..x.length-2]
                buverbs[x] = english
            }
        end
        if tags.include?("v5t")
            readings.each { |x|
                x = x[0..x.length-2]
                tsuverbs[x] = english
            }
        end
        if tags.include?("v5m")
            readings.each { |x|
                x = x[0..x.length-2]
                muverbs[x] = english
            }
        end
        if tags.include?("v5n")
            readings.each { |x|
                x = x[0..x.length-2]
                nuverbs[x] = english
            }
        end
        if tags.include?("v5r")
            readings.each { |x|
                x = x[0..x.length-2]
                ruverbs[x] = english
            }
        end
        if tags.include?("v5g")
            readings.each { |x|
                x = x[0..x.length-2]
                guverbs[x] = english
            }
        end
        if tags.include?("v5r-i")
            readings.each { |x|
                x = x[0..x.length-3]
                aruverbs[x] = english
            }
        end
    end
}
end

generateddocument = <<EOSSTRING
NUMBER:
#{
numbers.map {|k,v| k + " NUMBER_SUFFIX " + v}.join("\n")
}

COUNTER:
'' End number
#{
counters.map {|k,v| k + " POSTCOUNTER " + v}.join("\n")
}

NOUN_ROOT:
#{
nouns.map {|k,v| k + " NOUN_SUFFIX Noun(" + v + ")"}.join("\n")
}

YOI_ADJ_ROOT:
'' YOI_ADJ Verb(good)

YOI_ADJ:
いい I_ADJ_SHORTFORM
よ YOI_ADJ_SUFFIX
良 YOI_ADJ_SUFFIX

I_ADJ_ROOT:
#{
iadjs.map {|k,v| k + " I_ADJ_SUFFIX Adj(" + v + ")"}.join("\n")
}

NA_ADJ_ROOT:
#{
naadjs.map {|k,v| k + " NA_ADJ_SUFFIX Adj(" + v + ")"}.join("\n")
}

ICHIDAN_V_ROOT:
#{
ichidanverbs.map {|k,v| k + " ICHIDAN_V_SUFFIX Verb(" + v + ")"}.join("\n")
}

SURU_V_ROOT:
'' SURU_V_INTERM Verb(do)
#{
suruverbs.map {|k,v| k + " SURU_V_INTERM Verb(" + v + ")"}.join("\n")
}

KURU_V_ROOT:
'' KURU_V_INTERM Verb(come)
#{
kuruverbs.map {|k,v| k + " KURU_V_INTERM Verb(" + v + ")"}.join("\n")
}

ARU_V_ROOT:
'' ARU_V_INTERM Verb(exist)
#{
aruverbs.map {|k,v| k + " IKU_V_INTERM Verb(" + v + ")"}.join("\n")
}

IKU_V_ROOT:
'' IKU_V_INTERM Verb(go)
#{
ikuverbs.map {|k,v| k + " IKU_V_INTERM Verb(" + v + ")"}.join("\n")
}

KU_V_ROOT:
#{
kuverbs.map {|k,v| k + " KU_V_SUFFIX Verb(" + v + ")"}.join("\n")
}

SU_V_ROOT:
#{
suverbs.map {|k,v| k + " SU_V_SUFFIX Verb(" + v + ")"}.join("\n")
}

U_V_ROOT:
#{
uverbs.map {|k,v| k + " U_V_SUFFIX Verb(" + v + ")"}.join("\n")
}

GU_V_ROOT:
#{
guverbs.map {|k,v| k + " GU_V_SUFFIX Verb(" + v + ")"}.join("\n")
}

BU_V_ROOT:
#{
buverbs.map {|k,v| k + " BU_V_SUFFIX Verb(" + v + ")"}.join("\n")
}

TSU_V_ROOT:
#{
tsuverbs.map {|k,v| k + " TSU_V_SUFFIX Verb(" + v + ")"}.join("\n")
}

MU_V_ROOT:
#{
muverbs.map {|k,v| k + " MU_V_SUFFIX Verb(" + v + ")"}.join("\n")
}

NU_V_ROOT:
#{
nuverbs.map {|k,v| k + " NU_V_SUFFIX Verb(" + v + ")"}.join("\n")
}

RU_V_ROOT:
#{
ruverbs.map {|k,v| k + " RU_V_SUFFIX Verb(" + v + ")"}.join("\n")
}
EOSSTRING

puts generateddocument

