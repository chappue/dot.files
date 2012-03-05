;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; color-theme
;;-> http://www.emacswiki.org/cgi-bin/emacs-en?ColorTheme
(when (locate-library "color-theme")
  (require 'color-theme)
  ;; (setq color-theme-libraries (list "~/.emacs.d/lisp/color-theme-library.el"))
  (setq color-theme-load-all-themes nil)
  (setq color-theme-directory "~/.emacs.d/share/color-theme")
  (color-theme-initialize)
  ;; (color-theme-zenburn)
  ;; (color-theme-dark)
  (color-theme-charcoal-black)
  ;; (color-theme-gnome2)
  ;; (color-theme-arjen)
  ;; (color-theme-hober)
  )

(provide 'init-color-theme)