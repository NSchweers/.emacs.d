;; -*- lexical-binding: t -*-

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

(defun schweers/lispinline ()
  "Insert a `lispinline' lstlisting at point."
  (interactive)
  (goto-char
   (save-mark-and-excursion
    (let ((beg (point)))
      (insert "\\begin{lstlisting}[style=lispinline]\n\n\\end{lstlisting}")
      (let ((end (point)))
        (goto-char beg)
        (fill-paragraph)
        (goto-char end)
        (forward-line -1)
        (point))))))

(defun schweers/lispcode (caption label)
  "Insert a `lispcode' lstlisting at point."
  (interactive "MCaption: \nMLabel: ")
  (goto-char
   (save-mark-and-excursion
    (let ((beg (point)))
      (insert
       (format
        "\\begin{lstlisting}%s\n\n%s"
        (format "[style=lispcode,label={%s},caption={%s},numbers=left]"
                label caption)
        "\\end{lstlisting}"))
      (let ((end (point)))
        (goto-char beg)
        (fill-paragraph)
        (goto-char end)
        (forward-line -1)
        (point))))))

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
            "subsubsec:")
      (outline-minor-mode 1)))))

;;; Why the hell is it called tex-site?

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
