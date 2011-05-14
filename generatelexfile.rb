#!/usr/bin/ruby1.9
# encoding: utf-8

usedictionary = ARGV.include?("usedictionary")

numbers = {"0" => "0", "1" => "1", "2" => "2", "3" => "3", "4" => "4", "5" => "5", "6" => "6", "7" => "7", "8" => "8", "9" => "9", "０" => "0", "１" => "1", "２" => "2", "３" => "3", "４" => "4", "５" => "5", "６" => "6", "７" => "7", "８" => "8", "９" => "9", "〇" => "0", "零" => "0", "一" => "1", "二" => "2", "三" => "3", "四" => "4", "五" => "5", "六" => "6", "七" => "7", "八" => "8", "九" => "9", "十" => "10", "百" => "100", "千" => "1000", "万" => "10000"}
counters = {"つ" => "generic objects", "個" => "small objects", "人" => "people", "匹" => "small animals", "台" => "machines", "冊" => "books", "本" => "long objects", "枚" => "flat objects",  "足" => "shoes", "杯" => "cups", "頁" => "page", "ページ" => "page", "丁目" => "address", "円" => "yen", "ドル" => "dollars", "セント" => "cents", "歳" => "years of age", "回" => "times", "度" => "degrees", "年" => "year", "月" => "month number", "ヶ月" => "months", "日" => "day", "時" => "hour", "分" => "minute", "秒" => "second", "" => "number"}
nouns = {"漢字" => "kanji", "結婚式" => "wedding ceremony", "日本人" => "Japanese person", "日本語" => "Japanese language", "学生" => "student", "先生" => "teacher", "夏" => "summer", "予約" => "reservation", "東京" => "Tokyo", "魚" => "fish", "医者" => "doctor"}
iadjs = {"恥ずかし" => "embarrasing", "広" => "spacious", "面白" => "interesting", "強" => "strong", "寒" => "cold", "難し" => "difficult", "楽し" => "fun"}
naadjs = {"簡単" => "simple", "きれい" => "clean", "好き" => "like", "元気" => "lively", "親切" => "kind"}
taruadjs = {"漫然" => "rambling", "堂々" => "magnificent", "愕然" => "astonishing", "唖然" => "dumbfounded", "颯爽" => "gallant", "黙々" => "silent", "依然" => "still"}
ichidanverbs = {"食べ" => "eat", "見" => "see", "覚え" => "remember", "寝" => "sleep", "開け" => "open", "借り" => "borrow", "遅れ" => "be late", "忘れ" => "forget", "入れ" => "enter"}
suruverbs = {"" => "do", "結婚" => "get married", "卒業" => "graduate", "勉強" => "study", "予約" => "reserve", "運転" => "drive", "注意" => "be careful", "電話" => "make a phone call", "説明" => "explain"}
kuruverbs = {"" => "come", "連れて" => "bring someone along", "持って" => "bring something"}
aruverbs = {"" => "exist", "事が" => "has occurred", "ことが" => "has occurred"}
ikuverbs = {"" => "go", "連れて" => "take someone along", "持って" => "carry something away"}
kuverbs = {"歩" => "walk", "書" => "write", "聞" => "listen"}
suverbs = {"話" => "speak", "貸" => "lend"}
uverbs = {"買" => "buy", "手伝" => "assist", "歌" => "sing", "使" => "use", "会" => "meet"}
guverbs = {"泳" => "swim"}
buverbs = {"遊" => "play", "呼" => "call or invite"}
tsuverbs = {"持" => "carry", "待" => "wait", "立" => "stand"}
muverbs = {"読" => "read", "飲" => "drink"}
nuverbs = {"死" => "die"}
ruverbs = {"取" => "take", "降" => "fall", "閉ま" => "close"}
honverbs = {"下さ" => "give to me", "くださ" => "give to me", "いらっしゃ" => "go come or be", "ござ" => "exist"}

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

def genentries(entrydict, categoryname, nextcategory, descfn)
	output = categoryname + ":\n" + entrydict.map{|k,v|
		if k == ""
			k = "''"
		end
		"#{k} #{nextcategory} #{descfn.(v)}"
	}.join("\n")
end

def genentriesAlt(entrydict, categoryname, nextcategory, descfn)
	return outputcategories(mktree(entrydict), categoryname, nextcategory, descfn)
end

def mktree(entries)
	output = {}
	entries.each {|k,v|
		curdict = output
		chararr = k.each_char.to_a
		if chararr.length == 0
			curdict[""] = v
		else
		chararr.each_index {|i|
			c = chararr[i]
			if !curdict.include?(c)
				curdict[c] = {}
			end
			curdict = curdict[c]
			if i == chararr.length - 1
				curdict[""] = v
			end
		}
		end
	}
	return output
end

def outputcategories(entries, categoryname, nextcategory, descfn)
	childentries = []
	othercategories = []
	entries.each {|k,v|
		if v.class() == "".class()
			if k == ""
				k = "''"
			end
			childentries.push("#{k} #{nextcategory} #{descfn.(v)}")
		else
			ncategory = outputcategories(v, categoryname+k, nextcategory, descfn)
			othercategories.push(ncategory)
			childentries.push("#{k} #{categoryname+k}")
		end
	}
	output = categoryname + ":\n"
	output += childentries.join("\n") + "\n\n"
	output += othercategories.join()
	return output
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
        if tags.include?("n")
        	readings.each { |x|
                nouns[x] = english
            }
        end
    end
}
end

generateddocument = <<EOSSTRING
#{
genentries(numbers, "NUMBER", "NUMBER_SUFFIX", -> v { v } )
}

#{
genentries(counters, "COUNTER", "POSTCOUNTER", -> v { v } )
}

#{
genentries(nouns, "NOUN_ROOT", "NOUN_SUFFIX", -> v { "Noun(#{v})" } )
}

YOI_ADJ_ROOT:
'' YOI_ADJ Verb(good)

YOI_ADJ:
いい I_ADJ_SHORTFORM
よ YOI_ADJ_SUFFIX
良 YOI_ADJ_SUFFIX

#{
genentries(iadjs, "I_ADJ_ROOT", "I_ADJ_SUFFIX", -> v { "Adj(#{v})" } )
}

#{
genentries(naadjs, "NA_ADJ_ROOT", "NA_ADJ_SUFFIX", -> v { "Adj(#{v})" } )
}

#{
genentries(taruadjs, "I_ADJ_ROOT", "TARU_ADJ_SUFFIX", -> v { "Adj(#{v})" } )
}

#{
genentries(ichidanverbs, "ICHIDAN_V_ROOT", "ICHIDAN_V_SUFFIX", -> v { "Verb(#{v})" } )
}

#{
genentries(ichidanverbs, "ICHIDAN_V_ROOT_HONORIFIC", "ICHIDAN_V_SUFFIX_HONORIFIC", -> v { "Verb(#{v})" } )
}

#{
genentries(suruverbs, "SURU_V_ROOT", "SURU_V_INTERM", -> v { "Verb(#{v})" } )
}

#{
genentries(suruverbs, "SURU_V_ROOT_HONORIFIC", "POST_HONORIFIC_SURU_VERB", -> v { "Verb(#{v})" } )
}

#{
genentries(kuruverbs, "KURU_V_ROOT", "KURU_V_INTERM", -> v { "Verb(#{v})" } )
}

#{
genentries(aruverbs, "ARU_V_ROOT", "ARU_V_INTERM", -> v { "Verb(#{v})" } )
}

#{
genentries(ikuverbs, "IKU_V_ROOT", "IKU_V_INTERM", -> v { "Verb(#{v})" } )
}

#{
genentries(kuverbs, "KU_V_ROOT", "KU_V_SUFFIX", -> v { "Verb(#{v})" } )
}

#{
genentries(kuverbs, "KU_V_ROOT_HONORIFIC", "KU_V_SUFFIX_HONORIFIC", -> v { "Verb(#{v})" } )
}

#{
genentries(suverbs, "SU_V_ROOT", "SU_V_SUFFIX", -> v { "Verb(#{v})" } )
}

#{
genentries(suverbs, "SU_V_ROOT_HONORIFIC", "SU_V_SUFFIX_HONORIFIC", -> v { "Verb(#{v})" } )
}

#{
genentries(uverbs, "U_V_ROOT", "U_V_SUFFIX", -> v { "Verb(#{v})" } )
}

#{
genentries(uverbs, "U_V_ROOT_HONORIFIC", "U_V_SUFFIX_HONORIFIC", -> v { "Verb(#{v})" } )
}

#{
genentries(guverbs, "GU_V_ROOT", "GU_V_SUFFIX", -> v { "Verb(#{v})" } )
}

#{
genentries(guverbs, "GU_V_ROOT_HONORIFIC", "GU_V_SUFFIX_HONORIFIC", -> v { "Verb(#{v})" } )
}

#{
genentries(buverbs, "BU_V_ROOT", "BU_V_SUFFIX", -> v { "Verb(#{v})" } )
}

#{
genentries(buverbs, "BU_V_ROOT_HONORIFIC", "BU_V_SUFFIX_HONORIFIC", -> v { "Verb(#{v})" } )
}

#{
genentries(tsuverbs, "TSU_V_ROOT", "TSU_V_SUFFIX", -> v { "Verb(#{v})" } )
}

#{
genentries(tsuverbs, "TSU_V_ROOT_HONORIFIC", "TSU_V_SUFFIX_HONORIFIC", -> v { "Verb(#{v})" } )
}

#{
genentries(muverbs, "MU_V_ROOT", "MU_V_SUFFIX", -> v { "Verb(#{v})" } )
}

#{
genentries(muverbs, "MU_V_ROOT_HONORIFIC", "MU_V_SUFFIX_HONORIFIC", -> v { "Verb(#{v})" } )
}

#{
genentries(nuverbs, "NU_V_ROOT", "NU_V_SUFFIX", -> v { "Verb(#{v})" } )
}

#{
genentries(nuverbs, "NU_V_ROOT_HONORIFIC", "NU_V_SUFFIX_HONORIFIC", -> v { "Verb(#{v})" } )
}

#{
genentries(ruverbs, "RU_V_ROOT", "RU_V_SUFFIX", -> v { "Verb(#{v})" } )
}

#{
genentries(ruverbs, "RU_V_ROOT_HONORIFIC", "RU_V_SUFFIX_HONORIFIC", -> v { "Verb(#{v})" } )
}

#{
genentries(honverbs, "HON_V_ROOT", "HON_V_SUFFIX", -> v { "Verb(#{v})" } )
}
EOSSTRING

puts generateddocument

