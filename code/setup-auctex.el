;; -*- lexical-binding: t -*-

;;; Why the hell is it called tex-site?

(defun schweers/LaTeX-put-lisp-block (caption label)
  (interactive "*MCaption: \nMLabel: ")
  (let ((create-par? (not (and (looking-at-p "$")
                               (looking-back "^" (max (- (point) 2) 1))))))
    (when create-par?
      (insert "\n\n"))
    (insert "\\begin{lstlisting}[style=lispcode")
    (when caption
      (insert ",caption={" caption "}"))
    (when label
      (insert ",label={" label "}"))
    (insert "}\n\\end{lstlisting}")
    (when create-par?
      (insert "\n"))
    (beginning-of-line (if create-par? -2 -3))
    (insert "\n")))

(pc auctex
  (:require nil)
  (:post-install
   (setf LaTeX-command "latex")
   (add-hook
    'LaTeX-mode-hook
    (lambda ()
      (TeX-PDF-mode)
      ;; (push '(pdf . pdfsync)
      ;;       TeX-source-correlate-method)
      (define-key LaTeX-mode-map
        [remap backward-delete-char]
        'delete-backward-char)
      (define-key LaTeX-mode-map (kbd "M-\"")
        #'schweers/org-TeX-string)
      (TeX-source-correlate-mode 1)
      (flyspell-mode 1)
      (setf (cdr (assoc "subsection"
                        LaTeX-section-label))
            "subsec:"
            (cdr (assoc "subsubsection"
                        LaTeX-section-label))
            "subsubsec:")))))

;; (use-package tex-site
;;   :ensure auctex
;;   :config
;;   ;; (add-hook 'LaTeX-mode-hook 'misc/set-kill-and-delete-keys)
;;   ;; (push '(pdf . pdfsync) TeX-source-correlate-method)
;;   (add-hook 'LaTeX-mode-hook (lambda ()
;;                                (TeX-PDF-mode)
;;                                ;; (push '(pdf . pdfsync)
;;                                ;;       TeX-source-correlate-method)
;;                                (define-key LaTeX-mode-map
;;                                  [remap backward-delete-char]
;;                                  'delete-backward-char)
;;                                (define-key LaTeX-mode-map (kbd "M-\"")
;;                                  #'schweers/org-TeX-string)
;;                                (TeX-source-correlate-mode 1)))
;;   (add-hook 'LaTeX-mode-hook 'flyspell-mode))

(provide 'setup-auctex)
