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

(defun comint-kill-output-to-kill-ring (arg)
  "Kills all output from last command and puts it in kill buffer
Does not delete the prompt."
  (interactive "P")
  (let ((proc (get-buffer-process (current-buffer)))
        (replacement nil)
        (inhibit-read-only t))
    (save-excursion
      (let ((pmark (progn (goto-char (process-mark proc))
                          (forward-line 0)
                          (point-marker))))
        ;; Add the text to the kill ring.
        (copy-region-as-kill comint-last-input-end pmark)
        (unless arg
          (delete-region comint-last-input-end pmark)
          (goto-char (process-mark proc))
          (setq replacement (concat "*** output flushed to kill ring ***\n"
                                    (buffer-substring pmark (point))))
          (delete-region pmark (point)))))
    ;; Output message and put back prompt
    (comint-output-filter proc replacement)))

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
                 'comint-delchar-or-eof-or-kill-buffer)
               (define-key shell-mode-map (kbd "C-c C-o")
                 'comint-kill-output-to-kill-ring)))))

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
