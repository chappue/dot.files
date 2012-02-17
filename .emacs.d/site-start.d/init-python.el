;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python-mode
;;->http://www.emacswiki.org/cgi-bin/wiki/PythonMode
(when (locate-library "python-mode")
  (autoload 'python-mode "python-mode" "Python Mode." t)
  (setq py-indent-offset tab-width)
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  (add-hook 'python-mode-hook
            (function (lambda() (setq indent-tabs-mode nil))))
  )

(provide 'init-python)