;; -*- mode:Emacs-Lisp coding:utf-8 -*-

(when (locate-library "expand-region")
  (require 'expand-region)
  (define-key global-map (kbd "C-@") 'er/expand-region)
  (define-key global-map (kbd "C-M-@") 'er/contract-region)
  )

(provide 'init-expand-region)
