;; -*- lexical-binding: t -*-

(require 'mu4e)

(require 'epg-config)

(setf
 mu4e-use-fancy-chars nil
 mu4e-maildir "~/Mail"
 ;; mu4e-sent-folder "/Sent"
 ;; mu4e-drafts-folder "/Drafts"
 ;; mu4e-trash-folder "/Trash"
 mu4e-contexts
 `(,(make-mu4e-context
     :name "mailbox.org"
     :match-func
     (lambda (msg)
       (when msg
         (mu4e-message-contact-field-matches
          msg :to "NSchweers@mailbox.org")))
     :vars '((user-mail-address . "NSchweers@mailbox.org")
             (user-full-name . "Nathanael Schweers")
             (mu4e-sent-folder . "/mailbox.org/Sent")
             (mu4e-drafts-folder . "/mailbox.org/Drafts")
             (mu4e-trash-folder . "/mailbox.org/Trash")
             (mu4e-refile-folder . "/mailbox.org/Archive")))
   ,(make-mu4e-context
     :name "online.de"
     :match-func
     (lambda (msg)
       (when msg
         (mu4e-message-contact-field-matches
          msg :to "NSchweers@online.de")))
     :vars '((user-mail-address . "NSchweers@online.de")
             (user-full-name . "Nathanael Schweers")
             (mu4e-sent-folder . "/online.de/Sent")
             (mu4e-drafts-folder . "/online.de/Drafts")
             (mu4e-trash-folder . "/online.de/Trash")
             (mu4e-refile-folder . "/online.de/Archive"))))
 mml2015-use 'epg
 epg-user-id "gpg_key_id"
 mml-secure-openpgp-encrypt-to-self t
 mml-secure-openpgp-sign-with-sender t
 mu4e-compose-format-flowed t)

(add-to-list 'mu4e-bookmarks
             `(,(format "%s%s"
                        "date:today not list:emacs-devel.gnu.org not"
                        " list:help-gnu-emacs.gnu.org")
               "Today’s messages (without Emacs)" ?w))

(provide 'setup-mu4e)
