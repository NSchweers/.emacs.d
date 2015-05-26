;; -*- lexical-binding: t -*-

;;; This code assumes clhs (http://www.hexstreamsoft.com/libraries/clhs/) was
;;; installed via quicklisp, to the default quicklisp location (~/quicklisp). 

(if (file-exists-p (expand-file-name "quicklisp/clhs-use-local.el"
                                     (getenv "HOME")))
    (progn (load (expand-file-name "quicklisp/clhs-use-local.el" (getenv "HOME")))

           (defun schweers/browse-with-w3m (url &rest _args)
             (other-window 1)
             (w3m url t)
             (other-window -1))

           (defun schweers/browse-local-hyperspec ()
             (let ((browse-url-browser-function 'schweers/browse-with-w3m))
               (if (<= (length (window-list)) 1)
                   (split-window-sensibly))
               (funcall 'slime-documentation-lookup)))

           (defun schweers/browse-hyperspec-in-w3m-other-window ()
             (interactive)
             "Open the local hyperspec for the symbol at point in w3m in the
other window."
             (schweers/browse-local-hyperspec))

           (define-key help-map (kbd "h")
             'schweers/browse-hyperspec-in-w3m-other-window))
  (warn "CLHS is not installed!"))

(provide 'setup-clhs)
