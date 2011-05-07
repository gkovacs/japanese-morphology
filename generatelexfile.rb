#!/usr/bin/ruby1.9
# encoding: utf-8

nogenerate = ARGV.include?("nogenerate")

nouns = {"漢字" => "kanji", "結婚式" => "wedding ceremony"}
iadjs = {"恥ずかし" => "embarrasing", "広" => "spacious"}
naadjs = {"簡単" => "simple", "きれい" => "clean", "好き" => "like"}
ichidanverbs = {"食べ" => "eat", "見" => "see"}
suruverbs = {"結婚" => "get married", "卒業" => "graduate"}
kuruverbs = {"連れて" => "bring someone along", "持って" => "bring something"}
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

generateddocument = <<EOSSTRING
Begin: Root
Root: NounRoot VerbRoot AdjRoot
NounRoot: N_ROOT
VerbRoot: ICHIDAN_V_ROOT SURU_V_ROOT KURU_V_ROOT IKU_V_ROOT KU_V_ROOT SU_V_ROOT U_V_ROOT GU_V_ROOT BU_V_ROOT TSU_V_ROOT MU_V_ROOT NU_V_ROOT RU_V_ROOT
AdjRoot: I_ADJ_ROOT NA_ADJ_ROOT
AfterNoun: N_SUFFIX

N_ROOT:
#{
nouns.map {|k,v| k + " End Noun(" + v + ")"}.join("\n")
}

I_ADJ_ROOT:
#{
iadjs.map {|k,v| k + " I_ADJ_SUFFIX Adj(" + v + ")"}.join("\n")
}

NA_ADJ_ROOT:
#{
naadjs.map {|k,v| k + " NA_ADJ_SUFFIX Adj(" + v + ")"}.join("\n")
}

I_ADJ_SUFFIX:
い End
かった End past

NA_ADJ_SUFFIX:
な End
た End
だった End past
'' End

ICHIDAN_V_ROOT:
#{
ichidanverbs.map {|k,v| k + " ICHIDAN_V_SUFFIX Verb(" + v + ")"}.join("\n")
}

SURU_V_ROOT:
'' SURU_V_INTERM Verb(do)
#{
suruverbs.map {|k,v| k + " SURU_V_INTERM Verb(" + v + ")"}.join("\n")
}

SURU_V_INTERM:
す SURU_SU_V_SUFFIX
し SURU_SHI_V_SUFFIX
でき POTENTIALONLY
出来 POTENTIALONLY

KURU_V_ROOT:
'' KURU_V_INTERM Verb(come)
#{
kuruverbs.map {|k,v| k + " KURU_V_INTERM Verb(" + v + ")"}.join("\n")
}

KURU_V_INTERM:
来 ICHIDAN_V_SUFFIX
く KURU_KU_V_SUFFIX
こ KURU_KO_V_SUFFIX
き KURU_KI_V_SUFFIX

IKU_V_ROOT:
'' IKU_V_INTERM Verb(go)
#{
ikuverbs.map {|k,v| k + " IKU_V_INTERM Verb(" + v + ")"}.join("\n")
}

IKU_V_INTERM:
い IKU_V_SUFFIX
行 IKU_V_SUFFIX

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

ICHIDAN_V_SUFFIX:
る INF
'' NEG
'' STEM
'' TETA
られ POTENTIALONLY
よ VOLITIONAL
れ EBA

SURU_SU_V_SUFFIX:
る INF
れ EBA

SURU_SHI_V_SUFFIX:
'' NEG
'' STEM
'' TETA
よ VOLITIONAL

KURU_KU_V_SUFFIX:
る INF
れ EBA

KURU_KO_V_SUFFIX:
'' NEG
られ POTENTIALONLY
よ VOLITIONAL

KURU_KI_V_SUFFIX:
'' STEM
'' TETA

IKU_V_SUFFIX:
く INF
か NEG
き STEM
っ TETA
け POTENTIAL
こ VOLITIONAL

KU_V_SUFFIX:
く INF
か NEG
き STEM
い TETA
け POTENTIAL
こ VOLITIONAL

SU_V_SUFFIX:
す INF
さ NEG
し STEM
し TETA
せ POTENTIAL
そ VOLITIONAL

MASU_V_SUFFIX:
す INF
さ NEG
し STEM
し TETA
せ POTENTIAL
しょ VOLITIONAL

U_V_SUFFIX:
う INF
わ NEG
い STEM
っ TETA
え POTENTIAL
お VOLITIONAL

GU_V_SUFFIX:
ぐ INF
が NEG
ぎ STEM
い DEDA
げ POTENTIAL
ご VOLITIONAL

BU_V_SUFFIX:
ぶ INF
ば NEG
び STEM
ん DEDA
べ POTENTIAL
ぼ VOLITIONAL

TSU_V_SUFFIX:
つ INF
た NEG
ち STEM
っ TETA
て POTENTIAL
と VOLITIONAL

MU_V_SUFFIX:
む INF
ま NEG
み STEM
ん DEDA
め POTENTIAL
も VOLITIONAL

NU_V_SUFFIX:
ぬ INF
な NEG
に STEM
ん DEDA
ね POTENTIAL
の VOLITIONAL

RU_V_SUFFIX:
る INF
ら NEG
り STEM
っ TETA
れ POTENTIAL
ろ VOLITIONAL

TETA:
て End command
た End past
たり End listing actions
たら End conditional tara

DEDA:
で End command
だ End past
だり End listing actions
だら End tara conditional

INF:
'' End inf

STEM:
'' End stem
ま MASU_V_SUFFIX polite
ません End polite negative
ました End polite past
ませんでした End polite past negative

VOLITIONAL:
う End volitional

NEG:
ない End negative
なかった End negative past

POTENTIAL:
'' POTENTIALONLY
'' EBA

POTENTIALONLY:
'' ICHIDAN_V_SUFFIX potential

EBA:
ば End eba conditional

End:
'#' End SUCCESS
EOSSTRING

puts generateddocument
