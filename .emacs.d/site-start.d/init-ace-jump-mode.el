;; -*- mode:Emacs-Lisp coding:utf-8 -*-

(when (locate-library "ace-jump-mode")
  (define-key mode-specific-map (kbd "C-SPC") 'ace-jump-mode)
  )
(provide 'init-ace-jump-mode)