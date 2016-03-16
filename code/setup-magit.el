;; -*- lexical-binding: t -*-
(use-package magit
  :init
  (require 's)
  :bind ("C-c g" . magit-status)
  :config
  (setq magit-repo-dirs (list (s-join "/" (list (getenv "HOME") "code"))
                              user-emacs-directory))
  (setq magit-repo-dirs (list (getenv "HOME")))
  (setq magit-last-seen-setup-instructions "1.4.0"))

;; Bind C-c g to magit-status
;; (global-set-key (kbd "C-c g") 'magit-status)

;; (setq magit-repo-dirs (list (s-join "/" (list (getenv "HOME") "code"))
;;                             user-emacs-directory))
;; (setq magit-repo-dirs (list (getenv "HOME")))
;; 3 seems to be the default. 
                                        ;(setq magit-repo-dirs-depth 3)


                                        ;(setq magit-auto-revert-mode nil)
;; (setq magit-last-seen-setup-instructions "1.4.0")

(provide 'setup-magit)
