;; -*- lexical-binding: t -*-

(pc erc
  (:post-install
   (and (load-library "erc-highlight-nicknames")
        (add-to-list 'erc-modules 'highlight-nicknames)
        (erc-update-modules))
   (add-hook 'erc-mode-hook
             (lambda ()
               (auto-fill-mode nil)
               (show-paren-mode nil)))))

;; (use-package erc
;;   :config
;;   (and (load-library "erc-highlight-nicknames")
;;        (add-to-list 'erc-modules 'highlight-nicknames)
;;        (erc-update-modules))
;;   (add-hook 'erc-mode-hook #'(lambda ()
;;                                (auto-fill-mode nil)
;;                                (show-paren-mode nil))))

(provide 'setup-erc)
