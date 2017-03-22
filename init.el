;; -*- lexical-binding: t -*-

(require 'org)

(condition-case nil
    (load (expand-file-name "bootstrap.el" user-emacs-directory))
  (file-error (org-babel-load-file
               (expand-file-name "literate-init.org" user-emacs-directory))))
(load-literate-init)
