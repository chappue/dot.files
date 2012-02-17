;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet
;;->http://code.google.com/p/yasnippet/
(when (locate-library "yasnippet")
  (require 'yasnippet)
  (require 'dropdown-list)
  (setq yas/prompt-functions '(yas/dropdown-prompt
                               yas/ido-prompt
                               yas/completing-prompt))
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/share/snippets")
  (define-key global-map [?\C-\:] 'yas/expand)
  (add-hook 'find-file-hooks 'yas/minor-mode-on)
  )

(provide 'init-yasnippet)