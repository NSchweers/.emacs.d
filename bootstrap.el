;; -*- lexical-binding: t-*-

;; [[file:~/.emacs.d/literate-init.org::*Boot%20up%20with%20our%20literate%20config][Boot\ up\ with\ our\ literate\ config:1]]

;; NOTE: THIS FILE WAS TANGLED FROM literate-init.org.  DO NOT CHANGE THIS FILE
;; DIRECTLY!

;; I need a macro which abstracts some checks:

;; If a file is missing, or is newer than some other file, I want to perform an
;; action.  Said action should rectify the previous check.  If the check at the
;; beginning does not hold, the supplied action must be performed.  If the same
;; check does not hold /after/ the action is performed, an error shall be
;; thrown.

;; Example usage:

;; (with-postcond (or (not (file-exists-p el-name))
;;                    (time-less-p (nth 5 (file-attributes el-name))
;;                                 (nth 5 (file-attributes lit-name))))
;;     (signal 'postcondition-error)
;;   (org-babel-tangle-file lit-name))

(defmacro ensure (condition error-clause fixup &rest body)
  "Tries to ensure that CONDITION holds.

This is accomplished by a series of steps.  First, CONDITION is
checked.  If it holds, the form returns.  If not, body is
executed.  Then CONDITION is checked again.  If it holds, the form
returns.  If the check returns nil, or the body signalled any
error, the fixup function is tried (if non-nil and a function).
The fixup function is given either the error, or nil if none was
signalled.

Then the check is tried again.  If it now holds, the form
returns.  If not, body is tried once more.  If it signals an
error again, it is presumed to be non-recoverable by this macro,
so the error-clause is executed.  If the check does not hold, the
error-clause is executed.

As FIXUP must be a function, the form is evaluated exactly once."
  (declare (indent 3))
  (when (or (null condition)
            (null error-clause))
    (error "Postcondition or Error-clause is missing"))
  (let ((f (make-symbol "f"))
        (e (make-symbol "e")))
    `(let ((,f ,fixup))
       (unless ,condition
         (condition-case ,e ,@body
           (error (if ,f (progn
                           (funcall ,f ,e)
                           ,@body)
                    (signal (car ,e) (cdr ,e)))))
         (unless ,condition
           (when ,f
             (funcall ,f nil))
           (unless ,condition
             ,@body
             (unless ,condition
               ,error-clause)))))))

;; To make the aforementioned macro a little more useful for my case, I need
;; another function, which serves as a sort of predicate.  It checks whether the
;; first given filename exists, then whether the first is newer than the second.

(defun missing-or-newer? (a b)
  "Checks whether the file A exists.  If so, checks whether file B exists and is
older than A."
  (or (not (file-exists-p a))
      (and (file-exists-p b)
           (time-less-p
            (nth 5 (file-attributes a))
            (nth 5 (file-attributes b))))))

(defun load-literate-init ()
  "Tangles, compiles and loads the literate init file."
  (interactive)
  ;; (require 'org)
  (let ((lit-name
         (expand-file-name "literate-init.org" user-emacs-directory))
        (el-name (expand-file-name "literate-init.el" user-emacs-directory))
        (elc-name (expand-file-name "literate-init.elc" user-emacs-directory)))
    (ensure (not (missing-or-newer? el-name lit-name))
        (error "Could not tangle the literal init file")
        nil
      (org-babel-tangle-file lit-name))
    (ensure (not (missing-or-newer? elc-name el-name))
        (error "Could not byte-compile literal init, even after loading it.")
        (lambda (_e)
          (warn "Need to load non-compiled init file")
          (load el-name))
      (byte-compile-file el-name))
    (load elc-name)))

;; Boot\ up\ with\ our\ literate\ config:1 ends here
