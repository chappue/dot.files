;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; php-mode
;;-> http://php-mode.sourceforge.net/
(when (locate-library "php-mode")
  (autoload 'php-mode "php-mode" "Major mode for editing PHP code." t)
  )

(provide 'init-php)