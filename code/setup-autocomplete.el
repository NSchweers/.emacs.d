;; -*- lexical-binding: t -*-

(pc auto-complete
  (:require (require 'auto-complete-config))
  (:post-install
   (add-to-list 'ac-user-dictionary-files (concat user-emacs-directory "ac-dict"))
   (ac-config-default)
   (ac-set-trigger-key "TAB")
   ;; (add-hook 'slime-mode-hook 'set-up-slime-ac)
   ;; (add-hook 'slime-repl-mode 'set-up-slime-ac)
   ;; (eval-after-load "auto-complete"
   ;;   '(add-to-list 'ac-modes 'slime-repl-mode))
   ))

;; (use-package auto-complete
;;   :config 
;;   (require 'auto-complete-config)

;;   (add-to-list 'ac-user-dictionary-files (concat user-emacs-directory "ac-dict"))
;;   (ac-config-default)

;;   (ac-set-trigger-key "TAB")

;;   ;; (dolist (m
;;   ;;          (list 'clojure-mode-hook 'cider-repl-mode-hook 'emacs-lisp-mode-hook))
;;   ;;   (add-hook m #'(lambda () (auto-complete-mode))))

;;   (add-hook 'slime-mode-hook 'set-up-slime-ac)
;;   (add-hook 'slime-repl-mode 'set-up-slime-ac)
;;   (eval-after-load "auto-complete"
;;     '(add-to-list 'ac-modes 'slime-repl-mode)))

(provide 'setup-autocomplete)
