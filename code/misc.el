;; -*- lexical-binding: t -*-
(require 's)
(require 'dash)
(require 'dash-functional)

(defun recompile-emacs-d ()
  (interactive)
  (byte-recompile-directory (expand-file-name "code" user-emacs-directory) 0 t)
  (byte-compile-file (or user-init-file
                         (expand-file-name "init.el" user-emacs-directory))))

(defun file-in-emacs-d? (filename)
  (s-starts-with? (expand-file-name user-emacs-directory)
                  (expand-file-name filename)))

(defun recompile-if-emacs-d ()
  (let ((filename (buffer-file-name (current-buffer))
         ))
    (if (and (file-in-emacs-d? filename) (s-ends-with? ".el" filename))
        (condition-case nil
            (byte-compile-file filename)
          (error
           (ignore-errors (delete-file (byte-compile-dest-file filename))))))))

;; (defun schweers/ask-to-commit ()
;;   "If the file saved is in our emacs.d directory, check for unstaged data.

;; If unstaged files exist, ask the user whether they shall be autocommitted."
;;   (if (and
;;        (magit-anything-modified-p)
;;        (y-or-n-p-with-timeout
;;         (format "Uncommitted changes in repo %s.  %s"
;;                 (magit-get-top-dir
;;                  (file-name-directory (buffer-file-name)))
;;                 "Stage all and commit?  You have 5s to say yes.")
;;         5 nil))))


;;; Don’t use this, it is broken!
;; (defun schweers/ask-to-commit-and-push ()
;;   (interactive)
;;   "For each open repository which has uncommitted changes or unpushed commits,
;; to commit and/or push them."
;;   (let ((repos (make-hash-table :test 'equal)))
;;     (-each (buffer-list)
;;       (lambda (b)
;;         ;; Use a singleton list with sequencing functions as a poor mans Maybe
;;         ;; monad.
;;         (-when-let
;;             (repo-buf-name
;;              (car
;;               (-filter
;;                (-compose 'not 'null)
;;                (-map
;;                 (-compose 'magit-get-top-dir 'file-name-directory)
;;                 (-filter
;;                  'file-exists-p
;;                  (-filter
;;                   (-compose 'not 'null)
;;                   (-map 'buffer-file-name (list b))))))))
;;           (puthash repo-buf-name b repos))))
;;     (when (hash-table-count repos)
;;       (save-some-buffers))
;;     (maphash
;;      (lambda (r b)
;;        (with-current-buffer b
;;          (when (and (magit-anything-modified-p)
;;                     (y-or-n-p
;;                      (format "Uncommitted changes in repo %s.  %s"
;;                              r "Stage all and commit?")))
;;            (magit-stage-all)
;;            (magit-commit))))
;;      repos)
;;     (maphash
;;      (lambda (r b)
;;        (with-current-buffer b
;;          (save-window-excursion
;;            (call-interactively 'magit-status)
;;            (when (> (length (-filter
;;                              (lambda (c)
;;                                (eq (magit-section-type c) 'unpushed))
;;                              (magit-section-children magit-root-section)))
;;                     0)
;;              (when (y-or-n-p (format "Unpushed changes in repo %s.  Push now?"
;;                                      r))
;;                (magit-push))))))
;;      repos)
;;     t))

;; (defun schweers/remind-of-unstaged-or-unpushed ()
;;   (interactive)
;;   (let ((repos (make-hash-table :test 'equal)))
;;     (-each (buffer-list)
;;       (lambda (b)
;;         ;; Use a singleton list with sequencing functions as a poor mans Maybe
;;         ;; monad.
;;         (-when-let
;;             (repo-buf-name
;;              (car
;;               (-filter
;;                (-compose 'not 'null)
;;                (-map
;;                 (-compose 'magit-get-top-dir 'file-name-directory)
;;                 (-filter
;;                  'file-exists-p
;;                  (-filter
;;                   (-compose 'not 'null)
;;                   (-map 'buffer-file-name (list b))))))))
;;           (puthash repo-buf-name b repos))))
;;     (when (< 0 (hash-table-count repos))
;;       (save-some-buffers))
;;     (let ((res))
;;       (maphash
;;        (lambda (r b)
;;          (with-current-buffer b
;;            (when (or (magit-anything-modified-p)
;;                      (save-window-excursion
;;                        (call-interactively 'magit-status)
;;                        (if (< 0 (length (-filter
;;                                          (lambda (c)
;;                                            (eq (magit-section-type c) 'unpushed))
;;                                          (magit-section-children magit-root-section))))
;;                            t
;;                          nil)))
;;              (push (y-or-n-p (format "Unstaged or unpushed changes in repo %s.  %s"
;;                                      r "Are you sure you want to quit?"))
;;                    res))))
;;        repos)
;;       (-all? (-compose 'not 'null) res))))

;; (add-hook 'kill-emacs-query-functions 'schweers/remind-of-unstaged-or-unpushed)

(defun reload-emacs-conf ()
  (interactive)
  (load user-init-file))

;; Autocompile any elisp files in our emacs directory.
(add-hook 'after-save-hook 'recompile-if-emacs-d)

;; Open the init file on startup.
(find-file-noselect (expand-file-name "init.el" user-emacs-directory))

;;we want to have the compilation window scroll automatically
(setq compilation-scroll-output 'first-error)
(setq-default compile-command "make -k -j4 ")

(desktop-save-mode 1)
;;with this we try to save the desktop file when the emacs server is killed.
(add-hook 'kill-emacs-hook (lambda () (desktop-save user-emacs-directory)))

;; (defun misc/set-kill-and-delete-keys ()
;;   (local-set-key (kbd "C-w") 'backward-kill-word)
;;   (local-set-key (kbd "C-c C-w") 'kill-region)
;;   ;; Note on rebinding C-h: One merely needs to press any "help" key (e.g. F1).
;;   (local-set-key (kbd "C-h") 'delete-backward-char)
;;   (local-set-key (kbd "<f1>") 'help-command))

(defun misc/switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))

(global-set-key (kbd "C-S-s") 'misc/switch-to-scratch)

(defmacro misc/buffer-switch-hydra (hydra-name short-name key-prefix
                                               &rest heads)
  (declare (indent 3))
  `(global-set-key
    (kbd ,key-prefix)
    ,(append
      `(defhydra ,hydra-name (:color pink) ,short-name)
      (append
       (-map
        (-lambda ((key b-or-n hint))
          `(,key (lambda ()
                   (interactive)
                   (switch-to-buffer ,b-or-n))
                 ,hint))
        heads)
       '(("q" nil "quit" :color blue))))))

(add-hook 'erc-mode-hook (-partial 'auto-fill-mode 0))

(setq save-interprogram-paste-before-kill t)

(defun misc/new-setup (name &optional stage)
  "Create a new setup file, called setup-NAME.el in
~/.emacs.d/code/ which enables lexical scoping, contains the
appropriate provide and places point at the right position. 

If STAGE is non-nil, also stage the file with magit."
  ;; (interactive "MWhich package do you want to set up? \n")
  (interactive (list (read-string "Which package do you want to set up? ")
                     (if current-prefix-arg
                         (let ((p (if (consp current-prefix-arg)
                                      (car current-prefix-arg)
                                    current-prefix-arg)))
                           (if (or (null p) (eq p '-) (< p 0))
                               nil
                             t))
                       (y-or-n-p "Do you want to stage the file with magit? "))))
  (let ((proper-name (s-concat "setup-" name ".el")))
    (save-excursion
      (find-file
       (expand-file-name
        proper-name
        (expand-file-name "code" user-emacs-directory)))
      (when (or (buffer-narrowed-p) (/= (point-min) (point-max)))
        (error "File is not empty and/or the corresponding buffer is narrowed"))
      (goto-char (point-min))
      (if (not (string= (buffer-string) ""))
          (progn
            (forward-line 2)
            (indent-for-tab-command))
        (insert ";; -*- lexical-binding: t -*-\n\n\n\n(provide '")
        (insert (substring proper-name 0 (- (length proper-name) 3)))
        (insert ")\n")
        (forward-line -3)
        (indent-for-tab-command)
        (when stage
          (magit-stage-file (buffer-file-name)))
        (save-buffer)))))

(defun misc/hurra ()
  "Calls xdg-open (i.e. a browser) for a youtube search link for the song
„hurra“.

This song describes very nicely how it felt before and after knowing Emacs ;)"
  (interactive)
  (let* ((p (start-process
             "hurra" "hurra-out" "xdg-open"
             (s-concat "https://www.youtube.com/"
                       "results?search_query=die+%C3%A4rzte+hurra")))
         (pb (process-buffer p)))
    (set-process-sentinel
     p
     (lambda (_proc e)
       (cond ((string-match "finished" e)
              (kill-buffer pb)))))))

(defun misc/olbia (arg)
  "Downloads the menu of the Pizzeria Olbia in Frankfurt/Main.

Switches to the apropriate buffer if it already exists."
  (interactive "P")
  (let ((b (get-buffer "*Olbia*")))
    (cond (b (cond ((null arg) (switch-to-buffer b))
                   (t (switch-to-buffer-other-window b))))
          (t
           (url-retrieve
            "http://pizzeriaolbia.de/index_htm_files/Speisekarte%20032015.pdf"
            (lambda (_status)
              (rename-buffer "*Olbia*")
              (search-forward-regexp "%PDF")
              (beginning-of-line)
              (delete-region (point-min) (point))
              (doc-view-mode)
              (call-interactively #'misc/olbia)))))))

(defun schweers/split-quoted-paragraph ()
  "Split the quoted paragraph at point, making space for a reply, and fill the
rest of the paragraph.  This is useful in message-mode."
  (interactive)
  (let ((in-line (not (looking-at "[[:space:]]*$")))
        (level (save-excursion
                 (beginning-of-line)
                 (save-match-data
                   (if (looking-at ">*")
                       (- (match-end 0) (match-beginning 0))
                     0)))))
    (insert "\n")
    (delete-horizontal-space)
    (when (and in-line (> level 0))
      (insert (s-concat (s-repeat level ">") " ")))
    (beginning-of-line)
    (open-line (if in-line 3 2))
    (forward-line 1)
    (when in-line
      (save-excursion
        (forward-line 2)
;;; This binding is needed, so fill-paragraph won’t create an extra
;;; undo-boundary, which is normally done because of message-mode.
        (let ((fill-paragraph-function (lambda (&rest _) nil)))
          (fill-paragraph))))))

(defun remake-local-etags ()
  (interactive)
  (if (not (zerop
            (call-process "/bin/sh" nil nil nil
                          "-c" (format "cd %s; etags `find ./ -iname \\*.el`"
                                       user-emacs-directory))))
      (warn "etags failed.")))

(defmacro +let (&rest args)
  "Allows scheme like recursion.  

A symbol may be given as an additional first argument, the rest is like `let'.
If this extra argument is given, it is the name of a local function, which is
created by this macro.  The bindings given in the second argument give the names
of the arguments, and the values, with which the function is initially called."
  (let ((name (car args)))
    (if (symbolp name)
        (if (eq name nil)
            `(let ,@(cdr args))
          (let ((argnames (-map (lambda (binding)
                                  (if (consp binding)
                                      (car binding)
                                    binding))
                                (second args)))
                (init-args (-map (lambda (binding)
                                   (if (consp binding)
                                       (cadr binding)
                                     nil))
                                 (second args))))
            `(cl-labels ((,name ,argnames ,@(cddr args)))
               (,name ,@init-args))))
      `(let ,@args))))

;; (defun foo (&rest args)
;;   (message "I AM IN FOO!!!"))

(defun schweers/critical-mass-friday (date)
  (let ((friday?
         (+ 5 (do ((sunday? 1 (1+ sunday?)))
                  ((zerop (calendar-day-of-week
                           (list (first date) sunday? (third date))))
                   sunday?)))))
    (if (calendar-date-is-valid-p (list (first date) friday? (third date)))
        (if (calendar-date-equal (list (first date) friday? (third date)) date)
            "Critical Mass Frankfurt (19:00)"
          nil)
      (error "Bug in critical mass ffm friday"))))

(defun misc/list-C-funs ()
  (interactive)
  (cl-labels
      ;; I copied and bastardized this from `describe-function-1'
      ((from-C-source-p
        (function)
        (let* ((advised (and (symbolp function)
                             (featurep 'nadvice)
                             (advice--p (advice--symbol-function function))))
               ;; If the function is advised, use the symbol that has the
               ;; real definition, if that symbol is already set up.
               (real-function
                (or (and advised
                         (advice--cd*r (advice--symbol-function function)))
                    function))
               ;; Get the real definition.
               (def (if (symbolp real-function)
                        (or (symbol-function real-function)
                            (signal 'void-function (list real-function)))
                      real-function))
               (file-name (find-lisp-object-file-name function def)))
          (eq file-name 'C-source))))
    (with-current-buffer (generate-new-buffer "C functions")
      (insert "The following functions are implemented in C:\n\n")
      (mapatoms
       (lambda (x)
         (if (and (fboundp x) (from-C-source-p x))
             (insert (symbol-name x) "\n"))))
      (switch-to-buffer-other-window (current-buffer)))))

(defun toggle-frame-split ()
  "If the frame is split vertically, split it horizontally or vice versa.
Assumes that the frame is only split into two.

Got this from here: http://www.emacswiki.org/emacs/ToggleWindowSplit"
  (interactive)
  (unless (= (length (window-list)) 2) (error "Can only toggle a frame split in two"))
  (let ((split-vertically-p (window-combined-p)))
    (delete-window) ; closes current window
    (if split-vertically-p
        (split-window-horizontally)
      (split-window-vertically)) ; gives us a split with the other window twice
    (switch-to-buffer nil))) ; frame
                                        ; restore the original window in this part of the

(defun misc/mark-line ()
  (interactive)
  (beginning-of-line)
  (push-mark (point) t t)
  (end-of-line))

(defcustom tea-timer/alarm-clock-uri
  "http://www.orangefreesounds.com/wp-content/uploads/Zip/Old-alarm-clock-ringing.zip"
  "The command `tea-timer' will fetch the sound to play from this uri.")

(defcustom tea-timer/fname-regexp
  "\\(?:\\(?:mp3\\)\\|\\(?:mp4\\)\\|\\(?:ogg\\)\\|\\(?:wav\\)\\)\\)$"
  "A regexp which matches audio files.

The first matching file in an archive will be used as the sound of the alarm.")

(defun tea-timer/fetch-file (uri)
  "Fetch and possibly extract the file behind the uri.

Returns a local uri.  This function also tries to guess which file to pick if
pointed to a zip file containing more than one file."

  (let ((fname
         (f-join
          "~/tmp"
          (f-filename (url-filename
                       (url-generic-parse-url tea-timer/alarm-clock-uri))))))
    (let ((curl-proc
           (start-process
            "curl" " curl-buffer" "curl" "-o" fname tea-timer/alarm-clock-uri)))
      (set-process-sentinel
       curl-proc
       (lambda (proc status)
         (when (not (process-live-p proc))
           (let ((unzip-proc
                  (start-process
                   "unzip" " unzip-buffer" "unzip" fname
                   "-d" (f-dirname fname) fname)))
             (set-process-sentinel
              unzip-proc
              (lambda (proc status)
                (when (not process-live-p proc)
                  (f-move (f-join (f-dirname fname) ()))))))))))))

(defun tea-timer (duration &optional description)
  (interactive "sDuration: \nsEnter a description: ")
  (run-at-time duration nil
               (lambda ()
                 (start-process
                  "teetimer-sound-aplay"
                  " teetimer-sound-aplay"
                  "aplay"
                  "/home/schweers/downloads/alarm-clock.wav")
                 (message "%s" description))))

(defun schweers/adjust-font-height (fn arg)
  "Calls FN with the current font height and ARG.  Sets height to result."
  (set-face-attribute
   'default nil :height
   (funcall fn (face-attribute 'default :height) arg)))

(defun schweers/get-adjustment (arg)
  "Depending on ARG, return an int.

The returned integer represents by how much the font height shall be adjusted.

ARG is supposed to be in the form of a raw prefix argument.

If ARG is - set to the default font size \(see ‘schweers/default-font-height’\).
If ARG is an integer, return it as is.
If ARG is a list containing one int, return its log base 4 as an integer
\(i.e. how often C-u was pressed\) multiplied by 10.
If ARG is nil return 10."
  (cond ((null arg) 10)
        ((and (listp arg)
              (= (length arg) 1)
              (integerp (car arg)))
         (* 10 (floor (log (car arg) 4))))
        ((and (symbolp arg) (eq arg '-))
         schweers/default-font-height)
        ((integerp arg) 10)))

(defun schweers/increase-font (arg)
  "Increase the font size by 10 points.
If a prefix is given, increase by PREFIX points.
If C-u is pressed repeatedly, the font size is increased by 10 times the number
  of keystrokes."
  (interactive "P\n")
  (schweers/adjust-font-height
   (if (and (symbolp arg) (eq arg '-))
       (lambda (_cur new)
         new)
     #'+)
   (schweers/get-adjustment arg)))

(defun schweers/decrease-font (arg)
  "Increase the font size by 10 points.
If a prefix is given,decrease by PREFIX points.
If C-u is pressed repeatedly, the font size is decreased by 10 times the number
  of keystrokes."
  (interactive "P\n")
  (schweers/adjust-font-height
   (if (and (symbolp arg) (eq arg '-))
       (lambda (_cur new)
         new)
     #'-)
   (schweers/get-adjustment arg)))

(defun schweers/kill-buffer (arg)
  "Kill current buffer, unless called with prefix.

If prefix is present, ask which buffer to kill. "
  (interactive "P")
  (if arg
      (call-interactively 'kill-buffer)
    (kill-buffer (current-buffer))))

;; (defcustom )

;; (defun tee (name)
;;   (interactive ))

;; (completing-read "Which tee? " '(("Pfefferminz" 3) ("Kamille" 2)
;;                                 ("Earl Gray" 1))
;;                  nil t)

;; (start-process "teetimer-sound-aplay" " teetimer-sound-aplay"
;;                "aplay" "/home/schweers/downloads/alarm-clock.wav")

;; (defun rip/read-input-entry ()
;;   (let* ((b (point))
;;          (e (progn (end-of-line)
;;                    (point)))
;;          (s (buffer-substring b e)))
;;     (-if-let (m (string-match-p
;;                  (s-concat "\\(\\([[:digit:]]+\\):\\)?"
;;                            "\\([[:digit:]]\\{1,2\\}\\):"
;;                            "\\([[:digit:]]\\{1,2\\}\\)$")
;;                  s))
;;         (prog1 (list
;;                 :from (s-trim (buffer-substring-no-properties (+ b m) e))
;;                 :name (s-trim (buffer-substring-no-properties b (+ b m))))
;;           (beginning-of-line)
;;           (forward-line 1)))))

;; (defun rip/all-entries (buffer-or-name)
;;   (with-current-buffer (get-buffer buffer-or-name)
;;     (save-mark-and-excursion
;;      (loop for line = (rip/read-input-entry)
;;            while line collect line))))

;; (rip/all-entries "rip-input.org")

;; (defun rip/all-entries-with-times (buffer-or-name)
;;   (let ((lines (rip/all-entries buffer-or-name)))
;;     (seq-reduce
;;      (lambda (acc l)
;;        (cons l (cons (plist-put (car acc) :to (plist-get l :from)) (cdr acc))))
;;      (cdr lines) (list (car lines)))))

;; (defvar *rip/cmd-name* "ffmpeg")
;; (defvar *rip/buf-name* "ffmpeg")
;; (defvar *rip/proc-name* *rip/cmd-name*)
;; (defvar *rip/current-input-file*)

;; (setf *rip/current-input-file* "/home/schweers/dwhelper/The Best of Schubert.mp4")

;; (defun rip/process-entry (e trackname)
;;   (apply #'start-process *rip/proc-name* *rip/buf-name* *rip/cmd-name*
;;          `("-i" ,*rip/current-input-file* "-vn" "-acodec" "libvorbis" "-aq"
;;            "5" "-ss" ,(plist-get e :from)
;;            ,@(when (plist-get e :to)
;;                `("-to"
;;                  ,(plist-get e :to)))
;;            ,trackname)))

;; (defvar *proc*
;;   (rip/procces-entry
;;    (second (reverse (rip/all-entries-with-times "rip-input.org")))))

;; (defun rip/rip-file (in-file target-dir)
;;   (seq-map
;;    (let ((i 0))
;;      (lambda (e)
;;        (incf i)
;;        (rip/process-entry e (format "%s/track%s.ogg" target-dir i))))
;;    (let ((*rip/current-input-file* in-file))
;;      (reverse (rip/all-entries-with-times "rip-input.org")))))

(provide 'misc)
