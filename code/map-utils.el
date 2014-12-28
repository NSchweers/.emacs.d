; -*- lexical-binding t -*-

(eval-when-compile (require 'cl))
(require 'dash)

(defun plist-keys (plist)
  "Return a list of all keys in PLIST, which must be a plist. "
  (let ((res nil))
    (while (not (null plist))
      (setf res (cons (car plist) res))
      (setf plist (cddr plist)))
    res))

(defun plist-to-hashmap! (plist fn)
  "Generates a new hashmap from PLIST, which must be a plist.
The map to which the values are DESTRUCTIVELY added comes from
FN.  "
  (let ((rep (funcall fn)))
    (dolist (k (plist-keys plist) rep)
      (let ((keyname (cond
                      ((keywordp k) (substring (symbol-name k) 1))
                      ((symbolp k) (symbol-name k))
                      (t (format "%s" k)))))
        (puthash keyname (plist-get plist k) rep)))))

(defun hashmap-keys (m)
  "returns a list of all keys in M, which must be a map.  "
  (let ((keys ()))
    (maphash (lambda (k v) (setf keys (cons k keys))) m)
    keys))

(defun hashmap-values (m)
  "returns a list of all keys in M, which must be a map.  "
  (let ((vals ()))
    (maphash (lambda (k v) (setf vals (cons v vals))) m)
    vals))

(defun lists-to-map! (keys-and-vals fn)
  "Take a two element list containing keys and values as a list.
FN shall be a function of no args, which returns a map, to which
the values are DESTRUCTIVELY added.  The resulting hashmap is
then returned.  "
  (let ((rep (funcall fn)))
    (destructuring-bind (keys vals) keys-and-vals
      (-each (-zip keys vals)
        (lambda (k-v)
          (puthash (car k-v) (cdr k-v) rep)))
      rep)))

(provide 'map-utils)
