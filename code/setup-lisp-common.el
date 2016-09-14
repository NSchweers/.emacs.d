;; -*- lexical-binding: t -*-

(defvar schweers/*lisp-mode-hooks*
  '(clojure-mode-hook cider-repl-mode-hook emacs-lisp-mode-hook
                      lisp-mode-hook slime-repl-mode-hook
                      scheme-mode geiser-mode-hook
                      geiser-repl-mode-hook))

(provide 'setup-lisp-common)
