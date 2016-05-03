;; -*- lexical-binding: t -*-

(pc browse-kill-ring
  (:post-install
   (browse-kill-ring-default-keybindings)))

;; (use-package browse-kill-ring
;;                                         ;(global-set-key (kbd "C-y") 'browse-kill-ring)
;;                                         ;(global-set-key (kbd "C-M-y") 'yank)
;;   :config
;;   (browse-kill-ring-default-keybindings))

(provide 'setup-browse-kill-ring)
