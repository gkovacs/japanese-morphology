#!/bin/bash

cat extracted-raw-corpus.txt | ./extractwordsonly.rb | sort | uniq > corpus-lexicon.txt
cat extracted-raw-corpus.txt | ./suffixmerge.rb > extracted-corpus-suffixmerged.txt
cat extracted-corpus-suffixmerged.txt | ./prefixmerge.rb > extracted-corpus-prefixsuffixmerged.txt
cat extracted-corpus-prefixsuffixmerged.txt | ./extractwordsonly.rb > corpus-allwords-base-pos.txt

