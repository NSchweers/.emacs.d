;; -*- lexical-binding: t -*-

(pc guide-key
  (:post-install
   (setf guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x 5" "C-x v" "C-x 8"
                                        "C-x n" "C-c C-x" "C-x c"))
   (guide-key-mode 1)
   (setf guide-key/recursive-key-sequence-flag t
         guide-key/popup-window-position 'bottom
         guide-key/idle-delay 0.1)))

;; (use-package guide-key
;;   :config
;;   (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x 5" "C-x v" "C-x 8"
;;                                        "C-x n" "C-c C-x" "C-x c"))
;;   (guide-key-mode 1)
;;   (setq guide-key/recursive-key-sequence-flag t)
;;   (setq guide-key/popup-window-position 'bottom)
;;   (setq guide-key/idle-delay 0.1))


(provide 'setup-guide-keys)
