;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; slime
;;->http://common-lisp.net/project/slime/
(when (locate-library "slime")
  (require 'slime)
  (setq inferior-lisp-program (expand-file-name "~/Source/clisp-2.43/build-with-gcc/clisp"))
;;  (setq slime-net-coding-system 'utf-8-unix)
  (setq slime-lisp-implementations
      '((clisp ("~/Source/clisp-2.43/build-with-gcc/clisp") :coding-system utf-8-unix)))
  )

(provide 'init-lisp)