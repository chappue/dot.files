;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keisen-mode
;;-> http://pitecan.com/Keisen/keisen.el
(when (locate-library "keisen")
  (autoload 'keisen-up-move "keisen" nil t)
  (autoload 'keisen-down-move "keisen" nil t)
  (autoload 'keisen-left-move "keisen" nil t)
  (autoload 'keisen-right-move "keisen" nil t)
  ;; Ctrl-Arrow
  (global-set-key [C-right] 'keisen-right-move)
  (global-set-key [C-left]  'keisen-left-move)
  (global-set-key [C-up]    'keisen-up-move)
  (global-set-key [C-down]  'keisen-down-move)
  )

(provide 'init-keisen)