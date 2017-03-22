(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   (quote
    (((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Okular")
     (output-html "xdg-open"))))
 '(ac-use-quick-help t)
 '(auth-source-save-behavior nil)
 '(auth-sources (quote ("~/.emacs_data/authinfo.gpg")))
 '(calendar-week-start-day 1)
 '(collection-roots (quote ("/mnt/data/video/serien/")))
 '(elmo-imap4-default-authenticate-type (quote clear))
 '(erc-autojoin-channels-alist (quote (("freenode.net" "#org-mode" "#neo"))))
 '(erc-nick "schweers")
 '(erc-prompt-for-channel-key t)
 '(erc-timestamp-format-right " [%H:%M:%S]")
 '(gnus-home-directory "~/.emacs.d/")
 '(haskell-mode-hook (quote (turn-on-haskell-indentation)) t)
 '(jabber-account-list
   (quote
    (("schweers@3suns.de/emacs"
      (:connection-type . starttls)))))
 '(jabber-invalid-certificate-servers (quote ("3suns.de")))
 '(jabber-roster-show-bindings nil)
 '(jabber-show-resources (quote always))
 '(jabber-vcard-avatars-retrieve nil)
 '(mew-rc-file "~/.emacs.d/mew")
 '(notmuch-address-internal-completion (quote (received nil)))
 '(notmuch-saved-searches
   (quote
    ((:name "inbox" :query "tag:inbox" :key "i")
     (:name "flagged" :query "tag:flagged" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "drafts" :query "tag:draft" :key "d")
     (:name "all mail" :query "*" :key "a")
     (:name "gitlab" :query "tag:gitlab" :key "g")
     (:name "unread" :query "tag:unread" :key "u"))))
 '(openwith-associations nil)
 '(org-agenda-files (quote ("~/.emacs_data/notes.org.gpg")))
 '(org-export-backends
   (quote
    (ascii html icalendar latex beamer texinfo odt md man)))
 '(org-latex-default-packages-alist
   (quote
    (("AUTO" "inputenc" t)
     ("T1" "fontenc" t)
     ("" "fixltx2e" nil)
     ("" "graphicx" t)
     ("" "longtable" nil)
     ("" "float" nil)
     ("" "wrapfig" nil)
     ("" "rotating" nil)
     ("normalem" "ulem" t)
     ("" "amsmath" t)
     ("" "textcomp" t)
     ("" "marvosym" t)
     ("" "wasysym" t)
     ("" "amssymb" t)
     ("hidelinks" "hyperref" nil)
     "\\tolerance=1000")))
 '(package-selected-packages
   (quote
    (notmuch bash-completion edit-server helm-gtags tracwiki-mode async tramp-term bbdb-vcard evil-org evil-lispy evil-magit rust-mode htmlize csharp-mode elfeed evil markdown-mode shell-command undo-tree ace-jump-mode helm jabber expand-region ac-slime browse-kill-ring ace-link multiple-cursors bbdb auctex elpy magit auto-complete lispy guide-key org paren-face crux helm-projectile projectile cider racer cargo clojure-mode w3m json-mode f geiser diminish s dash-functional hydra use-package dash lua-mode)))
 '(rcirc-default-nick "schweers")
 '(rcirc-default-user-name "schweers")
 '(rcirc-fill-column (quote frame-width))
 '(rcirc-server-alist
   (quote
    (("3suns.de" :port 6666 :channels
      ("&bitlbee")
      nil nil)
     ("irc.freenode.net" :channels
      ("#neo" "#informatik-ag")
      nil nil))))
 '(send-mail-function (quote smtpmail-send-it)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow")))))
