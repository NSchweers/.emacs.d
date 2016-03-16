;; -*- lexical-binding: t -*-

;;; Why the hell is it called tex-site?

(use-package tex-site
  :ensure auctex
  :config
  (add-hook 'LaTeX-mode-hook 'misc/set-kill-and-delete-keys)
  (add-hook 'LaTeX-mode-hook (lambda () (TeX-PDF-mode)))
  (add-hook 'LaTeX-mode-hook 'flyspell-mode))

(provide 'setup-auctex)
