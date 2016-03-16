;; -*- lexical-binding: t -*-

(use-package elpy
  :config
  (add-hook 'python-mode-hook #'(lambda () (setq fill-column 79)))
  (elpy-enable))

(provide 'setup-elpy)
