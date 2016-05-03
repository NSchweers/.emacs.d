;; -*- lexical-binding: t -*-

(pc dash
  (:post-install
   (setf dash-enable-fontlock t)))

(pc dash-functional)

(provide 'setup-dash)
