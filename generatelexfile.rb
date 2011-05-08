#!/usr/bin/ruby1.9
# encoding: utf-8

usedictionary = ARGV.include?("usedictionary")

nouns = {"漢字" => "kanji", "結婚式" => "wedding ceremony", "日本人" => "Japanese person", "日本語" => "Japanese language"}
iadjs = {"恥ずかし" => "embarrasing", "広" => "spacious", "面白" => "interesting", "強" => "strong"}
naadjs = {"簡単" => "simple", "きれい" => "clean", "好き" => "like"}
ichidanverbs = {"食べ" => "eat", "見" => "see", "覚え" => "remember", "寝" => "sleep", "開け" => "open"}
suruverbs = {"結婚" => "get married", "卒業" => "graduate"}
kuruverbs = {"連れて" => "bring someone along", "持って" => "bring something"}
aruverbs = {"事が" => "has occurred", "ことが" => "has occurred"}
ikuverbs = {"連れて" => "take someone along", "持って" => "carry something away"}
kuverbs = {"歩" => "walk"}
suverbs = {"話" => "speak"}
uverbs = {"買" => "buy"}
guverbs = {"泳" => "swim"}
buverbs = {"遊" => "play"}
tsuverbs = {"持" => "wait"}
muverbs = {"読" => "read"}
nuverbs = {"死" => "die"}
ruverbs = {"取" => "take"}

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
NOUN_ROOT:
#{
nouns.map {|k,v| k + " NOUN_SUFFIX Noun(" + v + ")"}.join("\n")
}

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

