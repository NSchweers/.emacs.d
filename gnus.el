(setq user-mail-address "NSchweers@online.de")
(setq user-full-name "Nathanael Schweers")

;(setq nntp-send-authinfo (expand-file-name ".authfile.gpg" (getenv "HOME")))

(setq gnus-select-method 
      '(nnimap "1&1"
               (nnimap-address "imap.1und1.de")
               (nnimap-authenticator login)
               (nnimap-server-port 993)
               (nnimap-stream ssl)))

;; (nnimap-authinfo-file
;;  (expand-file-name ".authinfo" (getenv "HOME")))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.1und1.de" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.1und1.de" 587
				   "NSchweers@online.de" nil))
      smtpmail-default-smtp-server "smtp.1und1.de"
      smtpmail-smtp-server "smtp.1und1.de"
      smtpmail-smtp-service 587
      ;gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]"
      )

(setq nnimap-inbox "INBOX")
(setq nnimap-split-methods
      `(("INBOX/PUG" 
         "\\(?:^Subject:.*\\[PUG\\]\\)\\|\\(?:^To:.*talk@pug.org\\)\\|\\(?:Reply-To:.*talk@pug.org\\)")
        ("INBOX/Geocaching" "^From:.*@geocaching.com")
        ("INBOX/NEO" 
         ,(concat "\\(?:^Subject:.*\\[Neo\\]\\)\\|\\(?:^To:.*diskussion@neo-layout.org\\)\\|"
                 "\\(?:Reply-To:.*diskussion@neo-layout.org\\)"))
        ("INBOX/FH" "\\(?:^From:.*@fra-uas.de\\)\\|\\(?:^Reply-To:.*@fra-uas.de\\)")
        ("INBOX/klingemann"
         "^To:.*klingemann-geschaedigte-ev@lists.informatiktreffpunkt.de")
        ("INBOX/emacs-help"
         "\\(?:^To:.*help-gnu-emacs@gnu.org\\)\\|\\(?:^Cc:.*help-gnu-emacs@gnu.org\\)")
        ("INBOX/emacs-devel"
         "\\(?:^To:.*emacs-devel@gnu.org\\)\\|\\(?:^Cc:.*emacs-devel@gnu.org\\)")
        ("INBOX" "")))

;; (setq gnus-select-method '(nmimap "1&1"
;;                                   (nmimap-address "imap.1und1.de")
;;                                   (nmimap-server-port 993)
;;                                   (nmimap-stream ssl)))

;; (setq mail-sources '((pop :server "pop.provider.org"
;;                           :user "you"
;;                           :password "secret")))



;; (setq gnus-select-method
;;       '(nnimap "1&1"
;; 	       (nnimap-address "imap.1und1.de")
;; 	       (nnimap-server-port 993)
;; 	       (nnimap-stream ssl)))

;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-starttls-credentials '(("smtp.1und1.de" 587 nil nil))
;;       smtpmail-auth-credentials '(("smtp.1und1.de" 587
;; 				   "NSchweers@online.de" nil))
;;       smtpmail-default-smtp-server "smtp.1und1.de"
;;       smtpmail-smtp-server "smtp.1und1.de"
;;       smtpmail-smtp-service 587
;;       gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
