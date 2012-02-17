;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacs-w3m
;;-> http://emacs-w3m.namazu.org/
(when (locate-library "w3m-load")
  (require 'w3m-load)
  (setq w3m-init-file (expand-file-name "~/.emacs.d/w3m/.emacs-w3m.el"))
  (setq w3m-profile-directory "~/.emacs.d/w3m")
  (setq w3m-home-page
        (concat "file://" (expand-file-name "bookmark.html" w3m-profile-directory)))
  )

(provide 'init-w3m)