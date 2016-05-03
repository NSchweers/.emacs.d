;; -*- lexical-binding: t -*-

(pc bbdb
  (:post-install
   (setf bbdb-north-american-phone-number nil
         bbdb-phone-style nil)))

;; (use-package bbdb
;;   :config
;;   (setq bbdb-north-american-phone-number nil
;;         bbdb-phone-style nil))

(provide 'setup-bbdb)
