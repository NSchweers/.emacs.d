;; -*- lexical-binding: t -*-

(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Highlight matching parentheses when the point is on them.  
(show-paren-mode 1)

;; Use a smaller font
(set-face-attribute 'default nil :height 80)

;; Enable syntax highlighting for older Emacsen that have it off
(global-font-lock-mode t)

;; Have the scrollbar on the right.  
(when window-system
  (set-scroll-bar-mode 'right))

;; Always show line and column numbers.  
(column-number-mode 1)
(line-number-mode 1)

;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; Enable mouse support when in xterm.  
(xterm-mouse-mode 1)

;; Don't defar screen updates when performing operations.  
;; (setq redisplay-dont-pause t)

;; If on a graphical display, maximize the current frame.  
(when window-system
  (set-frame-parameter nil 'fullscreen 'maximized)
;; Also disable the blinking cursor.  
  (blink-cursor-mode -1))

;; Get rid of the fucking annoying BEEPING.
(setq visible-bell t)

;; As the default colors are barely readable on my second screen, and customize
;; thinks emacs was started with -q, even though it wasn’t, set the region color
;; here.

(face-spec-set 'region
               '((t (:distant-foreground "royal blue"
                                         :background "cornflower blue"))))

(setq split-height-threshold 180)
(provide 'appearance)
