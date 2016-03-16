;; -*- lexical-binding: t -*-
;;; init-wanderlust.el --- Initialisation file for Wanderlust E-mail client

;;; Commentary:

;;; Code:

(defvar schweers/wl-default-directory (concat user-emacs-directory "wl/"))

;; Load Wanderlust and dependencies
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
(autoload 'wl-user-agent-compose "wl-draft" nil t)
(autoload 'elmo-split "elmo-split" "Split messages on the folder." t)

;; Default username and e-mail address
(setq user-mail-address "NSchweers@mailbox.org"
      user-full-name "Nathanael Schweers")

(setq wl-user-mail-address-list '("NSchweers@secure.mailbox.org"
                                  "NSchweeers@mailbox.org" "NSchweers@online.de")
      wl-template-alist
      '(("secure.mailbox.org"
         (wl-from . "Nathanael Schweers <NSchweeers@secure.mailbox.org>")
         ("From" . wl-from)
         (wl-smtp-posting-user . "NSchweers@mailbox.org")
         (wl-smtp-posting-server . "smtp.mailbox.org")
         (wl-smtp-authenticate-type . "plain")
         (wl-smtp-connection-type . 'ssl)
         (wl-smtp-posting-port . 465)
         (wl-local-domain . "mailbox.org")
         (wl-message-id-domain . "smtp.mailbox.org"))
        ("mailbox.org"
         (wl-from . "Nathanael Schweers <NSchweeers@mailbox.org>")
         ("From" . wl-from)
         (wl-smtp-posting-user . "NSchweers@mailbox.org")
         (wl-smtp-posting-server . "smtp.mailbox.org")
         (wl-smtp-authenticate-type . "plain")
         (wl-smtp-connection-type . 'ssl)
         (wl-smtp-posting-port . 465)
         (wl-local-domain . "mailbox.org")
         (wl-message-id-domain . "smtp.mailbox.org"))
        ("online.de"
         (wl-from . "Nathanael Schweers <NSchweeers@online.>")
         ("From" . wl-from)
         (wl-smtp-posting-user . "NSchweers@online.de")
         (wl-smtp-posting-server . "mail.1und1.de")
         (wl-smtp-authenticate-type . "plain")
         (wl-smtp-connection-type . 'ssl)
         (wl-smtp-posting-port . 465)
         (wl-local-domain . "online.de")
         (wl-message-id-domain . "mail.1und1.de"))))

;; Default message composing
(setq mail-user-agent 'wl-user-agent)
(define-mail-user-agent
  'wl-user-agent
  'wl-user-agent-compose
  'wl-draft-send
  'wl-draft-kill
  'mail-send-hook)

;; IMAP
(setq elmo-imap4-default-server "imap.mailbox.org"
      elmo-imap4-default-user "NSchweers@mailbox.org"
      elmo-imap4-default-authenticate-type 'clear
      elmo-imap4-default-port '993
      elmo-imap4-default-stream-type 'ssl

      ;;for non ascii-characters in folder-names
      elmo-imap4-use-modified-utf7 t
      wl-folder-check-async t)

;; SMTP
(setq wl-smtp-connection-type 'ssl
      wl-smtp-posting-port 465
      wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "NSchweers@mailbox.org"
      wl-smtp-posting-server "smtp.mailbox.org"
      ;wl-local-domain "grobwiefein.de"
      ;wl-message-id-domain "mail.grobwiefein.de"
      )

;; Mail and IMAP folder settings
(setq wl-from "Nathanael Schweers <NSchweers@secure.mailbox.org>"

      ;;all system folders (draft, trash, spam, etc) are placed in the
      ;;[Gmail]-folder, except inbox. "%" means it's an IMAP-folder
      wl-default-folder "%Inbox"
      wl-draft-folder "%Drafts"
      wl-trash-folder "%Trash"
      wl-fcc "%Sent"
      wl-spam-folder "%Junk"

      ;; mark sent messages as read (sent messages get sent back to you and
      ;; placed in the folder specified by wl-fcc)
      wl-fcc-force-as-read t

      ;;for when auto-compleating foldernames
      wl-default-spec "%"

      ;; Do not guess thread membership by subject
      wl-summary-search-parent-by-subject-regexp nil)

;; Displayed mail headers
(setq wl-message-ignored-field-list '("^.*:"))
(setq wl-message-visible-field-list
      '("^To:"
        "^Cc:"
        "^From:"
        "^Subject:"
        "^Date:"))

;; Local folder settings
(setq elmo-msgdb-directory schweers/wl-default-directory
      elmo-localdir-folder-path (concat schweers/wl-default-directory
                                        "localdir")
      wl-folders-file (concat schweers/wl-default-directory "folders"))

;; Spam settings
(require 'wl-spam)

;; Signature settings
(setq mail-signature-file (concat schweers/wl-default-directory "signature"))

;; Modes for composing messages
(add-hook 'wl-draft-mode-hook
          (lambda () (turn-on-orgtbl)))

;; Notification
(setq wl-biff-check-folder-list '("%Inbox")
      ;; wl-biff-notify-hook 'notify/new-email
      )

;; Disable creating mime-example file
(setq mime-situation-examples-file nil)

;; PGP
(setq mime-pgp-verify-when-preview t
      mime-pgp-decrypt-when-preview t)

;; Ask before sending mail
(add-hook 'wl-draft-send-hook (lambda ()
                                (call-interactively #'mime-edit-set-encrypt)))

(setq mime-acting-situation-example-list
      '((((type . application)
          (subtype . pgp-encrypted)
          (mode . "play")
          (method . mime-decrypt-application/pgp-encrypted)
          (major-mode . wl-original-message-mode)
          (body)
          (body-presentation-method . mime-preview-application/pgp-encrypted)
          (encoding . "7bit"))
         . 1)))

;; Keybinding for checking new mail
(global-set-key (kbd "<f9>") 'wl-biff-check-folders)

;; Don’t put me in CC
(setq wl-draft-reply-without-argument-list
      '(("Reply-To" ("Reply-To") nil nil)
        ("Mail-Reply-To" ("Mail-Reply-To") nil nil)
        ("From" ("From") nil nil)))

(setq wl-draft-reply-with-argument-list
      '(("Followup-To" nil nil ("Followup-To"))
        ("Mail-Followup-To" ("Mail-Followup-To") nil ("Newsgroups"))
        ("Reply-To" ("Reply-To") ("To" "Cc" "From") ("Newsgroups"))
        ("From" ("From") ("To" "Cc") ("Newsgroups"))))

; Please don’t bother me with messages smaller than 1M.
(setq wl-message-buffer-prefetch-threshold 100000000)

;; Split mail
;; (setq elmo-split-folder '("%inbox")
;;       elmo-split-rule '(((or (address-match to "talk@pug.org")
;;                              (match subject "\\[PUG\\]"))
;;                          "1&1/PUG")))

;; Set up sane keybindings.

(add-hook 'wl-draft-mode-hook
          (lambda ()
            (local-set-key (kbd "C-w") 'backward-kill-word)
            (local-set-key (kbd "C-c C-w") 'kill-region)
            (local-set-key (kbd "C-h") 'delete-backward-char)
            (local-set-key (kbd "<f1>") 'help-command)
            (local-set-key (kbd "M-t") 'hydra-transpose/body)
            (local-set-key (kbd "C-x -") 'hydra-resize-window/body)
            (local-set-key (kbd "C-x t") 'hydra-toggle/body)
            (local-set-key (kbd "M-o") 'occur)
            (local-set-key (kbd "C-x C-b") 'ibuffer-other-window)
            (local-set-key (kbd "M-j") 'eval-print-last-sexp)
            (local-set-key (kbd "C-M-o") 'schweers/split-quoted-paragraph)
            (local-set-key (kbd "C-M-l") 'wl-draft-highlight-and-recenter)
            (local-set-key (kbd "C-l") 'recenter-top-bottom)
            ;; Save every 10 minutes
            (setq wl-auto-save-drafts-interval (* 600))))

;; (add-hook
;;  'wl-draft-mode-hook
;;  (lambda () 
;;   (cl-flet
;;        ((find-my-bindings
;;          (e)
;;          (eq (car e) 'schweers-bindings-mode)))
;;      (add-to-list
;;       'minor-mode-overriding-map-alist
;;       (car (-filter 'find-my-bindings minor-mode-map-alist)))
;;      (setq minor-mode-map-alist
;;            (-remove-first 'find-my-bindings minor-mode-map-alist)))))

(provide 'setup-wanderlust)
