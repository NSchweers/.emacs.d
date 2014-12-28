;; Note that flyspell is enabled for each mode separately in the setup file for
;; the appropriate mode.  See for instance setup-org.el

(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "deutsch8") "english" "deutsch8")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)))

(global-set-key (kbd "<f8>")   'fd-switch-dictionary)
