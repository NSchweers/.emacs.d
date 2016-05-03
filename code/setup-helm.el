;; -*- lexical-binding: t -*-

;; (use-package helm
;;   ;; :pin melpa-stable
;;   :init
;;   (require 'helm-config)
;;   (setq helm-man-or-woman-function 'woman)
;;   (setq helm-man-or-woman-function 'Man-getpage-in-background)
;;   (helm-mode 1)
;;   :bind (("M-x" . helm-M-x)
;;          ("C-M-y" . helm-show-kill-ring)
;;          ("C-x C-f" . helm-find-files))
;;   ;; (global-set-key (kbd "M-x") 'helm-M-x)
;;   ;; (global-set-key (kbd "C-M-y") 'helm-show-kill-ring)
;;   ;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
  
;;   ;; :demand
;;   :ensure t)

;; (provide 'setup-helm)

;; (require 'seq)

;; (defun pc//package-exists-p (&rest pkgs)
;;   "Returns t if at least one of the packages given in PKGS exists.

;; Returns nil otherwise."
;;   (cl-block 'return
;;     (package--mapc
;;      (lambda (p)
;;        (if (memq (package-desc-name p) pkgs)
;;            (cl-return-from 'return t))))
;;     nil))

;; (defmacro pc (pkg &rest clauses)
;;   `(progn
;;      (when (not (pc//package-exists-p ',pkg))
;;        (error "Package does not exist: %s" ',pkg))
;;      ,@(if-let ((pre-inst (assoc :pre-install clauses)))
;;           (cdr pre-inst))
;;      (unless (package-installed-p ',pkg)
;;        (package-install ',pkg))
;;      ,@(if-let ((post-inst (assoc :post-install clauses)))
;;           (cdr post-inst))
;;      ,@(if-let ((bind (assoc :bind clauses)))
;;           (cl-loop for c in (cadr bind) collect
;;                    `(global-set-key (kbd ,(car c)) ',(cdr c))))))

(pc helm
    (:post-install
     (require 'helm-config)
     (setq helm-man-or-woman-function 'woman)
     (setq helm-man-or-woman-function 'Man-getpage-in-background)
     (helm-mode 1)
     (provide 'setup-helm)
     (diminish 'helm-mode))
    (:bind
     (("M-x" . helm-M-x)
      ("C-M-y" . helm-show-kill-ring)
      ("C-x C-f" . helm-find-files))))

(provide 'setup-helm)
