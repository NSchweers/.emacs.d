;; -*- lexical-binding: t -*-
(add-hook 'python-mode-hook (lambda () (setq fill-column 79)))
(elpy-enable)

(provide 'setup-elpy)
