;; -*- lexical-binding: t -*-

(require 'seq)
(require 'subr-x)

;; (defun pc//get-package-desc (&rest pkgs)
;;   "Returns a non-nil if at least one of the packages given in PKGS exists.

;; Returns nil otherwise.  The return value is the package
;; descriptor for the first matching package. "
;;   (cl-block 'return
;;     (package--mapc
;;      (lambda (p)
;;        (if (memq (package-desc-name p) pkgs)
;;            (cl-return-from 'return p))))
;;     nil))

(defmacro pc (pkg &rest clauses)
  (declare (indent 1))
  (let ((pkg-desc (make-symbol "pkg-desc"))
        (get-package-desc (make-symbol "get-package-desc")))
    `(progn
       (cl-flet
           ((,get-package-desc
             (&rest pkgs)
             "Returns a non-nil if at least one of the packages given in PKGS exists.

Returns nil otherwise.  The return value is the package
descriptor for the first matching package. "
             (cl-block 'return
               (package--mapc
                (lambda (p)
                  (if (memq (package-desc-name p) pkgs)
                      (cl-return-from 'return p))))
               nil)))
         (when (not (,get-package-desc ',pkg))
           (error "Package does not exist: %s" ',pkg))
         (let ((,pkg-desc (,get-package-desc ',pkg)))
           ,@(if-let ((pre-inst (assoc :pre-install clauses)))
                 (cdr pre-inst))
           (unless (package-installed-p ',pkg)
             (package-install ',pkg ,(cdr (assoc :dont-select clauses))))
           ,@(let ((req-form (assoc :require clauses)))
               (if (not (null (cdr req-form)))
                   (if (not (null (cddr req-form)))
                       (error "too many forms in :require clause.")
                     `(,(cadr req-form)))
                 `((require ',pkg))))
           ,@(if-let ((post-inst (assoc :post-install clauses)))
                 (cdr post-inst))
           ,@(if-let ((bind (assoc :bind clauses)))
                 (cl-loop for c in (cadr bind) collect
                          `(global-set-key (kbd ,(car c)) ',(cdr c)))))))))

(provide 'pc)
