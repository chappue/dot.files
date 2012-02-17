;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; js2-mode
;;->http://code.google.com/p/js2-mode/
(when (locate-library "js2")
  (autoload 'js2-mode "js2" nil t)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  )

(provide 'init-javascript)