(setq inhibit-startup-message t)

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

;; Set up appearance early.  
(require 'appearance)

(require 'setup-package)
(require 'misc)

;; Write backup files to a sepatate directory.
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups" user-emacs-directory))))
;; Make backups of files, even when the're in version control.
(setq vc-make-backup-files t)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

(require 'sane-defaults)

(with-demoted-errors
  (require 'guide-key)
  (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x 5" "C-x v" "C-x 8"
                                       "C-x n"))
  (guide-key-mode 1)
  (setq guide-key/recursive-key-sequence-flag t)
  (setq guide-key/popup-window-position 'bottom)
  (setq guide-key/idle-delay 0.1))

;; Setup extensions
(with-demoted-errors (eval-after-load 'ido '(require 'setup-ido)))
(with-demoted-errors (eval-after-load 'shell '(require 'setup-shell)))
(with-demoted-errors (require 'setup-paredit))
(with-demoted-errors (require 'setup-autocomplete))
(with-demoted-errors (require 'setup-magit))
(eval-after-load "dash" '(dash-enable-font-lock))
(with-demoted-errors (require 'browse-kill-ring))
(with-demoted-errors (require 'smex)
                     (smex-initialize))
(require 'setup-keybindings)
(with-demoted-errors (require 'setup-elpy))
(with-demoted-errors (require 'setup-mc16basm))
(with-demoted-errors (require 'setup-ace-window))
(with-demoted-errors (require 'setup-org))
(require 'setup-ispell)
(require 'setup-auctex)
(with-demoted-errors (load (expand-file-name "gnus.el" user-emacs-directory)))
(with-demoted-errors (require 'setup-multiple-cursors))
(with-demoted-errors (require 'setup-erc))

(require 'server)
(unless (server-running-p)
  (server-start))
