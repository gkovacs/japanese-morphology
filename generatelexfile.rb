#!/usr/bin/ruby1.9
# encoding: utf-8

$LOAD_PATH << File.join(File.expand_path(File.dirname(__FILE__)), '.')
require 'typelists.rb'

usedictionary = ARGV.include?("usedictionary")
$reduced = ARGV.include?("reduced")

dictfile = "edict2-common-utf8"
$corpuswords = {}
if $reduced
	File.open("corpus/corpus-lexicon.txt").each { |line|
		spl = line.split(" ")
		conjform = spl[0]
		baseform = spl[1]
		$corpuswords[conjform] = true
		$corpuswords[baseform] = true
		if baseform[baseform.length-1] == "だ"
			$corpuswords[baseform[0..baseform.length-2]] = true
		end
		sansnums = baseform.each_char.select {|x| !allnum.include?(x)}.join("")
		if sansnums != ""
			$corpuswords[sansnums] = true
		end
	}
end
if $reduced || ARGV.include?("allwords")
	dictfile = "edict2-utf8"
end

def wordincluded(w)
	if !$reduced
		return true
	end
	return $corpuswords.include?(w)
end

numbers = {"0" => "0", "1" => "1", "2" => "2", "3" => "3", "4" => "4", "5" => "5", "6" => "6", "7" => "7", "8" => "8", "9" => "9", "０" => "0", "１" => "1", "２" => "2", "３" => "3", "４" => "4", "５" => "5", "６" => "6", "７" => "7", "８" => "8", "９" => "9", "〇" => "0", "零" => "0", "一" => "1", "二" => "2", "三" => "3", "四" => "4", "五" => "5", "六" => "6", "七" => "7", "八" => "8", "九" => "9", "十" => "10", "百" => "100", "千" => "1000", "万" => "10000"}
counters = {"つ" => "generic objects", "個" => "small objects", "人" => "people", "匹" => "small animals", "台" => "machines", "冊" => "books", "本" => "long objects", "枚" => "flat objects",  "足" => "shoes", "杯" => "cups", "頁" => "page", "ページ" => "page", "番" => "number place", "丁目" => "address", "円" => "yen", "ドル" => "dollars", "キロ" => "kilos", "メートル" => "meters", "セント" => "cents", "歳" => "years of age", "回" => "times", "倍" => "fold", "割" => "rate", "回生" => "college year", "度" => "degrees", "年" => "year", "月" => "month number", "ヶ月" => "months", "日" => "day", "時" => "hour", "分" => "minute", "秒" => "second", "" => "number"}
prefixes = {"お" => "honorable", "ご" => "honorable", "御" => "honorable", "み" => "honorable", "オ" => "honorable", "オオ" => "honorable", "ひと" => "first", "各" => "each", "旧" => "former", "元" => "original", "現" => "current", "後" => "final", "高" => "highest", "今" => "current", "最" => "most", "準" => "level", "初" => "first", "小" => "small", "新" => "new", "全" => "complete", "他" => "other", "大" => "big", "第" => "th", "超" => "super", "長" => "chief", "同" => "same", "非" => "mistaken", "不" => "un", "無" => "non", "猛" => "extreme", "約" => "promised", "翌" => "next", "来" => "coming"}
demonstrative = {"あちら" => "there", "あの" => "that", "あれ" => "there", "あんな" => "that", "こーいう" => "this", "こう" => "this", "こういう" => "this", "こういった" => "this", "こうした" => "this", "こうして" => "this", "ここ" => "here", "こちら" => "this way", "こっち" => "this way", "この" => "this", "このような" => "this sort", "このように" => "this sort", "これ" => "here", "こん" => "this", "こんな" => "this sort", "こんなに" => "this sort", "そう" => "there", "そういう" => "that", "そういった" => "that", "そうした" => "that", "そうして" => "that", "そこ" => "there", "そちら" => "that way", "そっ" => "that way", "そっち" => "that way", "その" => "that", "そのような" => "that sort", "そのように" => "that sort", "そりゃ" => "that", "それ" => "that", "そん" => "that", "そんな" => "that sort", "そんなに" => "that sort", "どう" => "which", "どういう" => "which", "どうした" => "which", "どうして" => "which", "どお" => "which", "どこ" => "where", "どちら" => "which way", "どっち" => "which way", "どの" => "which", "どのような" => "which sort", "どのように" => "which sort", "どれ" => "where", "どん" => "which", "どんな" => "which", "どんなに" => "which"}
nouns = {"漢字" => "kanji", "結婚式" => "wedding ceremony", "日本人" => "Japanese person", "日本語" => "Japanese language", "学生" => "student", "先生" => "teacher", "夏" => "summer", "予約" => "reservation", "東京" => "Tokyo", "魚" => "fish", "医者" => "doctor", "おじゃん" => "nothing", "合理" => "rational"}
iadjs = {"恥ずかし" => "embarrasing", "広" => "spacious", "面白" => "interesting", "強" => "strong", "寒" => "cold", "難し" => "difficult", "楽し" => "fun"}
naadjs = {"簡単" => "simple", "きれい" => "clean", "好き" => "like", "元気" => "lively", "親切" => "kind"}
taruadjs = {"漫然" => "rambling", "堂々" => "magnificent", "愕然" => "astonishing", "唖然" => "dumbfounded", "颯爽" => "gallant", "黙々" => "silent", "依然" => "still"}
ichidanverbs = {"食べ" => "eat", "見" => "see", "覚え" => "remember", "寝" => "sleep", "開け" => "open", "借り" => "borrow", "遅れ" => "be late", "忘れ" => "forget", "入れ" => "put in", "与え" => "provide"}
suruverbs = {"" => "do", "結婚" => "get married", "卒業" => "graduate", "勉強" => "study", "予約" => "reserve", "運転" => "drive", "注意" => "be careful", "電話" => "make a phone call", "説明" => "explain"}
kuruverbs = {"" => "come", "連れて" => "bring someone along", "持って" => "bring something"}
aruverbs = {"" => "exist", "事が" => "has occurred", "ことが" => "has occurred"}
ikuverbs = {"" => "go", "連れて" => "take someone along", "持って" => "carry something away"}
kuverbs = {"歩" => "walk", "書" => "write", "聞" => "listen"}
suverbs = {"話" => "speak", "貸" => "lend"}
uverbs = {"買" => "buy", "手伝" => "assist", "歌" => "sing", "使" => "use", "会" => "meet", "言" => "say", "い" => "say"}
guverbs = {"泳" => "swim"}
buverbs = {"遊" => "play", "呼" => "call or invite"}
tsuverbs = {"持" => "carry", "待" => "wait", "立" => "stand"}
muverbs = {"読" => "read", "飲" => "drink"}
nuverbs = {"死" => "die"}
ruverbs = {"取" => "take", "降" => "fall", "閉ま" => "close"}
honverbs = {"下さ" => "give to me", "くださ" => "give to me", "いらっしゃ" => "go come or be", "ござ" => "exist", "なさ" => "do", "為さ" => "do", "おっしゃ" => "say", "仰" => "say", "仰有" => "say", "仰しゃ" => "say"}
particles = {"だけ" => "just", "なら" => "just"}
auxiliary = {}
prenounadjectival = {}
adverbs = {}
conjunction = {}
interjection = {}

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

def identityfn(ar)
	return ar
end

def genentries(entrydict, categoryname, nextcategory, pos)
	output = categoryname + ":\n" + entrydict.map{|k,v|
		tl = k
		if tl == ""
			tl = "''"
		end
		"#{tl} #{nextcategory} POS:#{pos};;BASE:#{k};;DEF:#{v}"
	}.join("\n")
end

def genentriesCustom(entrydict, categoryname, nextcategory, pos, basegen)
	output = categoryname + ":\n" + entrydict.map{|k,v|
		tl = k
		if tl == ""
			tl = "''"
		end
		"#{tl} #{nextcategory} POS:#{pos};;BASE:#{basegen.(k)};;DEF:#{v}"
	}.join("\n")
end

def genentriesNobase(entrydict, categoryname, nextcategory, pos)
	output = categoryname + ":\n" + entrydict.map{|k,v|
		tl = k
		if tl == ""
			tl = "''"
		end
		"#{tl} #{nextcategory} POS:#{pos};;DEF:#{v}"
	}.join("\n")
end

def genentriesManual(entrydict, categoryname, nextcategory, descfn)
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
File.open(dictfile, "r") { |f|
    while line = f.gets()
        line = line.strip()
        if line[0..2] == "？？？"
            next
        end
        line,tags = extractparenthesis(line)
        readings = []
        if !line.include?("[")
            kanji = line[0 .. line.index("/") - 1 ] 
            kana = ""
        else
	        kanji = line[0 .. line.index("[") - 1].strip()
	        kana = line[line.index("[")+1 .. line.index("]")-1].strip()
        end
        english = line[line.index("/")+1 .. line.length].strip()
        english = english.split("/")[0]
        kanji.split(";").each { |x|
            readings.push(x.strip())
        }
        suppreadings = []
        if tags.include?("uk") || tags.include?("ek") || (!tags.include?("n") && !tags.include?("adj-na"))
            kana.split(";").each { |x|
                suppreadings.push(x.strip())
            }
        end
        readings.delete("")
        suppreadings.delete("")
        if readings.length == 0
            next
        end
        if english.length == 0
            next
        end
        if !readings.map { |x| wordincluded(x) }.include?(true)
        	next
        end
        readings += suppreadings
        if tags.include?("v1")
            readings.each { |x|
                x = x[0..x.length-2]
                ichidanverbs[x] = english
            }
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
        if tags.include?("vs-s")
            readings.each { |x|
                x = x[0..x.length-3]
                suruverbs[x] = english
            }
        end
        if tags.include?("prt")
        	readings.each { |x|
                particles[x] = english
            }
        end
        if tags.include?("aux") || tags.include?("aux-v")
        	readings.each { |x|
                auxiliary[x] = english
            }
        end
        if tags.include?("adj-pn")
        	readings.each { |x|
        		prenounadjectival[x] = english
        	}
        end
        if tags.include?("adv") || tags.include?("adv-n")
        	readings.each { |x|
        		adverbs[x] = english
        	}
        end
        if tags.include?("ctr")
        	readings.each { |x|
                counters[x] = english
            }
        end
        if tags.include?("adj-i")
        	readings.each { |x|
        	    x = x[0..x.length-2]
                iadjs[x] = english
            }
        end
        if tags.include?("adj-na")
        	readings.each { |x|
                naadjs[x] = english
            }
        end
        if tags.include?("conj")
        	readings.each { |x|
                conjunction[x] = english
            }
        end
        if tags.include?("int")
        	readings.each { |x|
                interjection[x] = english
            }
        end
        if tags.include?("n") || tags.include?("pn") || tags.include?("n-adv")
        	readings.each { |x|
                nouns[x] = english
            }
        end
    end
}
end

particlesExclude = ["して", "なり"]
particlesExclude.each { |x| particles.delete(x) }

generateddocument = <<EOSSTRING
#{
genentries(numbers, "NUMBER", "NUMBER_SUFFIX", "Number" )
}

#{
genentries(counters, "COUNTER", "POSTCOUNTER", "Number" )
}

PREFIX_ROOT:
#{
prefixes.map {|k,v| k+" PREFIX_SUFFIX "+v }.join("\n")
}

#{
genentries(nouns, "NOUN_ROOT", "NOUN_SUFFIX", "Noun")
}

#{
genentries(particles, "PARTICLE_ROOT", "End", "Particle")
}

#{
genentries(auxiliary, "AUXILIARY_ROOT", "End", "Auxiliary")
}

#{
genentries(adverbs, "ADVERB_ROOT", "End", "Adverb" )
}

#{
genentries(prenounadjectival, "PRENOUNADJECTIVAL_ROOT", "End", "PreNounAdjectival" )
}

#{
genentries(conjunction, "CONJUNCTION_ROOT", "End", "Conjunction" )
}

#{
genentries(demonstrative, "DEMONSTRATIVE_ROOT", "End", "Demonstrative" )
}

#{
genentries(interjection, "INTERJECTION_ROOT", "End", "Interjection" )
}

YOI_ADJ_ROOT:
'' YOI_ADJ POS:IAdjective DEF:good

YOI_ADJ:
いい I_ADJ_SHORTFORM BASE:いい
よ YOI_ADJ_SUFFIX BASE:よい
良 YOI_ADJ_SUFFIX BASE:良い

#{
genentriesCustom(iadjs, "I_ADJ_ROOT", "I_ADJ_SUFFIX", "IAdjective", -> v { v+"い" } )
}

#{
genentriesCustom(naadjs, "NA_ADJ_ROOT", "NA_ADJ_SUFFIX", "NaAdjective", -> v { v+"だ" } )
}

#{
genentriesCustom(taruadjs, "TARU_ADJ_ROOT", "TARU_ADJ_SUFFIX", "TaruAdjective", -> v { v+"たる" } )
}

#{
genentriesCustom(ichidanverbs, "ICHIDAN_V_ROOT", "ICHIDAN_V_SUFFIX", "Verb", -> v { v+"る" } )
}

#{
genentriesCustom(ichidanverbs, "ICHIDAN_V_ROOT_HONORIFIC", "ICHIDAN_V_SUFFIX_HONORIFIC", "Verb", -> v { v+"る" } )
}

#{
genentriesCustom(suruverbs, "SURU_V_ROOT", "SURU_V_INTERM", "Verb", -> v { v+"する" } )
}

#{
genentriesCustom(suruverbs, "SURU_V_ROOT_HONORIFIC", "POST_HONORIFIC_SURU_VERB", "Verb", -> v { v+"する" } )
}

#{
genentriesNobase(kuruverbs, "KURU_V_ROOT", "KURU_V_INTERM", "Verb")
}

#{
genentriesNobase(aruverbs, "ARU_V_ROOT", "ARU_V_INTERM", "Verb" )
}

#{
genentriesNobase(ikuverbs, "IKU_V_ROOT", "IKU_V_INTERM", "Verb" )
}

#{
genentriesCustom(kuverbs, "KU_V_ROOT", "KU_V_SUFFIX", "Verb", -> v { v+"く" } )
}

#{
genentriesCustom(kuverbs, "KU_V_ROOT_HONORIFIC", "KU_V_SUFFIX_HONORIFIC", "Verb", -> v { v+"く" } )
}

#{
genentriesCustom(suverbs, "SU_V_ROOT", "SU_V_SUFFIX", "Verb", -> v { v+"す" } )
}

#{
genentriesCustom(suverbs, "SU_V_ROOT_HONORIFIC", "SU_V_SUFFIX_HONORIFIC", "Verb", -> v { v+"す" } )
}

#{
genentriesCustom(uverbs, "U_V_ROOT", "U_V_SUFFIX", "Verb", -> v { v+"う" } )
}

#{
genentriesCustom(uverbs, "U_V_ROOT_HONORIFIC", "U_V_SUFFIX_HONORIFIC", "Verb", -> v { v+"う" } )
}

#{
genentriesCustom(guverbs, "GU_V_ROOT", "GU_V_SUFFIX", "Verb", -> v { v+"ぐ" } )
}

#{
genentriesCustom(guverbs, "GU_V_ROOT_HONORIFIC", "GU_V_SUFFIX_HONORIFIC", "Verb", -> v { v+"ぐ" } )
}

#{
genentriesCustom(buverbs, "BU_V_ROOT", "BU_V_SUFFIX", "Verb", -> v { v+"ぶ" } )
}

#{
genentriesCustom(buverbs, "BU_V_ROOT_HONORIFIC", "BU_V_SUFFIX_HONORIFIC", "Verb", -> v { v+"ぶ" } )
}

#{
genentriesCustom(tsuverbs, "TSU_V_ROOT", "TSU_V_SUFFIX", "Verb", -> v { v+"つ" } )
}

#{
genentriesCustom(tsuverbs, "TSU_V_ROOT_HONORIFIC", "TSU_V_SUFFIX_HONORIFIC", "Verb", -> v { v+"つ" } )
}

#{
genentriesCustom(muverbs, "MU_V_ROOT", "MU_V_SUFFIX", "Verb", -> v { v+"む" } )
}

#{
genentriesCustom(muverbs, "MU_V_ROOT_HONORIFIC", "MU_V_SUFFIX_HONORIFIC", "Verb", -> v { v+"む" } )
}

#{
genentriesCustom(nuverbs, "NU_V_ROOT", "NU_V_SUFFIX", "Verb", -> v { v+"ぬ" } )
}

#{
genentriesCustom(nuverbs, "NU_V_ROOT_HONORIFIC", "NU_V_SUFFIX_HONORIFIC", "Verb", -> v { v+"ぬ" } )
}

#{
genentriesCustom(ruverbs, "RU_V_ROOT", "RU_V_SUFFIX", "Verb", -> v { v+"る" } )
}

#{
genentriesCustom(ruverbs, "RU_V_ROOT_HONORIFIC", "RU_V_SUFFIX_HONORIFIC", "Verb", -> v { v+"る" } )
}

#{
genentriesCustom(honverbs, "HON_V_ROOT", "HON_V_SUFFIX", "Verb", -> v { v+"る" } )
}
EOSSTRING

puts generateddocument

