;; -*- mode:Emacs-Lisp coding:utf-8 -*-

(when (locate-library "mark-multiple")
;;   (require 'inline-string-rectangle)
;;   (global-set-key (kbd "C-x r t") 'inline-string-rectangle)

  (require 'mark-more-like-this)
  (global-set-key (kbd "C-<") 'mark-previous-like-this)
  (global-set-key (kbd "C->") 'mark-next-like-this)

  (add-hook 'sgml-mode-hook
            (lambda ()
              (require 'rename-sgml-tag)
              (define-key sgml-mode-map (kbd "C-c C-r") 'rename-sgml-tag)))
  )

(provide 'init-mark-multiple)
