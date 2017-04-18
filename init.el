;; -*- lexical-binding: t -*-


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'org)

(condition-case nil
    (load (expand-file-name "bootstrap.el" user-emacs-directory))
  (file-error (org-babel-load-file
               (expand-file-name "literate-init.org" user-emacs-directory))))
(load-literate-init)
