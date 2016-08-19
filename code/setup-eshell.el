;; -*- lexical-binding: t -*-

(pc eshell
  :post-install
  (add-to-list 'eshell-visual-commands "htop")
  (require 'em-smart)
  (setq eshell-where-to-jump 'begin)
  (setq eshell-review-quick-commands nil)
  (setq eshell-smart-space-goes-to-end t))

(provide 'setup-eshell)
