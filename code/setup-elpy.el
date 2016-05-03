;; -*- lexical-binding: t -*-

(pc elpy
  (:post-install
   (add-hook 'python-mode-hook
             (lambda () (setf fill-column 79)))
   (elpy-enable)))

;; (use-package elpy
;;   :config
;;   (add-hook 'python-mode-hook #'(lambda () (setq fill-column 79)))
;;   (elpy-enable))

(provide 'setup-elpy)
