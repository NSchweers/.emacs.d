;; -*- lexical-binding: t -*-

(use-package helm
  :pin melpa-stable
  :bind (("M-x" . helm-M-x)
         ("C-M-y" . helm-show-kill-ring)
         ("C-x C-f" . helm-find-files))
  ;; (global-set-key (kbd "M-x") 'helm-M-x)
  ;; (global-set-key (kbd "C-M-y") 'helm-show-kill-ring)
  ;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
  :config
  (require 'helm-config)
  (setq helm-man-or-woman-function 'woman)
  (setq helm-man-or-woman-function 'Man-getpage-in-background)
  (helm-mode 1)
  :demand)

(provide 'setup-helm)
