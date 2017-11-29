(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-use-quick-help t)
 '(auth-source-save-behavior nil)
 '(auth-sources (quote ("~/.emacs_data/authinfo.gpg")))
 '(calendar-week-start-day 1)
 '(collection-roots (quote ("/mnt/data/video/serien/")))
 '(company-backends
   (quote
    (company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files company-oddmuse company-dabbrev)))
 '(elmo-imap4-default-authenticate-type (quote clear))
 '(erc-autojoin-channels-alist nil)
 '(erc-autojoin-mode t)
 '(erc-button-mode t)
 '(erc-fill-mode t)
 '(erc-highlight-nicknames-mode t)
 '(erc-irccontrols-mode t)
 '(erc-list-mode t)
 '(erc-match-mode t)
 '(erc-menu-mode t)
 '(erc-modules
   (quote
    (completion move-to-prompt notifications readonly ring services highlight-nicknames netsplit fill button match track readonly networks ring autojoin noncommands irccontrols move-to-prompt stamp menu list)))
 '(erc-move-to-prompt-mode t)
 '(erc-netsplit-mode t)
 '(erc-networks-mode t)
 '(erc-nick "schweers")
 '(erc-noncommands-mode t)
 '(erc-notifications-mode t)
 '(erc-pcomplete-mode t)
 '(erc-prompt-for-channel-key t)
 '(erc-readonly-mode t)
 '(erc-ring-mode t)
 '(erc-stamp-mode t)
 '(erc-timestamp-format-right " [%H:%M:%S]")
 '(erc-track-minor-mode t)
 '(erc-track-mode t)
 '(gc-cons-percentage 0.3)
 '(global-company-mode t)
 '(gnus-home-directory "~/.emacs.d/")
 '(haskell-mode-hook (quote (turn-on-haskell-indentation)))
 '(jabber-account-list
   (quote
    (("schweers@3suns.de/emacs"
      (:connection-type . starttls)))))
 '(jabber-invalid-certificate-servers (quote ("3suns.de")))
 '(jabber-roster-show-bindings nil)
 '(jabber-show-resources (quote always))
 '(jabber-vcard-avatars-retrieve nil)
 '(magit-diff-section-arguments (quote ("--no-ext-diff" "-M")))
 '(mew-rc-file "~/.emacs.d/mew")
 '(notmuch-address-internal-completion (quote (received nil)))
 '(notmuch-saved-searches
   (quote
    ((:name "inbox" :query "tag:inbox" :key "i")
     (:name "flagged" :query "tag:flagged" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "drafts" :query "tag:draft")
     (:name "all mail" :query "*" :key "a")
     (:name "gitlab" :query "tag:gitlab" :key "g")
     (:name "unread" :query "tag:unread" :key "u")
     (:name "unread-inbox" :query "tag:inbox and tag:unread" :key "n")
     (:name "debian-user" :query "tag:debian-user" :key "d")
     (:name "karme" :query "tag:karme" :key "k")
     (:name "notmuch" :query "tag:notmuch" :key "m")
     (:name "hetzner-support" :query "tag:hetzner-support" :key "h"))))
 '(openwith-associations nil)
 '(org-agenda-files nil)
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
     ("" "hyperref" nil)
     "\\tolerance=1000")))
 '(package-selected-packages
   (quote
    (flx ivy-hydra counsel smartscan org-plus-contrib edit-server dumb-jump flycheck-rust cargo rust-mode protobuf-mode cmake-mode tramp-term lua-mode flycheck-haskell haskell-mode elfeed w3m paren-face helm-projectile projectile cider clojure-mode undo-tree helm-swoop expand-region js2-mode browse-kill-ring ace-link multiple-cursors notmuch bbdb auctex markdown-mode graphviz-dot-mode htmlize elpy magit helm-company slime-company company lispy which-key shell-command bash-completion json-mode f dash-functional dash async paradox use-package)))
 '(paradox-github-token t)
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
