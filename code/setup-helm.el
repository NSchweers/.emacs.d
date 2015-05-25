;; -*- lexical-binding: t -*-

(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-M-y") 'helm-show-kill-ring)
(setq helm-man-or-woman-function 'woman)
(setq helm-man-or-woman-function 'Man-getpage-in-background)
(helm-mode 1)

(provide 'setup-helm)
