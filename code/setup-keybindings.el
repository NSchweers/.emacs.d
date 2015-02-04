;; -*- lexical-binding: t -*-
;; Kill a word with C-w (as in shell and vim-insert-mode).  
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-c C-w") 'kill-region)
;; Note on rebinding C-h: One merely needs to press any "help" key (e.g. F1).
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "<f1>") 'help-command)
(define-key isearch-mode-map (kbd "C-h") 'isearch-del-char)

(with-demoted-errors (require 'smex)
                     (global-set-key (kbd "M-x") 'smex)
                     (global-set-key (kbd "M-X") 'smex-major-mode-commands)
                     ;; This is your old M-x.
                     (global-set-key (kbd "C-c M-x") 'execute-extended-command))

;; Scroll the buffer with keystrokes.  
(global-set-key (kbd "C-S-n") 'scroll-up-1)
(global-set-key (kbd "C-S-p") 'scroll-down-1)

;; Turn on the menu bar for exploring new modes
(global-set-key (kbd "M-S-<f10>") 'menu-bar-mode)

;; Transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(global-set-key (kbd "M-t l") 'transpose-lines)
(global-set-key (kbd "M-t w") 'transpose-words)
(global-set-key (kbd "M-t s") 'transpose-sexps)
(global-set-key (kbd "M-t p") 'transpose-params)

;; Switch windows with shift-cursors.  
(windmove-default-keybindings)

;; Have completion on C-TAB, as ESC TAB is lame.
(global-set-key (kbd "<C-tab>") 'completion-at-point)

(provide 'setup-keybindings)
