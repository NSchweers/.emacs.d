;; -*- lexical-binding: t -*-
(require 'package)

;; Add melpa to package repos
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(unless (file-exists-p "~/.emacs.d/elpa/archives/melpa")
  (package-refresh-contents))

;; first install dash if it isn't yet. 
(when (not (package-installed-p 'dash))
  (package-install 'dash))
(require 'dash)

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

(defun init--install-packages ()
  (packages-install
   '(ace-jump-mode
     ace-link
     ace-window
     auctex
     auto-complete
     bash-completion
     browse-kill-ring
     cider
     clojure-mode
     dash-functional
     elpy
     expand-region
     flx-ido
     geiser
     guide-key
     haskell-mode
     helm
     htmlize
     hydra
     ido-at-point ; May have become obsolete, due to helm.
     ido-ubiquitous ; May have become obsolete, due to helm.
     ido-vertical-mode ; May have become obsolete, due to helm.
     jabber
     lua-mode
     magit
     multiple-cursors
     names
     org
     paredit
     s
     shell-command
     slime
     smex
     undo-tree
     ac-geiser)))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(provide 'setup-package)
