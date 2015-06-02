;; -*- lexical-binding: t -*-
;; My keybindings for paredit

(require 'paredit)
(require 'dash)
(require 's)

(defun paredit-wrap-round-from-behind ()
  (interactive)
  (forward-sexp -1)
  (paredit-wrap-round)
  (insert " ")
  (forward-char -1))

(defun paredit-wrap-square-from-behind ()
  (interactive)
  (forward-sexp -1)
  (paredit-wrap-square))

(defun paredit-wrap-curly-from-behind ()
  (interactive)
  (forward-sexp -1)
  (paredit-wrap-curly))

;; (defun paredit-kill-region-or-backward-word ()
;;   (interactive)
;;   (if (region-active-p)
;;       (kill-region (region-beginning) (region-end))
;;     (paredit-backward-kill-word)))

;; (defun setup-paredit/init ()
;;   (paredit-mode 1)
;;   (misc/set-kill-and-delete-keys))

;; (add-hook 'clojure-mode-hook #'(lambda () (setup-paredit/init)))
;; (add-hook 'cider-repl-mode-hook #'(lambda () (setup-paredit/init)))
;; (add-hook 'emacs-lisp-mode-hook #'(lambda () (setup-paredit/init)))
;; (add-hook 'lisp-mode-hook #'(lambda () (setup-paredit/init)))

;; (dolist (m '(clojure-mode-hook cider-repl-mode-hook emacs-lisp-mode-hook
;;                                lisp-mode-hook slime-repl-mode-hook))
;;   (add-hook m #'(lambda () (setup-paredit/init))))

(dolist (m '(clojure-mode-hook cider-repl-mode-hook emacs-lisp-mode-hook
                               lisp-mode-hook slime-repl-mode-hook))
  (add-hook m (-compose 'paredit-mode (-partial 'subword-mode -1))))

;; (add-hook 'lisp-mode-hook (-compose 'paredit-mode (-partial 'subword-mode -1)))

(define-key paredit-mode-map (kbd "M-(") 'paredit-wrap-round)
(define-key paredit-mode-map (kbd "M-)") 'paredit-wrap-round-from-behind)
(define-key paredit-mode-map (kbd "M-[") 'paredit-wrap-square)
(define-key paredit-mode-map (kbd "M-]") 'paredit-wrap-square-from-behind)
(define-key paredit-mode-map (kbd "M-{") 'paredit-wrap-curly)
(define-key paredit-mode-map (kbd "M-}") 'paredit-wrap-curly-from-behind)
(define-key paredit-mode-map (kbd "C-w") 'paredit-backward-kill-word)
(define-key paredit-mode-map [remap backward-kill-word]
  'paredit-backward-kill-word)

;; Take care of C-h
(define-key paredit-mode-map (kbd "C-h") 'paredit-backward-delete)

;; (define-key paredit-mode-map (kbd "C-w") 'paredit-kill-region-or-backward-word)

;; Change nasty paredit keybindings
;; (defvar my-nasty-paredit-keybindings-remappings
;;   '(("M-s"         "s-s"         paredit-splice-sexp)
;;     ("M-<up>"      "s-<up>"      paredit-splice-sexp-killing-backward)
;;     ("M-<down>"    "s-<down>"    paredit-splice-sexp-killing-forward)
;;     ("C-<right>"   "s-<right>"   paredit-forward-slurp-sexp)
;;     ("C-<left>"    "s-<left>"    paredit-forward-barf-sexp)
;;     ("C-M-<left>"  "s-S-<left>"  paredit-backward-slurp-sexp)
;;     ("C-M-<right>" "s-S-<right>" paredit-backward-barf-sexp)))

;; (define-key paredit-mode-map (kbd "s-r") 'paredit-raise-sexp)

;; (--each my-nasty-paredit-keybindings-remappings
;;   (let ((original (car it))
;;         (replacement (cadr it))
;;         (command (car (last it))))
;;     (define-key paredit-mode-map (read-kbd-macro original) nil)
;;     (define-key paredit-mode-map (read-kbd-macro replacement) command)))

;; don't hijack \ please
;; (define-key paredit-mode-map (kbd "\\") nil)

;; Enable `paredit-mode' in the minibuffer, during `eval-expression'.
(defun conditionally-enable-paredit-mode ()
  (if (eq this-command 'eval-expression)
      (paredit-mode 1)))

(add-hook 'minibuffer-setup-hook 'conditionally-enable-paredit-mode)

;; making paredit work with delete-selection-mode
(put 'paredit-forward-delete 'delete-selection 'supersede)
(put 'paredit-backward-delete 'delete-selection 'supersede)
(put 'paredit-newline 'delete-selection t)

;; functions in smartparens that do not have an equivalent in paredit - take a look at them
;; (when nil
;;   '(sp-beginning-of-sexp
;;     sp-end-of-sexp
;;     sp-next-sexp
;;     sp-previous-sexp
;;     sp-kill-sexp
;;     sp-unwrap-sexp
;;     sp-backward-unwrap-sexp
;;     sp-select-next-thing-exchange
;;     sp-select-next-thing
;;     sp-forward-symbol
;;     sp-backward-symbol))

;; Make RET use proper indentation, by switching C-j with RET
;(define-key paredit-mode-map (kbd "RET") 'paredit-newline)
;(define-key paredit-mode-map (kbd "C-j") 'newline)

(provide 'setup-paredit)
