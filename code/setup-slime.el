;; -*- lexical-binding: t -*-
(cond ((eq system-type 'windows-nt)
       (setq inferior-lisp-program "sbcl"))
      ((eq system-type 'gnu/linux)
       (setq inferior-lisp-program "sbcl")))

(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

(provide 'setup-slime)
