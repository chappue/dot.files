;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; markdown-mode
;;-> http://jblevins.org/projects/markdown-mode/
(when (locate-library "markdown-mode")
  (autoload 'markdown-mode "markdown-mode.el"
    "Major mode for editing Markdown files" t)
  )

(provide 'init-markdown)