#!/usr/bin/ruby1.9
# encoding: utf-8

fileName = ARGV[0]
asutf8 = `nkf --ic=EUC-JP --oc=UTF-8 #{fileName}`
File.delete(fileName)
File.open(fileName, "w") { |f| f.write(asutf8) }
