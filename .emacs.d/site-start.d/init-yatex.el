;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; YaTex
;;-> http://www.yatex.org/
(when (locate-library "yatex")
  (autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)
  (autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
  (setq tex-command "/usr/local/bin/platex")
  (setq dvi2-command "/Applications/Mxdvi.app/Contents/MacOS/Mxdvi")
  ;; YaTex 1:Shift-JIS 2:JIS 3:EUC
  (setq YaTeX-kanji-code 3)
  )

(provide 'init-yatex)