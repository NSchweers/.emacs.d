;; -*- lexical-binding: t -*-

(pc diminish
  (:post-install
   (diminish 'emacs-lisp-mode "EL")
   (diminish 'lisp-interaction-mode "LIM")
   (diminish 'auto-revert-mode)))

(provide 'setup-diminish)










