;; -*- lexical-binding: t -*-
(require 'package)

;; Add melpa to package repos
(dolist (m '(("melpa-stable" . "http://stable.melpa.org/packages/")
             ("melpa" . "http://melpa.org/packages/")))
  (unless (member m package-archives)
    (add-to-list 'package-archives m t)))

(package-initialize)

(unless (file-exists-p (expand-file-name
                        "elpa/archives/melpa"
                        user-emacs-directory))
  (package-refresh-contents))

;; first install dash if it isn't yet. 
(when (not (package-installed-p 'dash))
  (package-install 'dash))
(require 'dash)

(setf use-package-always-ensure t)

(defun packages-install (packages)
  (--each packages
    (when (not (package-installed-p it))
      (with-demoted-errors (package-install it))))
  (delete-other-windows))

;;; On-demand installation of packages

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

;; (defun init--install-packages ()
;;   (packages-install
;;    '(ac-geiser
;;      ac-slime
;;      ace-jump-mode
;;      ace-link
;;      ace-window
;;      auctex
;;      auto-complete
;;      bash-completion
;;      bbdb
;;      browse-kill-ring
;;      cider
;;      clojure-mode
;;      dash-functional
;;      dired+
;;      elpy
;;      expand-region
;; ;;;     flx-ido ; May have become obsolete, due to helm.
;;      geiser
;;      guide-key
;;      haskell-mode
;;      helm
;;      htmlize
;;      hydra
;; ;;;     ido-at-point ; May have become obsolete, due to helm.
;; ;;;     ido-ubiquitous ; May have become obsolete, due to helm.
;; ;;;     ido-vertical-mode ; May have become obsolete, due to helm.
;;      jabber
;;      lispy
;;      lua-mode
;;      magit
;;      ;; monky
;;      multiple-cursors
;;      names
;;      org
;; ;;;     paradox
;;      paredit
;;      s
;;      shell-command
;;      slime
;;      smex
;;      undo-tree
;;      use-package)))

(defun init--install-packages ()
  (packages-install
   '(dash-functional
     s
     use-package)))

(defun install-my-packages ()
  (interactive)
  (condition-case nil
      (init--install-packages)
    (error
     (package-refresh-contents)
     (init--install-packages))))

(provide 'setup-package)
