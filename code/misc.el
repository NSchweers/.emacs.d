;; -*- lexical-binding: t -*-
(require 's)

(defun recompile-emacs-d ()
  (interactive)
  (byte-recompile-directory (expand-file-name "code" user-emacs-directory) 0 t)
  (byte-compile-file (expand-file-name "init.el" user-emacs-directory)))

(defun file-in-emacs-d? (filename)
  (s-starts-with? (expand-file-name user-emacs-directory) 
                  (expand-file-name filename)))

(defun recompile-if-emacs-d ()
  (let ((filename (buffer-file-name (current-buffer))
         )) 
    (if (and (file-in-emacs-d? filename) (s-ends-with? ".el" filename))
        (condition-case nil
            (byte-compile-file filename)
          (error 
           (ignore-errors (delete-file (byte-compile-dest-file filename))))))))

;; Autocompile any elisp files in our emacs directory.  
(add-hook 'after-save-hook 'recompile-if-emacs-d)

;; Open the init file on startup.  
(find-file (expand-file-name "init.el" user-emacs-directory))

;;we want to have the compilation window scroll automatically
(setq compilation-scroll-output 'first-error)
(setq-default compile-command "make -k -j4 ")

(desktop-save-mode 1)
;;with this we try to save the desktop file when the emacs server is killed.
(add-hook 'kill-emacs-hook (lambda () (desktop-save "~/.emacs.d/")))

(defun misc/set-kill-and-delete-keys ()
  (local-set-key (kbd "C-w") 'backward-kill-word)
  (local-set-key (kbd "C-c C-w") 'kill-region)
  ;; Note on rebinding C-h: One merely needs to press any "help" key (e.g. F1).
  (local-set-key (kbd "C-h") 'delete-backward-char)
  (local-set-key (kbd "<f1>") 'help-command))

(defun misc/switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))

(global-set-key (kbd "C-S-s") 'misc/switch-to-scratch)

(defmacro misc/switch-to-chat (chan key)
  `(progn
     (defun misc/switch-to-neo-chat ()
       (interactive)
       (cond ((bufferp (get-buffer ,chan))
              (switch-to-buffer ,chan))
             (t (message "No such buffer."))))
     (global-set-key (kbd (s-concat "C-S-" key)) 'misc/)))

(global-set-key (kbd "C-S-n") 'misc/switch-to-neo-chat)

(defun misc/switch-to-emacs-chat ()
  )

(defmacro misc/switch-to-buffer (buffer &optional k)
  "Generate a function and keybinding.  

If K is given, bind to (kbd k).  Otherwise bind to C-S-(buffer-substring 1 1
name).  "
  (let ((name (make-symbol "name")))
    (list 'let (list (list name buffer))
          (list 'defun (intern (s-concat "misc/switch-to-" name))
                (list 'interactive)
                (list 'switch-to-buffer name))
    ;; `(let ((,name ,buffer))
    ;;    (defun ,(intern (s-concat "misc/switch-to-" buffer)) ()
    ;;      (interactive)
    ;;      (switch-to-buffer ,name)))
    )))

;; (defun misc/next-word-at-point ()
;;   "Go to the next occurence of the word at point.  "
;;   (interactive)
;;   (if (not (looking-at "\\b"))
;;       (progn (backward-word)
;;              (misc/next-word-at-point))
;;     (let ((word ())))))

(add-hook 'erc-mode-hook (-partial 'auto-fill-mode 0))

(setq save-interprogram-paste-before-kill t)

(defun misc/new-setup (name)
  (interactive "MWhich package do you want to set up? \n")
  (let ((proper-name (s-concat "setup-" name ".el")))
    (save-excursion
      (find-file
       (expand-file-name
        proper-name
        (expand-file-name "code" user-emacs-directory)))
      (goto-char (point-min))
      (if (not (string= (buffer-string) ""))
          (progn
            (forward-line 2)
            (indent-for-tab-command))
        (insert ";; -*- lexical-binding: t -*-\n\n\n(provide '")
        (insert proper-name)
        (insert ")\n")
        (forward-line -2)
        (indent-for-tab-command)
        (save-buffer)))))

(provide 'misc)
