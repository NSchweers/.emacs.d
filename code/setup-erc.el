;; -*- lexical-binding: t -*-

(and (load-library "erc-highlight-nicknames")
     (add-to-list 'erc-modules 'highlight-nicknames)
     (erc-update-modules))
(add-hook 'erc-mode-hook #'(lambda ()
                             (auto-fill-mode nil)
                             (show-paren-mode nil)))

(provide 'setup-erc)
