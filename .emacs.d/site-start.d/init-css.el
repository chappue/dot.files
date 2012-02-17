;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; css-mode
;;-> http://www.garshol.priv.no/download/software/css-mode/
(when (locate-library "css-mode")
  (setq cssm-indent-function #'cssm-c-style-indenter)
  (setq cssm-indent-level 2)
  )

(provide 'init-css)