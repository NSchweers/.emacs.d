(if (eq system-type 'windows-nt)
    (setq inferior-lisp-program
          "sbcl"))

(provide 'setup-slime)
