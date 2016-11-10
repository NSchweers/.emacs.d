;; -*- lexical-binding: t -*-

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq inhibit-startup-message t)
;; (setq user-init-file (buffer-file-name))

;; For Emacs 24.4 to prevent loading outdated compiled files
(setq load-prefer-newer t)

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

;; Add our dir for code to the load-path, so code from there can be required.  
(add-to-list 'load-path (expand-file-name "code" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))
;; (dolist (d '("site-lisp/mc16basm" "site-lisp/mc16bemu"))
;;   (add-to-list 'load-path (expand-file-name d user-emacs-directory)))

(require 'cl-lib)
;(require 'use-package)

;; (add-to-list 'load-path (expand-file-name "site-lisp/mc16basm"
;;                                           user-emacs-directory))
;; (add-to-list 'load-path (expand-file-name "site-lisp/mc16bemu"
;;                                           user-emacs-directory))

(defmacro load-lisp-from-path (&rest files)
  "Load files (strings or symbols) and execute forms (everything else)."
  (declare (indent 0))
  (let ((code '(progn)))
    (dolist (f files (reverse code))
      (cond ((symbolp f)
             (push `(with-demoted-errors (load ,(symbol-name f))) code))
            ((stringp f) (push `(with-demoted-errors (load ,f)) code))
            ((consp f) (push `(with-demoted-errors ,f) code))
            (t
             (error
              "%s is neither a literal string, literal symbol, nor a list."
              f))))))

(load-lisp-from-path
  setup-lisp-common
  appearance
  sane-defaults
  setup-package
  (pc f)
  (pc json-mode)
  ;; (install-my-packages)
  ;; (require 'use-package)
  (require 'pc)
  setup-dash
  setup-shell
  setup-hydra
  misc
  saveplace
  ;; setup-evil
  setup-guide-keys
  setup-lispy
  setup-autocomplete
  setup-magit
  setup-keybindings
  setup-elpy
  setup-ace-window
  setup-org
  setup-ispell
  setup-auctex
  setup-bbdb
  setup-gnus
  setup-multiple-cursors
  setup-erc
  setup-ace-link
  setup-browse-kill-ring
  setup-slime
  setup-geiser
  setup-expand-region
  setup-eldoc
  setup-jabber-otr
  setup-helm
  setup-ace-jump-mode
  setup-clhs
  setup-gud
  setup-dired
  setup-forth
  setup-undo-tree
  setup-diminish
  setup-clojure
  setup-projectile
  setup-paren-face
  setup-w3m
  setup-markdown
  setup-elfeed
  setup-binding-mode)

(require 'server)
(unless (server-running-p)
  (server-start))
