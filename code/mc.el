;; -*- lexical-binding: t -*-
(require 'minecraft-report)

(defun mc-regen-file (file)
  (interactive "fFile to regenerate: ")
  (report/regen-file file)
  (revert-buffer nil t t))

(defun mc-table-from-list (buffer-or-name)
  (interactive "bBuffer to create an org-table from: ")
  (report/org-table (report/from-buffer buffer-or-name t t) nil t t))

(defun mc-table-from-file (filename)
  (interactive "fFile to create an org-table from: ")
  (report/org-table (report/from-file filename t t) nil t t))

(defun mc-table-to-list (table-buffer-or-name list-buffer-or-name)
  "Convert the table in TABLE-BUFFER-OR-NAME to a sorted list of
key-value pairs, and write the result to LIST-BUFFER-OR-NAME.  "
  (interactive "bBuffer with table: \nBBuffer to place list in: ")
  (report/to-buffer (report/from-table table-buffer-or-name)
                    list-buffer-or-name))

(provide 'mc)
