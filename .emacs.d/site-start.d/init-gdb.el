;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gdb-mode
;;->http://narupon.tdiary.net/20061022.html
(when (locate-library "gdb-ui")
  (setq gdb-many-windows t)
  (setq gdb-use-separate-io-buffer t)
  )

(provide 'init-gdb)