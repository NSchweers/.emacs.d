;; -*- lexical-binding: t -*-

(defun setup-org/define-newline-keys ()
  (define-key org-mode-map (kbd "RET") 'org-return-indent)
  (define-key org-mode-map (kbd "C-j") 'org-return))

;(add-hook 'org-mode-hook 'misc/set-kill-and-delete-keys)
;(add-hook 'org-mode-hook 'setup-org/define-newline-keys)

;;; This line is a fallback for mode selection, so org-mode is the new default,
;;; instead of fundamental-mode (which sucks).  
;(add-to-list 'magic-fallback-mode-alist '((lambda () t) . org-mode))

(setq org-default-notes-file
      (expand-file-name "notes.org" user-emacs-directory))

;; (require 'org-latex)

;; org-export-latex-classes
;; org-latex-classes

(with-demoted-errors
  (require 'ox-latex)

  (add-hook 'org-mode-hook
            #'(lambda ()
                (add-to-list 'org-latex-classes
                             '("IEEEtran"
                               "\\documentclass[conference]{IEEEtran}"
                               ("\\section{%s}" . "\\section*{%s}")
                               ("\\subsection{%s}" . "\\subsection*{%s}")
                               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                               ("\\paragraph{%s}" . "\\paragraph*{%s}")
                               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
                (flyspell-mode 1))))

(setq org-latex-listings 'minted)
;; (add-to-list 'org-latex-packages-alist '("" "listings"))
;; (add-to-list 'org-latex-packages-alist '("" "color"))
(add-to-list 'org-latex-packages-alist '("" "minted"))

(setf
 org-latex-pdf-process
 '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
   "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
   "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(add-to-list 'org-structure-template-alist '("C" "#+BEGIN_COMMENT\n?\n#+END_COMMENT"))

(setq org-capture-templates
      `(("t" "Task" entry
         (file+headline ,org-default-notes-file
                        "Tasks")
         "* TODO %?\n  %i\n  %t\n  %a")
        ("n" "Notes" entry
         (file+headline ,org-default-notes-file
                        "Notes")
         "* %?\n  %i\n  %t\n  %a")))

(global-set-key (kbd "C-c c") 'org-capture)

(defun schweers/find-file-org-advice (&rest _args)
  "If the file we just opened is in fundamental-mode, switch to org-mode."
  (if (eq major-mode 'fundamental-mode)
      (org-mode)))

(defun schweers/switch-to-buffer-org-advice (real-fun &rest args)
  "Make org-mode the new default mode."
  (if (or (not (called-interactively-p 'interactive))
          (not (default-boundp 'major-mode)))
      (apply 'funcall real-fun args)
    (let ((backup (default-value 'major-mode)))
      (unwind-protect
          (progn
            (setq-default major-mode 'org-mode)
            (apply 'funcall real-fun args))
        (setq-default major-mode backup)))))

;; (advice-add 'find-file :after #'schweers/find-file-org-advice)

;; (advice-add 'switch-to-buffer :around #'schweers/switch-to-buffer-org-advice)

(define-key org-mode-map (kbd "C-c <")
  (defhydra hydra-org-blocks (:color blue)
    "Insert Org Mode source code blocks"
    ("s" (progn (insert "<s")
                (call-interactively #'org-cycle))
     "Generic Org Mode source block")
    ("e" (progn (insert "<s")
                (call-interactively #'org-cycle)
                (insert "emacs-lisp")
                (forward-line 1)
                (call-interactively #'org-cycle)))
    ("q" nil "quit")))

(defun schweers/org-TeX-string (beg end &optional point)
  "Insert a pair of TeX string delimiters (`` and '').

Put these back to back with point between them, or around the region, if
active.  Extend the region to contain the new delimiters too."
  (interactive "rd")
  (unless point
    (setf point (point)))
  (if (not (use-region-p))
      (progn
        (insert "``''")
        (backward-char 2))
    (let ((at-beginning-p (= beg point)))
      (goto-char end)
      (insert "''")
      (when at-beginning-p
        (push-mark (point)))
      (goto-char beg)
      (insert "``")
      (if at-beginning-p
          (backward-char 2)
        (push-mark (- (point) 2))
        (goto-char (+ 4 end)))
      (setf deactivate-mark nil))))

(define-key org-mode-map (kbd "M-\"") #'schweers/org-TeX-string)

(provide 'setup-org)

;; (defun my-org/fund-to-org (f &rest args)
;;   (apply f args)
;;   (when (eq (buffer-local-value 'major-mode (current-buffer))
;;             'fundamental-mode)
;;     (org-mode)))

;; (defun my-org/switch-to-org (f &rest args)
;;   (let ((b (apply f args)))
;;     (if (eq (buffer-local-value 'major-mode b)
;;             'fundamental-mode)
;;         (with-current-buffer b
;;           (org-mode)))
;;     b))

;; (defun misc/normal-mode-after-switch (f &rest args)
;;   )

;; (advice-add 'normal-mode :around #'my-org/fund-to-org)
;; (advice-remove 'normal-mode #'fund-to-org)

;; (advice-add 'normal-mode :around #'my-org/switch-to-org)
;; (advice-remove 'normal-mode #'my-org/switch-to-org)

 ;; -- Function: advice-add symbol where function &optional props
 ;;     Add the advice FUNCTION to the named function SYMBOL.  WHERE and
 ;;     PROPS have the same meaning as for `add-function' (*note Core
 ;;     Advising Primitives::).
