;; -*- lexical-binding: t -*-

(require 'seq)

(defun pc//get-package-desc (&rest pkgs)
  "Returns a non-nil if at least one of the packages given in PKGS exists.

Returns nil otherwise.  The return value is the package
descriptor for the first matching package. "
  (cl-block 'return
    (package--mapc
     (lambda (p)
       (if (memq (package-desc-name p) pkgs)
           (cl-return-from 'return p))))
    nil))

(defmacro pc (pkg &rest clauses)
  (let ((pkg-desc (make-symbol "pkg-desc")))
   `(progn
      (when (not (pc//get-package-desc ',pkg))
        (error "Package does not exist: %s" ',pkg))
      (let ((,pkg-desc (pc//package-exists-p ',pkg)))
        ,@(if-let ((pre-inst (assoc :pre-install clauses)))
              (cdr pre-inst))
        (unless (package-installed-p ',pkg)
          (if (assoc :pin clauses)
              (package-install )
              (package-install ',pkg ,(cdr (assoc :dont-select clauses)))))
        ,@(if-let ((post-inst (assoc :post-install clauses)))
              (cdr post-inst))
        ,@(if-let ((bind (assoc :bind clauses)))
              (cl-loop for c in (cadr bind) collect
                       `(global-set-key (kbd ,(car c)) ',(cdr c))))))))

(pc//get-package-desc 'dash)
(package-desc-archive [cl-struct-package-desc
  dash
  (20160306 1222)
  "A modern list library for Emacs"
  nil
  nil
  nil
  "/home/schweers/.emacs.d/elpa/dash-20160306.1222"
  ((:keywords "lists"))
  nil])

(let ((pkgs))
  (package--mapc (lambda (p)
                   (if (eq (package-desc-name p) 'lispy)
                       (push (package-desc-archive p) pkgs))))
  (reduce (lambda (acc e)
            (if (equal (car acc) e)
                acc
              (cons e acc)))
          (sort pkgs #'string-lessp)
          :initial-value nil)
  pkgs)
