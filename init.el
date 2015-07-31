;; -*- lexical-binding: t -*-

(require 'cl)

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
  (require 'hydra)
  misc
  saveplace
  sane-defaults
  setup-guide-keys
  setup-paredit
  setup-autocomplete
  setup-magit
  (eval-after-load "dash" '(dash-enable-font-lock))
  setup-keybindings
  setup-elpy
  setup-ace-window
  setup-org
  setup-ispell
  setup-auctex
  setup-bbdb
  setup-gnus
  setup-wanderlust
  setup-multiple-cursors
  setup-erc
  setup-ace-link
  setup-browse-kill-ring
  setup-slime
  setup-expand-region
  setup-names
  setup-eldoc
  setup-jabber-otr
  setup-helm
  setup-ace-jump-mode
  setup-clhs
  setup-gud
  setup-emms
  setup-dired
  setup-binding-mode)

;; ;; Set up appearance early.  
;; (require 'appearance)

;; (require 'setup-package)
;; (require 'misc)

;; ;; Write backup files to a sepatate directory.
;; (setq backup-directory-alist
;;       `(("." . ,(expand-file-name "backups" user-emacs-directory))))
;; ;; Make backups of files, even when the're in version control.
;; (setq vc-make-backup-files t)

;; ;; Save point position between sessions
;; (require 'saveplace)
;; (setq-default save-place t)
;; (setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; (require 'sane-defaults)

;; ;; (with-demoted-errors
;; ;;   (require 'guide-key)
;; ;;   (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x 5" "C-x v" "C-x 8"
;; ;;                                        "C-x n" "C-c C-x"))
;; ;;   (guide-key-mode 1)
;; ;;   (setq guide-key/recursive-key-sequence-flag t)
;; ;;   (setq guide-key/popup-window-position 'bottom)
;; ;;   (setq guide-key/idle-delay 0.1))

;; (with-demoted-errors (require 'setup-guide-keys))

;; ;; Setup extensions
;; ;(with-demoted-errors (eval-after-load 'ido '(require 'setup-ido)))
;; (with-demoted-errors (eval-after-load 'shell '(require 'setup-shell)))
;; (with-demoted-errors (require 'setup-paredit))
;; (with-demoted-errors (require 'setup-autocomplete))
;; (with-demoted-errors (require 'setup-magit))
;; (eval-after-load "dash" '(dash-enable-font-lock))
;; (with-demoted-errors (require 'smex)
;;                      (smex-initialize))
;; (require 'setup-keybindings)
;; (with-demoted-errors (require 'setup-elpy))
;; ;(with-demoted-errors (require 'setup-mc16basm))
;; (with-demoted-errors (require 'setup-ace-window))
;; (with-demoted-errors (require 'setup-org))
;; (require 'setup-ispell)
;; (require 'setup-auctex)
;; ;(with-demoted-errors (load (expand-file-name "gnus.el" user-emacs-directory)))
;; (with-demoted-errors (require 'setup-gnus))
;; (with-demoted-errors (require 'setup-bbdb))
;; (with-demoted-errors (require 'setup-multiple-cursors))
;; (with-demoted-errors (require 'setup-erc))
;; (with-demoted-errors (require 'setup-ace-link))
;; (with-demoted-errors (require 'setup-browse-kill-ring))
;; (with-demoted-errors (require 'setup-slime))
;; ;(with-demoted-errors (require 'setup-wanderlust))
;; (with-demoted-errors (require 'setup-expand-region))
;; (with-demoted-errors (require 'setup-names))
;; (with-demoted-errors (require 'setup-eldoc))
;; (with-demoted-errors (require 'setup-jabber-otr))
;; (with-demoted-errors (require 'setup-helm))

(require 'server)
(unless (server-running-p)
  (server-start))
