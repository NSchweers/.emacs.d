;; -*- lexical-binding: t -*-
(require 'ace-window)

;; BEWARE: this function must have once been part of ace-jump-mode.  I pulled
;; this from googles cache, and hope it works.

(unless (fboundp 'ace-jump-mode-make-indirect-buffer)
  (defun ace-jump-mode-make-indirect-buffer (visual-area-list)
    "When the differnt window show the same buffer. The overlay
cannot work for same buffer at the same time. So the indirect
buffer need to create to make overlay can work correctly.

VISUAL-AREA-LIST is aj-visual-area list. This function will
return the structure list for those make a indirect buffer.

Side affect: All the created indirect buffer will show in its
relevant window."
    (loop for va in visual-area-list
          ;; check if the current visual-area (va) has the same buffer with
          ;; the previous ones (vai)
          if (loop for vai in visual-area-list
                   ;; stop at itself, don't need to find the ones behind it (va)
                   until (eq vai va)
                   ;; if the buffer is same, return those(vai) before
                   ;; it(va) so that we know the some visual area has
                   ;; the same buffer with current one (va)
                   if (eq (aj-visual-area-buffer va)
                          (aj-visual-area-buffer vai))
                   collect vai)
          ;; if indeed the same one find, we need create an indirect buffer
          ;; to current visual area(va)
          collect (with-selected-window (aj-visual-area-window va)
                    ;; store the orignal buffer
                    (setf (aj-visual-area-recover-buffer va)
                          (aj-visual-area-buffer va))
                    ;; create indirect buffer to use as working buffer
                    (setf (aj-visual-area-buffer va)
                          (clone-indirect-buffer nil nil))
                    ;; update window to the indirect buffer
                    (let ((ws (window-start)))
                      (set-window-buffer (aj-visual-area-window va)
                                         (aj-visual-area-buffer va))
                      (set-window-start
                       (aj-visual-area-window va)
                       ws))
                    va)))
  (message
   "WARNING: using old definition of `ace-jump-mode-make-indirect-buffer'!"))

(setq aw-scope 'frame)
(setq aw-keys '(?b ?n ?r ?s ?g ?o ?e ?i ?t ?c))

(global-set-key (kbd "C-x o") 'ace-window)

(provide 'setup-ace-window)
