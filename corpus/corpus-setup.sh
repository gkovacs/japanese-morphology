#!/bin/bash

./extractwordsonly.rb extracted-raw-corpus.txt | sort | uniq > corpus-lexicon.txt
./suffixmerge.rb extracted-raw-corpus.txt > extracted-corpus-suffixmerged.txt
./prefixmerge.rb extracted-corpus-suffixmerged.txt > extracted-corpus-prefixsuffixmerged.txt
./extractwordsonly.rb extracted-corpus-prefixsuffixmerged.txt | sort | uniq > corpus-allwords-base-pos.txt

