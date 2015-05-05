;; -*- lexical-binding: t -*-

(add-hook 'lisp-interaction-mode-hook (-partial 'eldoc-mode))
(add-hook 'emacs-lisp-mode-hook (-partial 'eldoc-mode))

(provide 'setup-eldoc)
