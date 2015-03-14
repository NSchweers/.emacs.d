(cond ((eq system-type 'windows-nt)
       (setq inferior-lisp-program "sbcl"))
      ((eq system-type 'gnu/linux)
       (setq inferior-lisp-program "sbcl")))

(provide 'setup-slime)
