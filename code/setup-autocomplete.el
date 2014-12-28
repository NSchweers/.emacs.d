(require 'auto-complete)

(dolist (m (list 'clojure-mode-hook 'cider-repl-mode-hook 'emacs-lisp-mode-hook))
  (add-hook m (lambda () (auto-complete-mode))))

(provide 'setup-autocomplete)
