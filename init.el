;; -*- lexical-binding: t -*-


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; (require 'org)

;; (defun missing-or-newer? (a b)
;;   "Checks whether the file A exists.  If so, checks whether file B exists and is
;;   older than A."
;;   (or (not (file-exists-p a))
;;       (and (file-exists-p b)
;;            (time-less-p
;;             (nth 5 (file-attributes a))
;;             (nth 5 (file-attributes b))))))

;; (let* ((literate (expand-file-name "literate-init.org" user-emacs-directory))
;;        (el (expand-file-name "literate-init.el" user-emacs-directory)))

;;   (when (missing-or-newer? el literate)
;;     (org-babel-tangle-file literate))
;;   (load el))

;; (condition-case nil
;;     (load (expand-file-name "bootstrap.el" user-emacs-directory))
;;   (file-error (org-babel-load-file
;;                (expand-file-name "literate-init.org" user-emacs-directory))))
;; (load-literate-init)

(message "Tangle literate init file if necessary ...")

(with-temp-buffer
  (call-process "emacs" nil (current-buffer) nil
                "-Q" "--batch" "-l"
                (expand-file-name "tangle.el" user-emacs-directory))
  (message "%s" (buffer-string)))

(let* ((literate (expand-file-name "literate-init.org" user-emacs-directory))
       (el (expand-file-name "literate-init.el" user-emacs-directory)))

  (load el))
