;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dsvn
;;->http://svn.collab.net/repos/svn/trunk/contrib/client-side/emacs/dsvn.el
(when (locate-library "dsvn")
;;   (autoload 'svn-status "dsvn" "Run `svn status'." t)
;;   (autoload 'svn-update "dsvn" "Run `svn update'." t)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; psvn
;;->http://www.xsteve.at/prg/emacs/psvn.el
(when (locate-library "psvn")
  (require 'psvn)
  )

(provide 'init-svn)