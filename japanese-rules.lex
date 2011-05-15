Begin: Root
Root: DECISION_ROOT PARTICLE_ROOT AUXILIARY_ROOT PRENOUNADJECTIVAL_ROOT ADVERB_ROOT VerbRoot AdjRoot NounRoot

NounRoot: NUMBER NOUN_ROOT
VerbRoot: NonSuruVerbRoot SURU_V_ROOT HONORIFIC_REG_VERB
NonSuruVerbRoot: ICHIDAN_V_ROOT GodanVerbRoot NonSuruIrregularVerbRoot
GodanVerbRoot: KU_V_ROOT SU_V_ROOT U_V_ROOT GU_V_ROOT BU_V_ROOT TSU_V_ROOT MU_V_ROOT NU_V_ROOT RU_V_ROOT
NonSuruIrregularVerbRoot: KURU_V_ROOT ARU_V_ROOT IKU_V_ROOT HON_V_ROOT

NonSuruVerbRoot_HONORIFIC: ICHIDAN_V_ROOT_HONORIFIC GodanVerbRoot_HONORIFIC
GodanVerbRoot_HONORIFIC: KU_V_ROOT_HONORIFIC SU_V_ROOT_HONORIFIC U_V_ROOT_HONORIFIC GU_V_ROOT_HONORIFIC BU_V_ROOT_HONORIFIC TSU_V_ROOT_HONORIFIC MU_V_ROOT_HONORIFIC NU_V_ROOT_HONORIFIC RU_V_ROOT_HONORIFIC

AdjRoot: YOI_ADJ_ROOT I_ADJ_ROOT NA_ADJ_ROOT TARU_ADJ_ROOT

DECISION_ROOT:
'' PROBABLY POS:Decision;;BASE:だ
'' NA_ADJ_NOUN_DESU POS:Decision;;BASE:だ
な End POS:Decision;;BASE:だ

HONORIFIC_REG_VERB:
お NonSuruVerbRoot_HONORIFIC
御 NonSuruVerbRoot_HONORIFIC
ご SURU_V_ROOT_HONORIFIC
御 SURU_V_ROOT_HONORIFIC

POST_HONORIFIC_SURU_VERB:
'' SURU_V_INTERM humble
'' KUDASAI respectful

STEM_HONORIFIC:
'' SURU_V_INTERM humble
に NARU honorific
'' KUDASAI respectful

NUMBER_SUFFIX:
'' NUMBER
'' COUNTER

POSTCOUNTER:
間 OPTIONALHALF duration
目 OPTIONALHALF ordinal
'' OPTIONALHALF

OPTIONALHALF:
半 MANYFEW half
'' MANYFEW

MANYFEW:
も End many
しか End few
'' End

YOI_ADJ_SUFFIX:
さ SOU
'' I_ADJ_INTERM

I_ADJ_SUFFIX:
'' SOU
'' I_ADJ_INTERM

I_ADJ_INTERM:
い I_ADJ_SHORTFORM
かった I_ADJ_SHORTFORM past
く I_ADJ_KU_SHORTFORM

NEG_NAI:
'' I_ADJ_INTERM
い BETTERDO
く NAKU
さ SOU

NA_ADJ_SUFFIX:
な NA_ADJ_SHORTFORM
だ HERESAY
な NDESU
'' NA_ADJ_DESU
'' End
'' SOU
に NA_ADJ_NI_SHORTFORM

TARU_ADJ_SUFFIX:
と End adverbial

NOUN_SUFFIX:
'' End
'' MITAI
に NARU
で End via
な NDESU
だ HERESAY
だ SHORTFORM
'' NOUN_DESU
の NOUN_NO_SHORTFORM

SURU_V_INTERM:
す SURU_SU_V_SUFFIX
し SURU_SHI_V_SUFFIX
でき POTENTIALONLY
出来 POTENTIALONLY
さ SURU_SA_V_SUFFIX

KURU_V_INTERM:
来 ICHIDAN_V_SUFFIX BASE:来る
く KURU_KU_V_SUFFIX BASE:くる
こ KURU_KO_V_SUFFIX BASE:くる
き KURU_KI_V_SUFFIX BASE:くる

ARU_V_INTERM:
'' NEG
あ ARU_V_SUFFIX BASE:ある
有 ARU_V_SUFFIX BASE:有る
在 ARU_V_SUFFIX BASE:在る

IKU_V_INTERM:
い IKU_V_SUFFIX BASE:いく
行 IKU_V_SUFFIX BASE:行く

ICHIDAN_V_SUFFIX:
る INF
'' NEG
'' STEM
'' VERBTETA
られ POTENTIALONLY
られ PASSIVE
させ CAUSATIVE
よ VOLITIONAL
れ EBA

SURU_SU_V_SUFFIX:
る INF
れ EBA

SURU_SHI_V_SUFFIX:
'' NEG
'' STEM
'' VERBTETA
よ VOLITIONAL

SURU_SA_V_SUFFIX:
れ PASSIVE
せ CAUSATIVE

KURU_KU_V_SUFFIX:
る INF
れ EBA

KURU_KO_V_SUFFIX:
'' NEG
られ POTENTIALONLY
られ PASSIVE
させ CAUSATIVE
よ VOLITIONAL

KURU_KI_V_SUFFIX:
'' STEM
'' VERBTETA

ARU_V_SUFFIX:
る INF
り STEM
っ VERBTETA
れ POTENTIAL
ろ VOLITIONAL

IKU_V_SUFFIX:
く INF
き STEM
っ VERBTETA
け POTENTIAL
か GODAN_A
こ VOLITIONAL

KU_V_SUFFIX:
く INF
き STEM
い VERBTETA
け POTENTIAL
か GODAN_A
こ VOLITIONAL

SU_V_SUFFIX:
す INF
し STEM
し VERBTETA
せ POTENTIAL
さ NEG
され PASSIVE
させ CAUSATIVE
そ VOLITIONAL

MASU_V_SUFFIX:
す INF
し STEM
し VERBTETA
せ POTENTIAL
しょ VOLITIONAL

U_V_SUFFIX:
う INF
い STEM
っ VERBTETA
え POTENTIAL
わ GODAN_A
お VOLITIONAL

GU_V_SUFFIX:
ぐ INF
ぎ STEM
い VERBDEDA
げ POTENTIAL
が GODAN_A
ご VOLITIONAL

BU_V_SUFFIX:
ぶ INF
び STEM
ん VERBDEDA
べ POTENTIAL
ば GODAN_A
ぼ VOLITIONAL

TSU_V_SUFFIX:
つ INF
ち STEM
っ VERBTETA
て POTENTIAL
た GODAN_A
と VOLITIONAL

MU_V_SUFFIX:
む INF
み STEM
ん VERBDEDA
め POTENTIAL
ま GODAN_A
も VOLITIONAL

NU_V_SUFFIX:
ぬ INF
に STEM
ん VERBDEDA
ね POTENTIAL
な GODAN_A
の VOLITIONAL

RU_V_SUFFIX:
る INF
り STEM
っ VERBTETA
れ POTENTIAL
ら GODAN_A
ろ VOLITIONAL

GODAN_A:
'' NEG
れ PASSIVE
せ CAUSATIVE
され CAUSATIVE_PASSIVE

HON_V_SUFFIX:
る INF
ら NEG
い STEM
っ VERBTETA
れ POTENTIAL
ろ VOLITIONAL

ICHIDAN_V_SUFFIX_HONORIFIC:
'' STEM_HONORIFIC

KU_V_SUFFIX_HONORIFIC:
き STEM_HONORIFIC

SU_V_SUFFIX_HONORIFIC:
し STEM_HONORIFIC

U_V_SUFFIX_HONORIFIC:
い STEM_HONORIFIC

GU_V_SUFFIX_HONORIFIC:
ぎ STEM_HONORIFIC

BU_V_SUFFIX_HONORIFIC:
び STEM_HONORIFIC

TSU_V_SUFFIX_HONORIFIC:
ち STEM_HONORIFIC

MU_V_SUFFIX_HONORIFIC:
み STEM_HONORIFIC

NU_V_SUFFIX_HONORIFIC:
に STEM_HONORIFIC

RU_V_SUFFIX_HONORIFIC:
り STEM_HONORIFIC

VERBTETA:
て VERBTE
た VERBTA
'' VERBCHA
'' VERBTEWA

VERBDEDA:
で VERBTE
だ VERBTA
'' VERBJA
'' VERBDEWA

VERBCHA:
ちゃ SHIMAU
てしま SHIMAU

VERBJA:
じゃ SHIMAU
でしま SHIMAU

SHIMAU:
'' U_V_SUFFIX completion or regret

VERBTE:
'' End command
から End after
み ICHIDAN_V_SUFFIX trying out
'' IRU
お KU_V_SUFFIX done in advance
'' KURERU
'' APOLOGY
'' HOSHI
'' ARU_V_INTERM has been made

IRU:
い ICHIDAN_V_SUFFIX ongoing action or state
おりま SU_V_SUFFIX ongoing action or state humble

NASARU:
なさ HON_V_SUFFIX do honorific

HOSHI:
ほし I_ADJ_SUFFIX want someone to do
欲し I_ADJ_SUFFIX want someone to do

APOLOGY:
すみません End sorry polite
すみませんでした End sorry past polite
ごめん End sorry

KURERU:
くれ ICHIDAN_V_SUFFIX give to me
あげ ICHIDAN_V_SUFFIX give
もら U_V_SUFFIX receive
いただけません End please honorific
くださいません End please honorific
下さいません End please honorific
もらえません End please formal
'' KUDASAI

VERBTA:
'' VERBSHORTFORM past
り End listing actions
ら TARA
'' BETTERDO

TARA:
'' End conditional tara
どう End suggestion
どうです End suggestion polite

INF:
'' VERBSHORTFORM inf
の NOUN_SUFFIX the act of
つもり NOUN_SUFFIX intend to
前に End before

STEM:
'' End stem
ま MASU_V_SUFFIX polite
ません End polite negative
ました End polite past
ませんでした End polite past negative
'' SOU
た I_ADJ_SUFFIX want
たがってい ICHIDAN_V_SUFFIX appears to want
すぎ ICHIDAN_V_SUFFIX excessive
ながら End while
'' DIFFICULTY
なさい End command from superior

SOU:
そう NA_ADJ_SUFFIX seeming

DIFFICULTY:
やす I_ADJ_SUFFIX easy
にく I_ADJ_SUFFIX hard

HERESAY:
そうです End heresay polite
そうだ End heresay

MITAI:
みたい NA_ADJ_SUFFIX resembling

NA_ADJ_NI_SHORTFORM:
'' NARU
'' MAKEADJ
'' End

MAKEADJ:
'' SURU_V_INTERM make it be

I_ADJ_DESU:
'' DESU

NA_ADJ_DESU:
'' NA_ADJ_NOUN_DESU

NOUN_DESU:
'' NA_ADJ_NOUN_DESU

NA_ADJ_NOUN_DESU:
だ End
だった End past
だ HERESAY
だった HERESAY past
でした End past polite
'' DESU

DESU:
です End polite
で ARU_V_INTERM
では ARU_V_INTERM
じゃ ARU_V_INTERM
でございま SU_V_SUFFIX modest
'' PROBABLY
'' POSSIBILITY

NARU:
な RU_V_SUFFIX become

VOLITIONAL:
う End volitional

NEG:
無 NEG_NAI negative;;BASE:無い
な NEG_NAI negative;;BASE:ない
ないで End without
ないで KUDASAI don't

NA_ADJ_SHORTFORM:
'' SHORTFORM
'' EXPECTATION

I_ADJ_SHORTFORM:
'' SHORTFORM
'' I_ADJ_DESU
'' NDESU
'' HERESAY
'' EXPECTATION

I_ADJ_KU_SHORTFORM:
'' NARU
'' NEG
'' MAKEADJ
'' End

NOUN_NO_SHORTFORM:
'' EXPECTATION
ような End similar to
ように End done in the same way

VERBSHORTFORM:
'' SHORTFORM
'' PROBABLY
'' NDESU
'' POSSIBILITY
'' HERESAY
'' EXPECTATION

EXPECTATION:
はず NOUN_DESU expectation

POSSIBILITY:
かもしれな NEG_NAI possibility
かも知れな NEG_NAI possibility
かもしれません End possibility polite
かも知れません End possibility polite

PROBABLY:
だろう End probably
でしょう End probably polite

NAKU:
ても YOI_ADJ not necessary
て APOLOGY
'' VERBTEWA

VERBTEWA:
ては TEWAPASSED
ちゃ TEWAPASSED

VERBDEWA:
では TEWAPASSED
じゃ TEWAPASSED

TEWAPASSED:
いけ ICHIDAN_V_SUFFIX allowed

SHORTFORM:
'' End

NDESU:
んだ End explanatory
の End explanatory feminine
んです End explanatory polite

KUDASAI:
ください End please
下さい End please

POTENTIAL:
'' POTENTIALONLY
'' EBA

BETTERDO:
ほうが YOI_ADJ better do
方が YOI_ADJ better do

POTENTIALONLY:
'' ICHIDAN_V_SUFFIX potential

PASSIVE:
'' ICHIDAN_V_SUFFIX passive

CAUSATIVE:
'' ICHIDAN_V_SUFFIX causative

CAUSATIVE_PASSIVE:
'' ICHIDAN_V_SUFFIX causative passive

EBA:
ば End eba conditional

End:
'#' End SUCCESS

