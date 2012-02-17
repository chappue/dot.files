;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; migemo
;;  japanease incrimental search
;;->http://namazu.org/~satoru/migemo/
(when (and (locate-library "migemo") (not (featurep 'migemo)))
  (defvar migemo-coding-system 'japanese-shift-jis-unix)
  (defvar migemo-command "cmigemo")
  (defvar migemo-directory "C:/tanemura_work/application/meadow/packages/etc/migemo")
  (defvar migemo-options (list "-q" "--emacs"))

  (require 'migemo)
  (migemo-init)
  )

(provide 'init-migemo)