(add-hook 'LaTeX-mode-hook 'misc/set-kill-and-delete-keys)
(add-hook 'LaTeX-mode-hook (lambda () (TeX-PDF-mode)))

(provide 'setup-auctex)
