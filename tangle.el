(require 'org)

(defun missing-or-newer? (a b)
  "Checks whether the file A exists.  If so, checks whether file B exists and is
  older than A."
  (or (not (file-exists-p a))
      (and (file-exists-p b)
           (time-less-p
            (nth 5 (file-attributes a))
            (nth 5 (file-attributes b))))))

(let* ((literate (expand-file-name "literate-init.org" user-emacs-directory))
       (el (expand-file-name "literate-init.el" user-emacs-directory)))

  (when (missing-or-newer? el literate)
    (org-babel-tangle-file literate)))
