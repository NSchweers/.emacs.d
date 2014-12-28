(eval-after-load "haskell-mode"
  '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))

(eval-after-load "haskell-cabal"
  '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))

(provide 'setup-haskell-mode)
