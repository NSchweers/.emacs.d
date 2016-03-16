;; -*- lexical-binding: t -*-

(setq inhibit-startup-message t)
(setq user-init-file (buffer-file-name))

;; For Emacs 24.4 to prevent loading outdated compiled files
(setq load-prefer-newer t)

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

;; Add our dir for code to the load-path, so code from there can be required.  
(add-to-list 'load-path (expand-file-name "code" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))
(dolist (d '("site-lisp/mc16basm" "site-lisp/mc16bemu"))
  (add-to-list 'load-path (expand-file-name d user-emacs-directory)))

(require 'cl-lib)
;(require 'use-package)

;; (add-to-list 'load-path (expand-file-name "site-lisp/mc16basm"
;;                                           user-emacs-directory))
;; (add-to-list 'load-path (expand-file-name "site-lisp/mc16bemu"
;;                                           user-emacs-directory))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; (defmacro load-lisp-from-path (&rest files)
;;   "Load all files in FILES with demoted errors."
;;   `(dolist (f ',files)
;;      (with-demoted-errors (load (if (symbolp f) (symbol-name f) f)))))


;; Write backup files to a sepatate directory.
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups" user-emacs-directory))))
;; Make backups of files, even when the're in version control.
(setq vc-make-backup-files t)

(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

(defmacro load-lisp-from-path (&rest files)
  (declare (indent 0))
  (let ((code '(progn)))
    (dolist (f files (reverse code))
      (cond ((symbolp f) (push `(with-demoted-errors (load ,(symbol-name f))) code))
            ((stringp f) (push `(with-demoted-errors (load ,f)) code))
            ((consp f) (push `(with-demoted-errors ,f) code))
            (t
             (error
              "%s is neither a literal string, literal symbol, nor a list."
              f))))))

(load-lisp-from-path
  appearance
  setup-package
  (require 'use-package)
  (eval-after-load "dash" '(dash-enable-font-lock))
  (require 'dash)
  (require 'dash-functional)
  (require 'hydra)
  misc
  saveplace
  sane-defaults
  ;; setup-evil
  setup-guide-keys
  ;; setup-paredit
  setup-lispy
  setup-autocomplete
  setup-magit
  setup-monky
  setup-keybindings
  setup-elpy
  setup-ace-window
  setup-org
  setup-ispell
  setup-auctex
  setup-bbdb
  setup-gnus
  ;;  setup-wanderlust
  setup-multiple-cursors
  setup-erc
  setup-ace-link
  setup-browse-kill-ring
  setup-slime
  setup-expand-region
;;  setup-names
  setup-eldoc
  setup-jabber-otr
  setup-helm
  setup-ace-jump-mode
  setup-clhs
  setup-gud
  ;;  setup-emms
  setup-dired
  setup-forth
  setup-binding-mode)

(require 'server)
(unless (server-running-p)
  (server-start))
