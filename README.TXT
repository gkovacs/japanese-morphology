== Information ==

This repository ( http://github.com/gkovacs/japanese-morphology ) contains a program to derive the base form, parts of speech, and mophological features given a surface form of a word (wordtest.py), as well as a program to segment a sentence into words and provide morphological information for each of the words present in the sentence.

== Prerequisites ==

You will need Ruby 1.9 and python-nltk to use these programs:

'''
sudo apt-get install ruby1.9 python-nltk
'''

== Downloading ==

'''
git clone https://github.com/gkovacs/japanese-morphology.git
'''

== Setup ==

First, the lexicon file needs to be generated. The lexicon is generated using the generatelexfile.rb program. One of 3 options can be passed to generatelexfile.rb to control which items are included in the lexicon: "allwords" will include the full edict2 dictionary, "usedictionary" will include only the common words in the edict2 dictionary, and "reduced" will include only those words which appear in the corpus. Thus, to generate a lexicon including common words:

'''
./generatelexfile.rb usedictionary > japanese-dictionary.lex
cat japanese-rules.lex japanese-dictionary.lex japanese-auxiliary.lex > japanese.lex
'''

== Using wordtest.py ==

Pass a word (ex: 食べました) as the argument to wordtest.py, and the base form (食べる), part of speech (Verb), and definition (to eat), as well as a list of other morphological features (polite, past) will be printed out:

'''
./wordtest.py 食べました
[Output]
食べました BASE:食べる POS:Verb DEF:to eat polite past
'''

Here's second example - in this case, we see the "volitional" feature, which is used in describing a course of action you wish to take; thus, this word means "let's drink" (said in a polite manner to somebody that one isn't intimate with).

'''
./wordtest.py 飲みましょう
[Output]
飲みましょう BASE:飲む POS:Verb DEF:to drink polite volitional
'''

For a list of words that exhibit the various conjugation forms and morphological features this system can handle, see japanese-words.txt. Running "./wordtest.py" without arguments will cause it to run on all words in this this list.

== Using sentencetest.py ==

Pass a sentence (ex: 昨日はすごく寒かったので、私たちは学校へ行けなかった。) as the argument to sentencetest.py, and the list of words and morphological information for each word will be output. To assist in your understanding of the gloss, the "potential" feature shown here indicates one's ability to perform an action - thus 行けなかった means "was unable to go". Also note that adjectives can be conjugated in Japanese - in this case 寒かった is the past tense form of the i adjective 寒い (it is classified as an IAdjective because there is another class, the na-adjective, as well as a rather rare class called the taru-adjective which are used and conjugate differently). Therefore, this sentence means "Because it was terribly cold yesterday, we were unable to go to school". The "COST" line on the bottom indicates the number of non-punctuation characters which couldn't be covered by words - in this case, all non-puncutation characters were accounted for, so the cost is 0.

'''
./sentencetest.py 昨日はすごく寒かったので、私たちは学校へ行けなかった。
[Output]
===SENTENCE===昨日はすごく寒かったので、私たちは学校へ行けなかった。
(昨日,BASE:昨日 POS:Noun DEF:yesterday)
(は,BASE:は POS:Particle DEF:topic marker particle)
(すごく,BASE:すごい POS:IAdjective DEF:terrible)
(寒かった,BASE:寒い POS:IAdjective DEF:cold past)
(ので,BASE:ので POS:Particle DEF:that being the case)
(私たち,BASE:私 POS:Noun DEF:I and others)
(は,BASE:は POS:Particle DEF:topic marker particle)
(学校,BASE:学校 POS:Noun DEF:school)
(へ,BASE:へ POS:Particle DEF:indicates direction or goal)
(行けなかった,BASE:行く POS:Verb DEF:go potential negative past)
~~~COST~~~0
'''

Here's a second example - in this case we see the "causative" feature, which indicates that someone is causing/making someone to do something, thus 食べさせる means "make (someone) eat (something)", thus the sentence as a whole translates to "When chicken meat is not cheap, the mother makes her family eat vegetables". We also see the "honorific" features on お母さん and ご家族, which indicates that they have the honorific prefix (either お or ご), which is attached to words when speaking about something respectfully (in this case, the mother and her family).

'''
./sentencetest.py 鶏肉が安くない時、お母さんはご家族に野菜を食べさせる。
[Output]
===SENTENCE===鶏肉が安くない時、お母さんはご家族に野菜を食べさせる。
(鶏肉,BASE:鶏肉 POS:Noun DEF:chicken meat)
(が,BASE:が POS:Particle DEF:indicates sentence subject)
(安くない,BASE:安い POS:IAdjective DEF:cheap negative)
(時,BASE:時 POS:Noun DEF:time)
(お母さん,BASE:母さん POS:Noun honorable DEF:mother)
(は,BASE:は POS:Particle DEF:topic marker particle)
(ご家族,BASE:家族 POS:Noun honorable DEF:family)
(に,BASE:に POS:Particle DEF:indicates such things as location of person or thing, location of short-term action, etc.)
(野菜,BASE:野菜 POS:Noun DEF:vegetable)
(を,BASE:を POS:Particle DEF:indicates direct object of action)
(食べさせる,BASE:食べる POS:Verb DEF:to eat causative inf)
~~~COST~~~0
'''

== Using sentencewordboundaries.py ==

To evaluate the sentence segmentation accuracy, the list of words in the sentence is first extracted, then the set of indexes in the corpus where the word or punctuation boundaries is compared to the boundaries in the reference. The "sentencewordboundaries.py" script can do the extraction of the list of word boundaries in the sentence for you; simply provide it with a sentence as an argument. For example, using the previous example sentence:

'''
./sentencewordboundaries.py 鶏肉が安くない時、お母さんはご家族に野菜を食べさせる。
[Output]
[鶏肉,が,安くない,時,お母さん,は,ご家族,に,野菜,を,食べさせる]
[0, 2, 3, 7, 8, 9, 13, 14, 17, 18, 20, 21, 26, 27]
'''

The first line in the output is the list of words found in the sentence; the second line is the set of word/word or word/punctuation boundary indexes.

== Reproducing Experiment Results: Word Base Form and POS Extraction ==

For your convenience, my own result of testing word base form extraction and parts of speech are located in "word-base-pos-results.txt". However, should you wish to reproduce my results, you will first need to have a script run some preprocessing on the corpus (namely, merge prefixes and suffixes into the words):

'''
cd corpus
./corpus-setup.sh
cd ..
'''

Now you can run the script which extracts the base form and POS for words and compares against the corpus annotation:

'''
./get-baseform-pos.py corpus
'''

The output of this script for each word in the corpus will be of the form:

"""
SurfaceForm ActualBaseForm[/MisdetectedBaseForm] ActualPartOfSpeech[/MisdetectedPartOfSpeech] Status
"""

Where Status is [SUCCESS] if both the base form and part of speech match, [FAILURE] if the morphological analyzer rejected the word, [BASEFAIL] if the morphological analyzer output a correct part of speech but an incorrect base form, [POSFAIL] if the morphological analyzer output the correct base form but the incorrect part of speech, and [BPFAIL] if both the base form and part of speech output by the morphological analyzer were incorrect.

== Reproducing Experiment Results: Sentence Segmentation ==

For your convenience, my own result of testing the sentence segmentation accuracy is located in the "segment-results" directory. However, should you wish to reproduce my results, then first run the ./corpus-setup.sh script (see previous section).

Now, run the sentencewordboundaries.py script with no arguments.

'''
./get-baseform-pos.py corpus
'''

The output of this script for each sentence will be of the form:

"""
OriginalSentence
ReferenceWordList
GeneratedWordList
ReferenceWordBoundaries
GeneratedWordBoundaries
===STAT SentenceNumber ReferenceNumBoundariesInSentence MissedBoundariesInSentence SuperfluousBoundariesInSentence ~COMPL~
SentenceNumber of TotalNumberSentences total TotalReferenceNumBoundariesThusFar mis TotalMissedBoundariesThusFar supf TotalSuperfluousBoundariesThusFar
"""

Where "MissedBoundariesInSentence" is the number of boundaries present in the reference segmentation but not in the generated one, and "SuperfluousBoundariesInSentence" is the number of boundaries present in the generated segmentation but not in the reference one.

