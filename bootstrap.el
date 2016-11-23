
(setf lexical-binding t)

;; NOTE: THIS FILE WAS TANGLED FROM literate-init.org.  DO NOT CHANGE THIS FILE
;; DIRECTLY!

(defun load-literate-init ()
  "Tangles, compiles and loads the literate init file."
  (interactive)
  (require 'org)
  (let* ((lit-name
          (expand-file-name "literate-init.org" user-emacs-directory))
         (el-name (expand-file-name "literate-init.el" user-emacs-directory))
         (elc-name (expand-file-name "literate-init.elc" user-emacs-directory)))
    (when (or (not (file-exists-p el-name))
              (time-less-p (nth 4 (file-attributes el-name))
                           (nth 4 (file-attributes lit-name))))
      (org-babel-tangle-file lit-name))
    (when (or (not (file-exists-p elc-name))
              (time-less-p (nth 4 (file-attributes elc-name))
                           (nth 4 (file-attributes el-name))))
      (byte-compile-file el-name))
    (load elc-name)))
