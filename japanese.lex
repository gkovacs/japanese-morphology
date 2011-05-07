Begin: Root
Root: NounRoot VerbRoot
NounRoot: N_ROOT
VerbRoot: ICHIDAN_V_ROOT IKU_V_ROOT KU_V_ROOT SU_V_ROOT U_V_ROOT GU_V_ROOT BU_V_ROOT TSU_V_ROOT MU_V_ROOT NU_V_ROOT RU_V_ROOT
AfterNoun: N_SUFFIX

N_ROOT:
漢字 End Noun(kanji)

ICHIDAN_V_ROOT:
見 ICHIDAN_V_SUFFIX Verb(see)

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
れ EBAONLY

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

MASU_V_SUFFIX
す INF
さ NEG
し STEM
し TETA
せ POTENTIAL
しよ VOLITIONAL

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
'#' End None

