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

(defmacro misc/make-buffer-switch (buffer cname)
  `(defun ,(intern (s-concat "misc/switch-to-" cname)) ()
     (interactive)
     (switch-to-buffer ,buffer)))

(defmacro misc/make-irc-hydra ()
  `(global-set-key
    (kbd "C-c i")
    (defhydra hydra-switch-irc (:color amaranth)
      "switch to"
      ("n" ,(misc/make-buffer-switch "#neo" "neo") "neo")
      ("e" ,(misc/make-buffer-switch "#emacs" "emacs"))
      ("f" ,(misc/make-buffer-switch "irc.freenode.net:6667" "freenode")
       "freenode")
      ("q" nil "quit" :color blue))))

(misc/make-irc-hydra)

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

;; (defun misc/transpose-windows (arg)
;;   "Transpose the buffers shown in two windows.

;; Stolen from http://www.emacswiki.org/emacs/TransposeWindows"
;;   (interactive "p")
;;   (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
;;     (while (/= arg 0)
;;       (let ((this-win (window-buffer))
;;             (next-win (window-buffer (funcall selector))))
;;         (set-window-buffer (selected-window) next-win)
;;         (set-window-buffer (funcall selector) this-win)
;;         (select-window (funcall selector)))
;;       (setq arg (if (plusp arg) (1- arg) (1+ arg))))))

(provide 'misc)
