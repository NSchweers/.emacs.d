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
            (flyspell-mode 1)))

;; (defvar org-custom/org-environment )

;; (defun org-custom/org-environment (arg)
;;   (interactive "*p")
;;   (let ((environment (completing-read (concat "Environment type: (default "
;;                                               org-custom/default-environment))))))

(provide 'setup-org)
