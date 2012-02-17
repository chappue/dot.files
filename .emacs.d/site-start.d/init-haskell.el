;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; haskell-mode
;;-> http://www.haskell.org/haskell-mode/
(when (locate-library "haskell-mode")
  (autoload 'haskell-mode "haskell-mode"
    "Major mode for editing Haskell scripts." t)
  (autoload 'literate-haskell-mode "haskell-mode"
    "Major mode for editing literate Haskell scripts." t)
  )

(provide 'init-haskell)