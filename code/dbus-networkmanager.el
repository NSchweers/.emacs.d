;; -*- lexical-binding: t -*-

(require 'dbus)
(require 'dash)
(require 'dash-functional)

(defun dbusnm/parse-primtype (inp)
  (let ((tok (car inp))
        (r (cdr inp)))
    (cond ((= tok ?y) (list (list :y) r))
          ((= tok ?b) (list (list :b) r))
          ((= tok ?n) (list (list :n) r))
          ((= tok ?q) (list (list :q) r))
          ((= tok ?i) (list (list :i) r))
          ((= tok ?u) (list (list :u) r))
          ((= tok ?x) (list (list :x) r))
          ((= tok ?t) (list (list :t) r))
          ((= tok ?d) (list (list :d) r))
          ((= tok ?s) (list (list :s) r))
          ((= tok ?o) (list (list :o) r))
          ((= tok ?g) (list (list :g) r))
          ((= tok ?v) (list (list :v) r))
          ((= tok ?h) (list (list :h) r))
          (t nil))))

(defun dbusnm/parse-open-paren (inp)
  (if (= (car inp) ?\() (list (list :op) (cdr inp)) nil))

(defun dbusnm/parse-close-paren (inp)
  (if (= (car inp) ?\)) (list (list :cp) (cdr inp)) nil))

(defun dbusnm/parse-open-brace (inp)
  (if (= (car inp) ?{) (list (list :ob) (cdr inp)) nil))

(defun dbusnm/parse-close-brace (inp)
  (if (= (car inp) ?}) (list (list :cb) (cdr inp)) nil))

(defun dbusnm/parse-dict (inp)
  (let ((res (dbusnm/parse-concat
              (list 'dbusnm/parse-open-brace
                    (-partial 'dbusnm/parse-concat
                              (list 'dbusnm/parse-primtype
                                    'dbusnm/parse-anytype))
                    'dbusnm/parse-close-brace)
              inp)))
    (if (null res) nil
      (list (reverse (cdr (reverse (cons :dict-entry (cdr (car res))))))
            (cadr res)))))

(defun dbusnm/parse-struct (inp)
  (let ((res (dbusnm/parse-concat
              (list 'dbusnm/parse-open-paren
                    (-partial 'dbusnm/parse-multiple 'dbusnm/parse-anytype)
                    'dbusnm/parse-close-paren)
              inp)))
    (if (null res) nil
      (list (reverse (cdr (reverse (cons :struct (cdr (car res))))))
            (cadr res)))))

(defun dbusnm/parse-array (inp)
  (let ((array-tok (car inp)))
    (if (= array-tok ?a)
        (let ((innerres (dbusnm/parse-anytype (cdr inp))))
          (if (null innerres) nil
            (list (list :a (car innerres)) (cadr innerres))))
      nil)))

(defun dbusnm/parse-alternatives (parserlist inp)
  (cl-labels ((fa (parsers inp)
                 (if (or (null parsers) (null (car parsers))) nil
                     (let ((res (funcall (car parsers) inp)))
                       (if (null res)
                           (fa (cdr parsers) inp)
                         res)))))
    (fa parserlist inp)))

(defun dbusnm/parse-concat (parserlist inp)
  (cl-labels
      ((fc (parsers inp parsetree)
          (if (null parsers) (list (reverse parsetree) inp)
            (let ((res (funcall (car parsers) inp)))
              (if (null res) nil
                (fc (cdr parsers) (cadr res) (cons (car res) parsetree)))))))
    (fc parserlist inp nil)))

(defun dbusnm/parse-multiple (parser inp)
  (cl-labels
      ((fm (inp parsetree)
          (if (null inp) (list (reverse parsetree) nil)
            (let ((res (funcall parser inp)))
              (if (null res) (list (reverse parsetree) inp)
                (fm (cadr res) (cons (car res) parsetree)))))))
    (fm inp nil)))

(defun dbusnm/parse-anytype (inp)
  (dbusnm/parse-alternatives (list 'dbusnm/parse-primtype 'dbusnm/parse-array
                                   'dbusnm/parse-struct
                                   'dbusnm/parse-dict)
                             inp))

(defun dbusnm/parse-types (inp)
  "Parses INP for dbus-types, and returns a corresponding tree, or nil.  "
  (car (dbusnm/parse-anytype inp)))

;; (defun dbusnm/set-types (elem inp)
;;   "Sets the appropriate dbus types for ELEM according to INP ")

(dbusnm/parse-anytype (string-to-list "ab"))
(dbusnm/parse-concat (list 'dbusnm/parse-anytype 'dbusnm/parse-anytype
                           'dbusnm/parse-anytype) (string-to-list "baby"))
(dbusnm/parse-multiple 'dbusnm/parse-anytype (string-to-list "bivoab"))
(dbusnm/parse-struct (string-to-list "(b(iy))"))
(dbusnm/parse-types (string-to-list "a{sa{ss}}"))
