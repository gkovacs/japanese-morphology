Begin: Root
Root: NounRoot VerbRoot AdjRoot
NounRoot: N_ROOT
VerbRoot: ICHIDAN_V_ROOT SURU_V_ROOT KURU_V_ROOT IKU_V_ROOT KU_V_ROOT SU_V_ROOT U_V_ROOT GU_V_ROOT BU_V_ROOT TSU_V_ROOT MU_V_ROOT NU_V_ROOT RU_V_ROOT
AdjRoot: I_ADJ_ROOT NA_ADJ_ROOT
AfterNoun: N_SUFFIX

N_ROOT:
漢字 End Noun(kanji)

I_ADJ_ROOT:
恥ずかし I_ADJ_SUFFIX Adj(embarrasing)
広 I_ADJ_SUFFIX Adj(spacious)

NA_ADJ_ROOT:
簡単 NA_ADJ_SUFFIX Adj(simple)
きれい NA_ADJ_SUFFIX Adj(clean)
好き NA_ADJ_SUFFIX Adj(like)

I_ADJ_SUFFIX:
い End
かった End past

NA_ADJ_SUFFIX:
な End
た End
だった End past
'' End

ICHIDAN_V_ROOT:
見 ICHIDAN_V_SUFFIX Verb(see)
来 ICHIDAN_V_SUFFIX Verb(come)

SURU_V_ROOT:
す SURU_SU_V_SUFFIX Verb(do)
し SURU_SHI_V_SUFFIX Verb(do)
でき POTENTIALONLY Verb(do)
出来 POTENTIALONLY Verb(do)

KURU_V_ROOT:
く KURU_KU_V_SUFFIX Verb(come)
こ KURU_KO_V_SUFFIX Verb(come)
き KURU_KI_V_SUFFIX Verb(come)

IKU_V_ROOT:
行 IKU_V_SUFFIX Verb(go)

KU_V_ROOT:
歩 KU_V_SUFFIX Verb(walk)

SU_V_ROOT:
話 SU_V_SUFFIX Verb(talk)

U_V_ROOT:
買 U_V_SUFFIX Verb(buy)

GU_V_ROOT:
泳 GU_V_SUFFIX Verb(swim)

BU_V_ROOT:
遊 BU_V_SUFFIX Verb(play)

TSU_V_ROOT:
待 TSU_V_SUFFIX

MU_V_ROOT:
読 MU_V_SUFFIX Verb(read)

NU_V_ROOT:
死 NU_V_SUFFIX Verb(die)

RU_V_ROOT:
取 RU_V_SUFFIX Verb(take)

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

