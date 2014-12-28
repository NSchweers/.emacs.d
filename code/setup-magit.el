(require 'magit)
(require 's)

;; Bind C-c g to magit-status
(global-set-key (kbd "C-c g") 'magit-status)

(setq magit-repo-dirs (list (s-join "/" (list (getenv "HOME") "code"))
                            user-emacs-directory))
(setq magit-repo-dirs (list (getenv "HOME")))
;; 3 seems to be the default. 
;(setq magit-repo-dirs-depth 3)

(provide 'setup-magit)
