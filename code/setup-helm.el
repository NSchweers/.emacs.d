;; -*- lexical-binding: t -*-

(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-M-y") 'helm-show-kill-ring)
(helm-mode 1)

(provide 'setup-helm)
