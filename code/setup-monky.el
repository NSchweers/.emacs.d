;; -*- lexical-binding: t -*-

(use-package monky
  :init
  (require 'monky)
  (setf monky-process-type 'cmdserver)
  :bind ("C-c m" . monky-status))

;; (eval-and-compile (require 'monky))

;; (setf monky-process-type 'cmdserver)

;; (global-set-key (kbd "C-m") 'monky-status)

(provide 'setup-monky)
