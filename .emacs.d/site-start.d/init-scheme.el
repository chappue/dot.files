;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; scheme-mode
(when (locate-library "scheme-mode")
;;  (setq scheme-program-name (expand-file-name "~/Source/Gauche-0.8.9/src/gosh"))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; quack-mode
;;-> http://www.neilvandyke.org/quack/
(when (locate-library "quack")
  (require 'quack)
  (setq quack-dir "~/.emacs.d/quack")
  )

(provide 'init-scheme)