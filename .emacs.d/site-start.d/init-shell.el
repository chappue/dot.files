;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Shell-mode
;;-> http://www.namazu.org/~tsuchiya/elisp/#shell-command-with-completion
(when (locate-library "shell")
  (when (locate-library "ansi-color")
    (autoload 'ansi-color-for-comint-mode-on "ansi-color"
      "Set `ansi-color-for-comint-mode' to t." t)
    (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
    )

  ;; password protect
  (add-hook 'comint-output-filter-functions
            'comint-watch-for-password-prompt)
  )

(provide 'init-shell)