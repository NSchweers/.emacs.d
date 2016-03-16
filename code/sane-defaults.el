;; -*- lexical-binding: t -*-
;; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)

;; Fundamental Mode has to go in favor of Org Mode!
;(set-default 'major-mode 'org-mode)

;; Auto refresh buffers
; (global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; Show keystrokes in progress
(setq echo-keystrokes 0.1)

;; Move files to trash when deleting
; (setq delete-by-moving-to-trash t)

;; Real emacs knights don't use shift to mark things
(setq shift-select-mode nil)

;; Transparently open compressed files
(auto-compression-mode t)

;; Answering just 'y' or 'n' will do
; (defalias 'yes-or-no-p 'y-or-n-p)

;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

;; Show active region
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)

;; Remove text in active region if inserting text
(delete-selection-mode 1)

;; Don't highlight matches with jump-char - it's distracting
; (setq jump-char-lazy-highlight-face nil)

;; Lines should be 80 characters wide, not 72
(setq-default fill-column 80)
(setq-default auto-fill-function 'do-auto-fill)
(auto-fill-mode 1)

;; Save a list of recent files visited. (open recent file with C-x f)
(recentf-mode 1)
(setq recentf-max-saved-items 100) ;; just 20 is too recent

;; Save minibuffer history
(savehist-mode 1)
(setq history-length 1000)

;; Undo/redo window configuration with C-c <left>/<right>
(winner-mode 1)

;; Never insert tabs
(set-default 'indent-tabs-mode nil)

;; Easily navigate sillycased words
(global-subword-mode 1)

;; Don't break lines for me, please
; (setq-default truncate-lines t)

;; Keep cursor away from edges when scrolling up/down
; (require 'smooth-scrolling)

;; Allow recursive minibuffers
(setq enable-recursive-minibuffers t)

;; Don't be so stingy on the memory, we have lots now. It's the distant future.
(setq gc-cons-threshold 20000000)

;; org-mode: Don't ruin S-arrow to switch windows please (use M-+ and M--
;; instead to toggle)
(setq org-replace-disputed-keys nil)

;; Fontify org-mode code blocks
(setq org-src-fontify-natively t)

;; Represent undo-history as an actual tree (visualize with C-x u)
(with-demoted-errors (setq undo-tree-mode-lighter "")
                     (require 'undo-tree)
                     (global-undo-tree-mode 1))

;; Sentences do not need double spaces to end. Period.
; (set-default 'sentence-end-double-space nil)

;; Add parts of each file's directory to the buffer name if not unique
(with-demoted-errors (require 'uniquify)
                     (setq uniquify-buffer-name-style 'forward))

;; A saner ediff
(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Nic says eval-expression-print-level needs to be set to nil (turned off) so
;; that you can always see what's happening.
(setq eval-expression-print-level nil)

;; When popping the mark, continue popping until the cursor actually moves
;; Also, if the last command was a copy - skip past all the expand-region cruft.
(defadvice pop-to-mark-command (around ensure-new-position activate)
  (let ((p (point)))
    (when (eq last-command 'save-region-or-current-line)
      ad-do-it
      ad-do-it
      ad-do-it)
    (dotimes (i 10)
      (when (= p (point)) ad-do-it))))

;; one line at a time
(setq mouse-wheel-scroll-amount '(5 ((shift) . 5)))

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

;; Have proper scrolling.  
(setq scroll-margin 0
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)
(setq-default scroll-up-aggressively 0.01
              scroll-down-aggressively 0.01)

;set the diary to be in the git-repository
(setq diary-file "~/.emacs.d/diary")

;; Run at full power please
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

;; We want the minibuffer to shrink again
(setq resize-mini-windows t)

;; I don’t want to type out yes RET all the time
(fset 'yes-or-no-p 'y-or-n-p)

(add-to-list 'tags-table-list (expand-file-name "TAGS" user-emacs-directory))
(add-to-list 'tags-table-list (expand-file-name "code/src/emacs/src/TAGS" (getenv "HOME")))

;; (-each (list minibuffer-local-map
;;              minibuffer-local-ns-map
;;              minibuffer-local-completion-map
;;              minibuffer-local-must-match-map
;;              minibuffer-local-filename-completion-map
;;              minibuffer-local-filename-must-match-map)
;;   (lambda (m) (define-key m (kbd "C-h") 'delete-backward-char)))

;; Set lexical-binding in the *scratch* buffer to t
(with-current-buffer (get-buffer "*scratch*")
  (setq lexical-binding t))

(provide 'sane-defaults)
