;; -*- mode:Emacs-Lisp coding:utf-8 -*-

(when (locate-library "cycle-buffer")
  (require 'cycle-buffer)
  (defun switch-cycle-buffer-or-other-window ()
    (interactive)
    (if (one-window-p t)
        (cycle-buffer 1)
      (other-window 1)))
  (define-key global-map "\C-o" 'switch-cycle-buffer-or-other-window)
  )

(provide 'init-cycle-buffer)