;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mcomplete
;;-> http://homepage1.nifty.com/bmonkey/emacs/
(when (locate-library "mcomplete")
  (require 'mcomplete)
  (require 'cl)
  (load "mcomplete-history")
  (turn-on-mcomplete-mode)
  ;; set faces
  (set-face-foreground 'mcomplete-prefix-method-fixed-part-face "orange red")
  (set-face-foreground 'mcomplete-prefix-method-alternative-part-face "red")
  (set-face-foreground 'mcomplete-substr-method-fixed-part-face "orange red")
  (set-face-foreground 'mcomplete-substr-method-alternative-part-face "red")
  )

(provide 'init-mcomplete)