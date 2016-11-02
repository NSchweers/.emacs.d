;; -*- lexical-binding: t -*-

(pc evil
  (:post-install
   ;; (setf evil-default-state 'emacs)
   (define-key evil-normal-state-map "U" 'undo-tree-visualize)
   (evil-mode 1)))

;; (use-package evil
;;   :config
;;   (setf evil-default-state 'emacs)
;;   (evil-mode 1))

(provide 'setup-evil)
