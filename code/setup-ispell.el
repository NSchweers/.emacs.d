;; -*- lexical-binding: t -*-

(require 'ispell)

(add-to-list
 'ispell-local-dictionary-alist
 '("deutsch-hunspell"
   "[[:alpha:]]"
   "[^[:alpha:]]"
   "['ß]"
   nil
   ("-d" "de_DE")                       ; Dictionary file name
   nil
   iso-8859-1))

(add-to-list
 'ispell-local-dictionary-alist
 '("english-hunspell"
   "[[:alpha:]]"
   "[^[:alpha:]]"
   "[']"
   nil
   ("-d" "en_US")
   nil
   iso-8859-1))

(provide 'setup-ispell)
