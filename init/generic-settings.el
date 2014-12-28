;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

(require 'cl)

(setq-default indent-tabs-mode nil)
(column-number-mode 1)
(xterm-mouse-mode 1)

(when window-system
;;if on a graphical display, maximize the current frame
;;unfortunatly this doesn't seem to work with an emacs daemon
  (set-frame-parameter nil 'fullscreen 'maximized)
  (blink-cursor-mode 0))

;; Enable narrowing support. 
(put 'narrow-to-region 'disabled nil)

;; Disable region killing by accident.
(setf delete-active-region)

;;get rid of the fucking annoying BEEPING.
;;(setq visible-bell t)

;;display trailing whitespace
;;(setq-default show-trailing-whitespace t)

;;if we are editing a program -- or something that looks like a program, we
;;want to see the current function in the status line.
(which-function-mode t)

;;we want to have the compilation window scroll automatically
(setq compilation-scroll-output 'first-error)

(setq-default compile-command "make -k -j4 ")

;(require 'package)
;(add-to-list 'package-archives
;             '("marmalade" . "http://marmalade-repo.org/packages/"))
;(package-initialize)

;;use subword mode in anything that looks like c-mode
(add-hook 'c-mode-common-hook (lambda () (subword-mode 1)))

;;remove that hideous indentation for opening braces that the GNU style
;;dictates.
(add-hook 'c-mode-common-hook (lambda () (c-set-offset 'substatement-open 0)))
;;do proper filling in anything that looks like c-mode
(add-hook
 'c-mode-common-hook (lambda () (setq-default fill-column 78)
                       (setq-default auto-fill-function
                                     'do-auto-fill)
                       (auto-fill-mode 1)))
(setq-default fill-column 78)
(setq-default auto-fill-function 'do-auto-fill)
(auto-fill-mode 1)
(set-face-attribute 'default nil :height 80)
(set-scroll-bar-mode 'right)
(desktop-save-mode 1)

;;with this we try to save the desktop file when the emacs server is killed.
(add-hook 'kill-emacs-hook (lambda () (desktop-save "~/.emacs.d/")))

;;set latex-mode for *.latex files
(setq auto-mode-alist (cons '("\\.latex$" . latex-mode) auto-mode-alist))
(setq LaTeX-indent-level 4)
(setq TeX-brace-indent-level 4)
(setq LaTeX-item-indent 0)
(setq-default TeX-master nil)
(setq TeX-auto-save t)
;(setq TeX-parse-self nil)
;(setq TeX-electric-macro t)

;;don't do auto-filling when in chat-mode
(dolist (mode (list 'jabber-chat-mode-hook 'shell-mode-hook 'erc-mode-hook))
  (add-hook mode (lambda () (auto-fill-mode 0))))

(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")
            ;; Set dired-x global variables here.  For example:
            ;; (setq dired-guess-shell-gnutar "gtar")
            ;; (setq dired-x-hands-off-my-keys nil)
            ))

(add-hook 'dired-mode-hook
          (lambda ()
            ;; Set dired-x buffer-local variables here.  For example:
            ;; (dired-omit-mode 1)
            ))

;; This is for lacarte mode, a superior menu mode (for terminal, that is).
;(require 'lacarte)
;(global-set-key [?\e ?\M-x] 'lacarte-execute-command)
;; This binds lacarte mode to F10 (i.e. replaces the standard menu key).
;;(global-set-key [?\M-`] 'lacarte-execute-command)

(windmove-default-keybindings)

;; Bind C-c g to magit-status
(global-set-key (kbd "C-c g") 'magit-status)

;; This does some tikz alignment
(add-hook
 'align-load-hook
 (lambda ()
   (add-to-list 'align-rules-list
                '(tikz-node-label-and-text
                  (regexp  . "\\(\\s-*\\)\\([({]\\)")
                  (group   . 1)
                  (modes   . align-tex-modes)
                  (repeat  . t)))
   (add-to-list 'align-rules-list
                '(tikz-node-position
                  (regexp  . "\\(\\s-*\\)\\(\\[\\)")
                  (group   . 1)
                  (modes   . align-tex-modes)
                  (repeat  . t)))
   ))

;; Set up slime (common-lisp interaction mode)
(ignore-errors
;; Use which (shell-command) to find the sbcl binary in the future. 
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (require 'slime-autoloads)
  (slime-setup))

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq w3m-key-binding 'info)

;(add-to-list 'erc-modules 'notifications)
;(erc-update-modules)

(add-hook 'rcirc-mode-hook
          (lambda ()
            (rcirc-track-minor-mode 1)))

(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(require 'browse-kill-ring)
(require 'kill-ring-ido)
(global-set-key (kbd "M-y") 'kill-ring-ido)

(require 'ido-preview)
(add-hook 'ido-setup-hook
          (lambda()
            (define-key ido-completion-map (kbd "C-M-p")
              (lookup-key ido-completion-map (kbd "C-p")))
            (define-key ido-completion-map (kbd "C-M-n")
              (lookup-key ido-completion-map (kbd "C-n")))
                                        ; currently, this makes nothing. Maybe
                                        ; they'll make C-n key lately.
            (define-key ido-completion-map (kbd "C-p") 'ido-preview-backward)
            (define-key ido-completion-map (kbd "C-n") 'ido-preview-forward)))

(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code." t)

;; (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
;; (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
;; (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
;; (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
;; (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
;; (add-hook 'scheme-mode-hook           #'enable-paredit-mode)

(dolist (mode (list 'emacs-lisp-mode-hook 'lisp-mode-hook 'scheme-mode-hook
                    'clojure-mode-hook 'eval-expression-minibuffer-setup-hook
                    'lisp-interaction-mode-hook 'cider-mode-hook))
  (add-hook mode
            (lambda ()
              (enable-paredit-mode)
              ;; (if (not (eq mode 'cider-mode-hook))
              ;;     (local-set-key (kbd "RET") 'paredit-newline))
              (local-set-key (kbd "C-j") 'reindent-then-newline-and-indent)
              (local-set-key (kbd "C-c C-w") 'kill-region)
              (local-set-key (kbd "C-w") 'backward-kill-word)
              (auto-complete-mode))))

(add-hook 'cider-mode-hook
          (lambda ()
            (define-key cider-mode-map (kbd "C-c C-w") 'kill-region)))
; Enable smex (ido for M-x)

(require 'smex)
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; scroll one line at a time (less "jumpy" than defaults)

;; (require 'smooth-scrolling)
(setq mouse-wheel-scroll-amount '(5 ((shift) . 5))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 5) ;; keyboard scroll one line at a time

(global-set-key (kbd "C-S-n") 'scroll-up-1)
(global-set-key (kbd "C-S-p") 'scroll-down-1)
;; (global-set-key [(control  left)]  'scroll-right-1)
;; (global-set-key [(control  right)] 'scroll-left-1)

;(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x r" "C-x 4"))
(guide-key-mode 1)  ; Enable guide-key-mode

;set the diary to be in the git-repository
(setq diary-file "~/.emacs.d/diary")

(setq calendar-latitude 50.1)
(setq calendar-longitude 8.2)
(setq calendar-location-name "Eppstein")

;;; Add the GNU guile info pages. 
(add-hook 'Info-mode-hook 
          '(lambda ()
             (add-to-list 'Info-directory-list
                          (expand-file-name "~/documents/scheme/guile_info"))))
