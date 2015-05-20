;; -*- lexical-binding: t -*-
(require 's)

(defun recompile-emacs-d ()
  (interactive)
  (byte-recompile-directory (expand-file-name "code" user-emacs-directory) 0 t)
  (byte-compile-file user-init-file))

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

(defun reload-emacs-conf ()
  (interactive)
  (load user-init-file))

;; Autocompile any elisp files in our emacs directory.
(add-hook 'after-save-hook 'recompile-if-emacs-d)

;; Open the init file on startup.
(find-file-noselect (expand-file-name "init.el" user-emacs-directory))

;;we want to have the compilation window scroll automatically
(setq compilation-scroll-output 'first-error)
(setq-default compile-command "make -k -j4 ")

(desktop-save-mode 1)
;;with this we try to save the desktop file when the emacs server is killed.
(add-hook 'kill-emacs-hook (lambda () (desktop-save user-emacs-directory)))

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

(defmacro misc/buffer-switch-hydra (hydra-name short-name key-prefix
                                               &rest heads)
  (declare (indent 3))
  `(global-set-key
    (kbd ,key-prefix)
    ,(append
      `(defhydra ,hydra-name (:color pink) ,short-name)
      (append
       (-map
        (-lambda ((key b-or-n hint))
          `(,key (lambda ()
                   (interactive)
                   (switch-to-buffer ,b-or-n)) ,hint))
        heads)
       '(("q" nil "quit" :color blue))))))

(add-hook 'erc-mode-hook (-partial 'auto-fill-mode 0))

(setq save-interprogram-paste-before-kill t)

(defun misc/new-setup (name)
  "Create a new setup file, called setup-NAME.el in
~/.emacs.d/code/ which enables lexical scoping, contains the
appropriate provide and places point at the right position."
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
        (insert ";; -*- lexical-binding: t -*-\n\n\n\n(provide '")
        (insert (substring proper-name 0 (- (length proper-name) 3)))
        (insert ")\n")
        (forward-line -3)
        (indent-for-tab-command)
        (save-buffer)))))

(defun misc/hurra ()
  "Calls xdg-open (i.e. a browser) for a youtube search link for the song
„hurra“.

This song describes very nicely how it felt before and after knowing Emacs ;)"
  (interactive)
  (let* ((p (start-process
             "hurra" "hurra-out" "xdg-open"
             (s-concat "https://www.youtube.com/"
                       "results?search_query=die+%C3%A4rzte+hurra")))
         (pb (process-buffer p)))
    (set-process-sentinel
     p
     (lambda (_proc e)
       (cond ((string-match "finished" e)
              (kill-buffer pb)))))))

(defun misc/olbia (arg)
  "Downloads the menu of the Pizzeria Olbia in Frankfurt/Main.

Switches to the apropriate buffer if it already exists."
  (interactive "P")
  (let ((b (get-buffer "*Olbia*")))
    (cond (b (cond ((null arg) (switch-to-buffer b))
                   (t (switch-to-buffer-other-window b))))
          (t
           (url-retrieve
            "http://pizzeriaolbia.de/index_htm_files/Speisekarte%20032015.pdf"
            (lambda (_status)
              (rename-buffer "*Olbia*")
              (search-forward-regexp "%PDF")
              (beginning-of-line)
              (delete-region (point-min) (point))
              (doc-view-mode)
              (call-interactively #'misc/olbia)))))))

(defun schweers/split-quoted-paragraph ()
  "Split the quoted paragraph at point, making space for a reply, and fill the
rest of the paragraph.  This is useful in message-mode."
  (interactive)
  (let ((in-line (not (looking-at "[[:space:]]*$"))))
    (insert "\n")
    (delete-horizontal-space)
    (when in-line
      (insert "> "))
    (beginning-of-line)
    (open-line (if in-line 3 2))
    (forward-line 1)
    (when in-line
      (save-excursion
        (forward-line 2)
;;; This binding is needed, so fill-paragraph won’t create an extra
;;; undo-boundary, which is normally done because of message-mode.
        (let ((fill-paragraph-function (lambda (&rest _) nil)))
          (fill-paragraph))))))

(provide 'misc)
