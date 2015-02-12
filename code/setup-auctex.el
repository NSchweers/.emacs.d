;; -*- lexical-binding: t -*-
(add-hook 'LaTeX-mode-hook 'misc/set-kill-and-delete-keys)
(add-hook 'LaTeX-mode-hook (lambda () (TeX-PDF-mode)))
(add-hook 'LaTeX-mode-hook 'flyspell-mode)

(provide 'setup-auctex)
