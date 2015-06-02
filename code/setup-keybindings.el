;; -*- lexical-binding: t -*-
;; ;; Kill a word with C-w (as in shell and vim-insert-mode).
;; (global-set-key (kbd "C-w") 'backward-kill-word)
;; (global-set-key (kbd "C-c C-w") 'kill-region)
;; (global-set-key (kbd "C-c C-a") 'kill-region)
;; ;; Note on rebinding C-h: One merely needs to press any "help" key (e.g. F1).
;; (global-set-key (kbd "C-h") 'delete-backward-char)
;; (global-set-key (kbd "<f1>") 'help-command)
(define-key isearch-mode-map (kbd "C-h") 'isearch-del-char)

;; (with-demoted-errors (require 'smex)
;;                      (global-set-key (kbd "M-x") 'smex)
;;                      (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;;                      ;; This is your old M-x.
;;                      (global-set-key (kbd "C-c M-x")
;;                      'execute-extended-command))
(global-set-key (kbd "C-c M-x") 'execute-extended-command)

;; Scroll the buffer with keystrokes.
;; (global-set-key (kbd "C-S-n") 'scroll-up-1)
;; (global-set-key (kbd "C-S-p") 'scroll-down-1)
;; Turn on the menu bar for exploring new modes
(global-set-key (kbd "M-S-<f10>") 'menu-bar-mode)

;; Transpose stuff with M-t
;; (global-unset-key (kbd "M-t")) ;; which used to be transpose-words
;; (global-set-key (kbd "M-t l") 'transpose-lines)
;; (global-set-key (kbd "M-t w") 'transpose-words)
;; (global-set-key (kbd "M-t s") 'transpose-sexps)
;; (global-set-key (kbd "M-t p") 'transpose-params)

;; (global-set-key
;;  (kbd "M-t")
;;  (let ((hydra-transpose/custom-prefix-arg nil))
;;    (defhydra hydra-transpose-backward
;;      (:pre (if (or (null hydra-transpose/custom-prefix-arg)
;;                    (>= hydra-transpose/custom-prefix-arg 0))
;;                (setq hydra-transpose/custom-prefix-arg -1))
;;            :color pink)
;;     "transpose backward"
;;     ("d" hydra-transpose/body "toggle direction" :exit t)
;;     ("f" hydra-transpose/body "forward mode" :exit t)
;;     ("b" hydra-transpose-backward/body "backward mode" :exit t)
;;     ("u" (lambda (arg)
;;            (interactive "nPrefix: ")
;;            (setq hydra-transpose/custom-prefix-arg (- (abs arg)))
;;            (message "prefix: %s" hydra-transpose/custom-prefix-arg))
;;      "prefix")
;;     ("r" (lambda ()
;;            (interactive)
;;            (setq hydra-transpose/custom-prefix-arg -1))
;;      "reset prefix")
;;     ("c" (lambda ()
;;            (interactive)
;;            (let ((current-prefix-arg
;;                   hydra-transpose/custom-prefix-arg))
;;              (call-interactively #'transpose-chars)
;;              (call-interactively #'forward-char)))
;;      "chars")
;;     ("l" (lambda ()
;;            (interactive)
;;            (let ((current-prefix-arg
;;                   hydra-transpose/custom-prefix-arg))
;;              (call-interactively #'transpose-lines)
;;              (call-interactively #'forward-line))
;;            (setq hydra-transpose/custom-prefix-arg -1))
;;      "lines")
;;     ("w" (lambda ()
;;            (interactive)
;;            (message "current-prefix: %s" hydra-transpose/custom-prefix-arg)
;;            (let ((current-prefix-arg
;;                   hydra-transpose/custom-prefix-arg))
;;              (call-interactively #'transpose-words)
;;              (call-interactively #'forward-word))
;;            (setq hydra-transpose/custom-prefix-arg -1))
;;      "words")
;;     ("s" (lambda ()
;;            (interactive)
;;            (let ((current-prefix-arg
;;                   hydra-transpose/custom-prefix-arg))
;;              (call-interactively #'transpose-sexps)
;;              (call-interactively #'forward-sexp))
;;            (setq hydra-transpose/custom-prefix-arg -1))
;;      "sexps")
;;     ("p" (lambda ()
;;            (interactive)
;;            (let ((current-prefix-arg
;;                   hydra-transpose/custom-prefix-arg))
;;              (call-interactively #'transpose-paragraphs)
;;              (call-interactively #'forward-paragraph))
;;            (setq hydra-transpose/custom-prefix-arg -1))
;;      "paragraphs")
;;     ("S" (lambda ()
;;            (interactive)
;;            (let ((current-prefix-arg
;;                   hydra-transpose/custom-prefix-arg))
;;              (call-interactively #'transpose-sentences)
;;              (call-interactively #'forward-sentence))
;;            (setq hydra-transpose/custom-prefix-arg -1))
;;      "sentences")
;;     ("e" org-transpose-element "Org mode elements")
;;     ("q" nil "quit"))

;;    (defhydra hydra-transpose
;;      (:pre (if (and (not (null hydra-transpose/custom-prefix-arg))
;;                     (< hydra-transpose/custom-prefix-arg 0))
;;                (setq hydra-transpose/custom-prefix-arg nil))
;;            :color pink)
;;      "transpose"
;;      ("d" hydra-transpose-backward/body "toggle direction" :exit t)
;;      ("f" hydra-transpose/body "forward mode" :exit t)
;;      ("b" hydra-transpose-backward/body "backward mode" :exit t)
;;      ("u" (lambda (arg)
;;             (interactive "nPrefix: ")
;;             (setq hydra-transpose/custom-prefix-arg arg))
;;       "prefix")
;;      ("r" (lambda ()
;;            (interactive)
;;            (setq hydra-transpose/custom-prefix-arg nil))
;;      "reset prefix")
;;      ("c" (lambda ()
;;             (interactive)
;;             (let ((current-prefix-arg
;;                    hydra-transpose/custom-prefix-arg))
;;               (call-interactively #'transpose-chars))
;;             (setq hydra-transpose/custom-prefix-arg nil))
;;       "chars")
;;      ("l" (lambda ()
;;             (interactive)
;;             (let ((current-prefix-arg
;;                    hydra-transpose/custom-prefix-arg))
;;               (call-interactively #'transpose-lines))
;;             (setq hydra-transpose/custom-prefix-arg nil))
;;       "lines")
;;      ("w" (lambda ()
;;             (interactive)
;;             (let ((current-prefix-arg
;;                    hydra-transpose/custom-prefix-arg))
;;               (call-interactively #'transpose-words))
;;             (setq hydra-transpose/custom-prefix-arg nil))
;;       "words")
;;      ("s" (lambda ()
;;             (interactive)
;;             (let ((current-prefix-arg
;;                    hydra-transpose/custom-prefix-arg))
;;               (call-interactively #'transpose-sexps))
;;             (setq hydra-transpose/custom-prefix-arg nil))
;;       "sexps")
;;      ("p" (lambda ()
;;             (interactive)
;;             (let ((current-prefix-arg
;;                    hydra-transpose/custom-prefix-arg))
;;               (call-interactively #'transpose-paragraphs))
;;             (setq hydra-transpose/custom-prefix-arg nil))
;;       "paragraphs")
;;      ("S" (lambda ()
;;             (interactive)
;;             (let ((current-prefix-arg
;;                    hydra-transpose/custom-prefix-arg))
;;               (call-interactively #'transpose-sentences)))
;;       "sentences")
;;      ("e" org-transpose-element "Org mode elements")
;;      ("q" nil "quit"))))

;; (global-set-key
;;  (kbd "C-x -")
;;  (defhydra hydra-resize-window ()
;;    "resize"
;;    ("l" enlarge-window "taller")
;;    ("r" shrink-window "shorter")
;;    ("n" shrink-window-horizontally "narrower")
;;    ("s" enlarge-window-horizontally "wider")
;;    ("-" shrink-window-if-larger-than-buffer "short (aggressive)")
;;    ("+" balance-windows "balance")
;;    ("q" nil "quit")))

(defhydra hydra-page (ctl-x-map "" :pre (widen))
  "page"
  ("]" forward-page "next")
  ("[" backward-page "prev")
  ("n" narrow-to-page "narrow" :bind nil :exit t)
  ("q" nil "quit"))

;; Switch windows with shift-cursors.
(windmove-default-keybindings)

;; Have completion on C-TAB, as ESC TAB is lame.
(global-set-key (kbd "<C-tab>") 'completion-at-point)

;; (define-prefix-command 'endless/toggle-map)
;; ;; The manual recommends C-c for user keys, but C-x t is
;; ;; always free, whereas C-c t is used by some modes.
;; (define-key ctl-x-map "t" 'endless/toggle-map)
;; (define-key endless/toggle-map "c" #'column-number-mode)
;; (define-key endless/toggle-map "d" #'toggle-debug-on-error)
;; (define-key endless/toggle-map "e" #'toggle-debug-on-error)
;; (define-key endless/toggle-map "f" #'auto-fill-mode)
;; (define-key endless/toggle-map "l" #'toggle-truncate-lines)
;; (define-key endless/toggle-map "q" #'toggle-debug-on-quit)
;; ;(define-key endless/toggle-map "t" #'endless/toggle-theme)
;; ;;; Generalized version of `read-only-mode'.
;; (define-key endless/toggle-map "r" #'dired-toggle-read-only)
;; (autoload 'dired-toggle-read-only "dired" nil t)
;; (define-key endless/toggle-map "w" #'whitespace-mode)

;; (global-set-key
;;  (kbd "C-x t")
;;  (defhydra hydra-toggle (:color teal)
;;    "toggle"
;;    ("c" column-number-mode "column number mode")
;;    ("d" toggle-debug-on-error "debug on error")
;;    ("e" toggle-debug-on-error "debug on error")
;;    ("f" auto-fill-mode "auto-fill mode")
;;    ("t" toggle-truncate-lines "truncate lines")
;;    ("Q" toggle-debug-on-quit "debug on quit")
;;    ("r" dired-toggle-read-only "dired: read-only")
;;    ("w" whitespace-mode "whitespace mode")
;;    ("q" nil "quit")))

;; (global-set-key (kbd "M-o") 'occur)

;; (global-set-key (kbd "C-x C-b") 'ibuffer-other-window)

;; (global-set-key (kbd "M-j") 'eval-print-last-sexp)

(misc/buffer-switch-hydra hydra-irc "channel" "C-c i"
  ("n" "#neo" "neo")
  ("e" "#emacs" "emacs")
  ("f" "irc.freenode.net:6667" "freenode"))

(provide 'setup-keybindings)
