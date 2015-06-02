;; -*- lexical-binding: t -*-

(defvar *schweers-bindings* (make-sparse-keymap))

(define-key *schweers-bindings* (kbd "C-w") 'backward-kill-word)
(define-key *schweers-bindings* (kbd "C-c C-w") 'kill-region)
(define-key *schweers-bindings* (kbd "C-c C-a") 'kill-region)
(define-key *schweers-bindings* (kbd "C-h") 'delete-backward-char)
(define-key *schweers-bindings* (kbd "<f1>") 'help-command)
(define-key *schweers-bindings*
  (kbd "M-t")
  (let ((hydra-transpose/custom-prefix-arg nil))
    (defhydra hydra-transpose-backward
      (:pre (if (or (null hydra-transpose/custom-prefix-arg)
                    (>= hydra-transpose/custom-prefix-arg 0))
                (setq hydra-transpose/custom-prefix-arg -1))
            :color pink)
      "transpose backward"
      ("d" hydra-transpose/body "toggle direction" :exit t)
      ("f" hydra-transpose/body "forward mode" :exit t)
      ("b" hydra-transpose-backward/body "backward mode" :exit t)
      ("u" (lambda (arg)
             (interactive "nPrefix: ")
             (setq hydra-transpose/custom-prefix-arg (- (abs arg)))
             (message "prefix: %s" hydra-transpose/custom-prefix-arg))
       "prefix")
      ("r" (lambda ()
             (interactive)
             (setq hydra-transpose/custom-prefix-arg -1))
       "reset prefix")
      ("c" (lambda ()
             (interactive)
             (let ((current-prefix-arg
                    hydra-transpose/custom-prefix-arg))
               (call-interactively #'transpose-chars)
               (call-interactively #'forward-char)))
       "chars")
      ("l" (lambda ()
             (interactive)
             (let ((current-prefix-arg
                    hydra-transpose/custom-prefix-arg))
               (call-interactively #'transpose-lines)
               (call-interactively #'forward-line))
             (setq hydra-transpose/custom-prefix-arg -1))
       "lines")
      ("w" (lambda ()
             (interactive)
             (message "current-prefix: %s" hydra-transpose/custom-prefix-arg)
             (let ((current-prefix-arg
                    hydra-transpose/custom-prefix-arg))
               (call-interactively #'transpose-words)
               (call-interactively #'forward-word))
             (setq hydra-transpose/custom-prefix-arg -1))
       "words")
      ("s" (lambda ()
             (interactive)
             (let ((current-prefix-arg
                    hydra-transpose/custom-prefix-arg))
               (call-interactively #'transpose-sexps)
               (call-interactively #'forward-sexp))
             (setq hydra-transpose/custom-prefix-arg -1))
       "sexps")
      ("p" (lambda ()
             (interactive)
             (let ((current-prefix-arg
                    hydra-transpose/custom-prefix-arg))
               (call-interactively #'transpose-paragraphs)
               (call-interactively #'forward-paragraph))
             (setq hydra-transpose/custom-prefix-arg -1))
       "paragraphs")
      ("S" (lambda ()
             (interactive)
             (let ((current-prefix-arg
                    hydra-transpose/custom-prefix-arg))
               (call-interactively #'transpose-sentences)
               (call-interactively #'forward-sentence))
             (setq hydra-transpose/custom-prefix-arg -1))
       "sentences")
      ("e" org-transpose-element "Org mode elements")
      ("q" nil "quit"))

   (defhydra hydra-transpose
     (:pre (if (and (not (null hydra-transpose/custom-prefix-arg))
                    (< hydra-transpose/custom-prefix-arg 0))
               (setq hydra-transpose/custom-prefix-arg nil))
           :color pink)
     "transpose"
     ("d" hydra-transpose-backward/body "toggle direction" :exit t)
     ("f" hydra-transpose/body "forward mode" :exit t)
     ("b" hydra-transpose-backward/body "backward mode" :exit t)
     ("u" (lambda (arg)
            (interactive "nPrefix: ")
            (setq hydra-transpose/custom-prefix-arg arg))
      "prefix")
     ("r" (lambda ()
           (interactive)
           (setq hydra-transpose/custom-prefix-arg nil))
     "reset prefix")
     ("c" (lambda ()
            (interactive)
            (let ((current-prefix-arg
                   hydra-transpose/custom-prefix-arg))
              (call-interactively #'transpose-chars))
            (setq hydra-transpose/custom-prefix-arg nil))
      "chars")
     ("l" (lambda ()
            (interactive)
            (let ((current-prefix-arg
                   hydra-transpose/custom-prefix-arg))
              (call-interactively #'transpose-lines))
            (setq hydra-transpose/custom-prefix-arg nil))
      "lines")
     ("w" (lambda ()
            (interactive)
            (let ((current-prefix-arg
                   hydra-transpose/custom-prefix-arg))
              (call-interactively #'transpose-words))
            (setq hydra-transpose/custom-prefix-arg nil))
      "words")
     ("s" (lambda ()
            (interactive)
            (let ((current-prefix-arg
                   hydra-transpose/custom-prefix-arg))
              (call-interactively #'transpose-sexps))
            (setq hydra-transpose/custom-prefix-arg nil))
      "sexps")
     ("p" (lambda ()
            (interactive)
            (let ((current-prefix-arg
                   hydra-transpose/custom-prefix-arg))
              (call-interactively #'transpose-paragraphs))
            (setq hydra-transpose/custom-prefix-arg nil))
      "paragraphs")
     ("S" (lambda ()
            (interactive)
            (let ((current-prefix-arg
                   hydra-transpose/custom-prefix-arg))
              (call-interactively #'transpose-sentences)))
      "sentences")
     ("e" org-transpose-element "Org mode elements")
     ("q" nil "quit"))))

(define-key *schweers-bindings*
  (kbd "C-x -")
  (defhydra hydra-resize-window ()
    "resize"
    ("l" enlarge-window "taller")
    ("r" shrink-window "shorter")
    ("n" shrink-window-horizontally "narrower")
    ("s" enlarge-window-horizontally "wider")
    ("-" shrink-window-if-larger-than-buffer "short (aggressive)")
    ("+" balance-windows "balance")
    ("q" nil "quit")))

(define-key *schweers-bindings*
  (kbd "C-x t")
  (defhydra hydra-toggle (:color teal)
    "toggle"
    ("c" column-number-mode "column number mode")
    ("d" toggle-debug-on-error "debug on error")
    ("e" toggle-debug-on-error "debug on error")
    ("f" auto-fill-mode "auto-fill mode")
    ("t" toggle-truncate-lines "truncate lines")
    ("Q" toggle-debug-on-quit "debug on quit")
    ("r" dired-toggle-read-only "dired: read-only")
    ("w" whitespace-mode "whitespace mode")
    ("q" nil "quit")))

(define-key *schweers-bindings* (kbd "M-o") 'occur)
(define-key *schweers-bindings* (kbd "C-x C-b") 'ibuffer-other-window)
(define-key *schweers-bindings* (kbd "M-j") 'eval-print-last-sexp)

(define-minor-mode schweers-bindings-mode
  "This minor mode binds my own keybindings."
  :keymap *schweers-bindings*)

(define-globalized-minor-mode schweers-global-bindings-mode
  schweers-bindings-mode schweers-bindings-mode)

;;; Turn it on, already
(schweers-global-bindings-mode)

(provide 'setup-binding-mode)