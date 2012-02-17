;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; uniquify
;;->http://www.gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html
(when (locate-library "uniquify")
  (require 'uniquify)
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq uniquify-ignore-buffers-re "*[^*]+*")
  )

(provide 'init-uniquify)