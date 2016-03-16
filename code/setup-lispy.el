;; -*- lexical-binding: t -*-
(use-package lispy
  :pin melpa-stable
  :bind (("C-M-1" . lispy-describe-inline)
         ("C-M-2" . lispy-arglist-inline)
         ("C-M-3" . lispy-right))
  :config
  (dolist (m '(clojure-mode-hook cider-repl-mode-hook emacs-lisp-mode-hook
                                 lisp-mode-hook slime-repl-mode-hook))
    (add-hook m (lambda ()
                  (lispy-mode 1)
                  (subword-mode -1)
                  (define-key lispy-mode-map [remap backward-delete-char] 'lispy-delete-backward))))
  (defun schweers/lispy-M-paren ()
    (interactive)
    (let ((current-prefix-arg '(2)))
      (call-interactively 'lispy-parens)))
  (define-key lispy-mode-map (kbd "M-(") 'schweers/lispy-M-paren)
  :demand)

(provide 'setup-lispy)
