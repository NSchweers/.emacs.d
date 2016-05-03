;; -*- lexical-binding: t -*-

(pc undo-tree
  (:post-install
   (global-undo-tree-mode 1)
   (diminish 'undo-tree-mode)))

;; (use-package undo-tree
;;   :init
;;   (global-undo-tree-mode 1))

(provide 'setup-undo-tree-mode)
