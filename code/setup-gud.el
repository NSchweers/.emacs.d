;; -*- lexical-binding: t -*-

(global-set-key
 (kbd "<f9>")
 (defhydra hydra-gud (:color pink)
   "GUD"
   ("n" gud-next "next line")
   ("s" gud-step "step line")
   ("c" gud-go "continue")
   ("f" gud-finish "finish function")
   ("b" gud-break "set breakpoint")
   ("p" gud-print "print expr")
   ("d" gud-pstar "print deref")
   ("C-s" gud-pp "print sexp")
   ("<" gud-up "up stack")
   (">" gud-down "down stack")
   ("l" gud-refresh "refresh")
   ("q" nil "quit hydra")))

(provide 'setup-gud)
