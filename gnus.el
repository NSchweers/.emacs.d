(require 'setup-bbdb)

(setq gnus-home-directory (expand-file-name "code" user-emacs-directory))
(setq user-mail-address "NSchweers@mailbox.org")
(setq user-full-name "Nathanael Schweers")

(setq gnus-select-method
      '(nnimap "mailbox.org"
               (nnimap-address "imap.mailbox.org")
               (nnimap-authenticator login)
               (nnimap-server-port 143)
               (nnimap-stream starttls))
      gnus-secondary-select-methods
      '((nnimap "1&1"
                (nnimap-address "imap.1und1.de")
                (nnimap-authenticator login)
                (nnimap-server-port 993)
                (nnimap-stream ssl))))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.mailbox.org" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.mailbox.org" 587
                                   "NSchweers@mailbox.org" nil))
      smtpmail-default-smtp-server "smtp.mailbox.org"
      smtpmail-smtp-server "smtp.mailbox.org"
      smtpmail-smtp-service 587)

(setq nnimap-inbox "INBOX")

(setf nnrss-directory (expand-file-name "News/rss" user-emacs-directory))

(require 'mm-url)

(defadvice mm-url-insert (after DE-convert-atom-to-rss () )
  "Converts atom to RSS by calling xsltproc."
  (when (re-search-forward "xmlns=\"http://www.w3.org/.*/Atom\"" 
			   nil t)
    (goto-char (point-min))
    (message "Converting Atom to RSS... ")
    (call-process-region (point-min) (point-max) 
			 "xsltproc" 
			 t t nil 
			 (expand-file-name "site-lisp/atom2rss.xsl"
                                           user-emacs-directory) "-")
    (goto-char (point-min))
    (message "Converting Atom to RSS... done")))

(ad-activate 'mm-url-insert)

(setf gnus-gcc-mark-as-read t)

(add-hook 'message-mode-hook (lambda ()
                               (turn-on-orgtbl)
                               (define-key message-mode-map (kbd "C-c C-w")
                                 'kill-region)
                               (define-key message-mode-map (kbd "C-M-o")
                                 'schweers/split-quoted-paragraph)))

(add-hook 'message-mode-hook (lambda ()
                               (turn-on-orgtbl)
                               (define-key message-mode-map (kbd "C-M-o")
                                 'schweers/split-quoted-paragraph)))
(bbdb-initialize)

(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-message)
