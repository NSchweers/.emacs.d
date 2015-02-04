;; -*- lexical-binding: t -*-
(require 'mc16basm)

(add-hook 'mc16basm-mode-hook
          (lambda ()
            (local-set-key (kbd "C-j") 'newline)
            (local-set-key (kbd "<return>") 'mc16basm-newline-and-indent)))

(provide 'setup-mc16basm)
