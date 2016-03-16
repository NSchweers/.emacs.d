;; -*- lexical-binding: t -*-

(use-package jabber
  :config
  (cond ((car (file-attributes "/usr/lib/python2.7/site-packages/potr/"))
                                        ;potr is installed
         (cond
          ((and (file-readable-p (expand-file-name
                                  "site-lisp/jabber-otr/emacs-otr.py"
                                  user-emacs-directory))
                (file-executable-p (expand-file-name
                                    "site-lisp/jabber-otr/emacs-otr.py"
                                    user-emacs-directory))
                (file-readable-p (expand-file-name
                                  "site-lisp/jabber-otr/jabber-otr.el"
                                  user-emacs-directory)))
                                        ;jabber-otr is installed
           (load (expand-file-name "site-lisp/jabber-otr/jabber-otr.el"
                                   user-emacs-directory)))
          (t                            ;jabber-otr is not installed
           (error
            (s-concat "As jabber-otr is not installed or executable"
                      ", jabber-otr will not work. ")))))
        (t                              ;potr is not installed
         (error "as python-potr is not installed, jabber-otr will not work"))))

(provide 'setup-jabber-otr)
