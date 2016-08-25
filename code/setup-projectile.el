;; -*- lexical-binding: t -*-

(pc projectile
  (:post-install
   (projectile-global-mode)
   ;; (define-key projectile-mode-map (kbd "s-M-p") 'projectile-command-map)
   ))

(pc helm-projectile
  (:post-install
   (define-key projectile-mode-map (kbd "s-h") 'helm-projectile)))

(provide 'setup-projectile)
