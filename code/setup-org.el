;; -*- lexical-binding: t -*-

(defun setup-org/define-newline-keys ()
  (define-key org-mode-map (kbd "RET") 'org-return-indent)
  (define-key org-mode-map (kbd "C-j") 'org-return))

(add-hook 'org-mode-hook 'misc/set-kill-and-delete-keys)
;(add-hook 'org-mode-hook 'setup-org/define-newline-keys)

;;; This line is a fallback for mode selection, so org-mode is the new default,
;;; instead of fundamental-mode (which sucks).  
(add-to-list 'magic-fallback-mode-alist '((lambda () t) . org-mode))



(setq org-default-notes-file
      (expand-file-name "notes.org" user-emacs-directory))

;; (require 'org-latex)

;; org-export-latex-classes
;; org-latex-classes

(with-demoted-errors
  (require 'ox-latex)

  (add-hook 'org-mode-hook
            (lambda ()
              (add-to-list 'org-latex-classes
                           '("IEEEtran"
                             "\\documentclass[conference]{IEEEtran}"
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                             ("\\paragraph{%s}" . "\\paragraph*{%s}")
                             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
              (flyspell-mode 1))))

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
