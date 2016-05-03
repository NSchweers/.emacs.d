;; -*- lexical-binding: t -*-

(pc ace-jump-mode
    (:post-install (require 'ace-jump-mode))
    (:bind
     (("C-c SPC" . ace-jump-mode))))

;; (use-package ace-jump-mode
;;   ;; (require 'ace-jump-mode)
;;   :bind ("C-c SPC" . ace-jump-mode)
;;   ;; (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
;;   )

(provide 'setup-ace-jump-mode)
