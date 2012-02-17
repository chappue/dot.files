;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ruby-mode
;;-> http://www.ruby-lang.org/cgi-bin/cvsweb.cgi/ruby/misc/
(when (locate-library "ruby-mode")
  (autoload 'ruby-mode "ruby-mode"
    "Mode for editing ruby source files" t)
  (setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                       interpreter-mode-alist))
  (autoload 'run-ruby "inf-ruby"
    "Run an inferior Ruby process")
  (autoload 'inf-ruby-keys "inf-ruby"
    "Set local key defs for inf-ruby in ruby-mode")
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (inf-ruby-keys)))
  )

(provide 'init-ruby)