;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lcomp
;;-> http://www.geocities.co.jp/SiliconValley-Oakland/7673/
(when (locate-library "lcomp")
  (require 'lcomp)
  (lcomp-install))

(provide 'init-lcomp)