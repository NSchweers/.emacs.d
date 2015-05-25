;; -*- lexical-binding: t -*-

(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x 5" "C-x v" "C-x 8"
                                     "C-x n" "C-c C-x" "C-x c"))
(guide-key-mode 1)
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)
(setq guide-key/idle-delay 0.1)


(provide 'setup-guide-keys)
