;; -*- lexical-binding: t -*-

;;; Why the hell is it called tex-site?

(use-package tex-site
  :ensure auctex
  :config
  ;; (add-hook 'LaTeX-mode-hook 'misc/set-kill-and-delete-keys)
  ;; (push '(pdf . pdfsync) TeX-source-correlate-method)
  (add-hook 'LaTeX-mode-hook (lambda ()
                               (TeX-PDF-mode)
                               ;; (push '(pdf . pdfsync)
                               ;;       TeX-source-correlate-method)
                               (define-key LaTeX-mode-map
                                 [remap backward-delete-char]
                                 'delete-backward-char)
                               (define-key LaTeX-mode-map (kbd "M-\"")
                                 #'schweers/org-TeX-string)
                               (TeX-source-correlate-mode 1)))
  (add-hook 'LaTeX-mode-hook 'flyspell-mode))

(provide 'setup-auctex)
