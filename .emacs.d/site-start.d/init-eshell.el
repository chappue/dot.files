;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eshell
(when (locate-library "eshell")
  (setq eshell-history-size 10000)
  (setq eshell-hist-ignoredups t)
  (setq eshell-ask-to-save-history (quote always))
  (setq eshell-cmpl-ignore-case t)
  (setq eshell-cmpl-cycle-completions t)
  (setq eshell-cmpl-cycle-cutoff-length 5)

  ;; prompt
  (setq eshell-prompt-function
        (lambda ()
          (concat
           "[" (format-time-string "%Y/%m/%d(%a) %H:%M") "]"
           "["
           (user-login-name) "@" (system-name) " "
           (eshell/pwd)
           "]\n"
           (if (= (user-uid) 0)
               "#"
             "$")
           " "
           )))
  (setq eshell-prompt-regexp "^[^#$]*[$#] ")

  ;; keybindings
  (add-hook 'eshell-mode-hook
            #'(lambda ()
                (progn 
                  (local-set-key "\C-a" 'eshell-bol)
                  (local-set-key "\C-p" 'eshell-previous-matching-input-from-input)
                  (local-set-key "\C-n" 'eshell-next-matching-input-from-input)
                )))
  )

(provide 'init-eshell)