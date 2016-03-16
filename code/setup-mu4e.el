;; -*- lexical-binding: t -*-

(use-package mu4e
  :config
  (setf mu4e-maildir "~/offlineImapMail/1und1"
        mu4e-sent-folder "/Sent"
        mu4e-drafts-folder "/Drafts"
        mu4e-trash-folder "/Trash"
        mu4e-refile-folder "/Archive"
        mu4e-get-mail-command "true"
        mu4e-update-interval 30))

(provide 'setup-mu4e)
