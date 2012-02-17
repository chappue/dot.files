;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; color-theme
;;-> http://www.emacswiki.org/cgi-bin/emacs-en?ColorTheme
(when (locate-library "color-theme")
  (require 'color-theme)
  (color-theme-initialize)
  (color-theme-charcoal-black)
  ;;(color-theme-gnome2)
  ;;(color-theme-arjen)
  ;;(color-theme-hober)
  )

(provide 'init-color-theme)