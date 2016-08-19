;; -*- lexical-binding: t -*-

(pc cargo)
(pc rust-mode)
(pc racer)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)

(provide 'setup-rust)
