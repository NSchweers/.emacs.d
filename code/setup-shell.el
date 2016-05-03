;; -*- lexical-binding: t -*-
;; Setup shell

;; Note: Emacs runs .bashrc in *shell*
;; So mac users should ln -s .profile .bashrc

;; bash-completion

;; (autoload 'bash-completion-dynamic-complete
;;   "bash-completion"
;;   "BASH completion hook")
;; (add-hook 'shell-dynamic-complete-functions
;;           'bash-completion-dynamic-complete)
;; (add-hook 'shell-command-complete-functions
;;           'bash-completion-dynamic-complete)

;; ;; tab-completion for shell-command

;; (require 'shell-command)
;; (shell-command-completion-mode)

;; ;; C-d to kill buffer if process is dead.

;; (defun comint-delchar-or-eof-or-kill-buffer (arg)
;;   (interactive "p")
;;   (if (null (get-buffer-process (current-buffer)))
;;       (kill-buffer)
;;     (comint-delchar-or-maybe-eof arg)))

;; (add-hook 'shell-mode-hook
;;           (lambda ()
;;             (define-key shell-mode-map (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))

(pc shell-command
  (:pre-install
   (autoload 'bash-completion-dynamic-complete
     "bash-completion"
     "BASH completion hook")
   (add-hook 'shell-dynamic-complete-functions
             'bash-completion-dynamic-complete)
   (add-hook 'shell-command-complete-functions
             'bash-completion-dynamic-complete))
  (:post-install
   (shell-command-completion-mode)
   
   (defun comint-delchar-or-eof-or-kill-buffer (arg)
     (interactive "p")
     (if (null (get-buffer-process (current-buffer)))
         (kill-buffer)
       (comint-delchar-or-maybe-eof arg)))

   (add-hook 'shell-mode-hook
             (lambda ()
               (define-key shell-mode-map (kbd "C-d")
                 'comint-delchar-or-eof-or-kill-buffer)))))

;; (use-package shell-command
;;   :init
;;   (autoload 'bash-completion-dynamic-complete
;;     "bash-completion"
;;     "BASH completion hook")
;;   (add-hook 'shell-dynamic-complete-functions
;;             'bash-completion-dynamic-complete)
;;   (add-hook 'shell-command-complete-functions
;;             'bash-completion-dynamic-complete)
;;   :config
;;   (shell-command-completion-mode)
;;   (defun comint-delchar-or-eof-or-kill-buffer (arg)
;;     (interactive "p")
;;     (if (null (get-buffer-process (current-buffer)))
;;         (kill-buffer)
;;       (comint-delchar-or-maybe-eof arg)))

;;   (add-hook 'shell-mode-hook
;;             (lambda ()
;;               (define-key shell-mode-map (kbd "C-d")
;;                 'comint-delchar-or-eof-or-kill-buffer))))

(provide 'setup-shell)
