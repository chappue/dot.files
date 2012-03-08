;; -*- mode:Emacs-Lisp coding:utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; find-file
(when (locate-library "find-file")
  (add-hook 'c-mode-common-hook
            (lambda ()
              (define-key c-mode-base-map (kbd "C-c C-o") 'ff-find-other-file)
              ))
  )

(provide 'init-find-file)