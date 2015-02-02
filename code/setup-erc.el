(add-hook 'erc-mode-hook (lambda ()
                           (auto-fill-mode nil)
                           (show-paren-mode nil)))

(provide 'setup-erc)
