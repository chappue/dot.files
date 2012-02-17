;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gnuplot-mode
;;-> http://feff.phys.washington.edu/~ravel/software/gnuplot-mode/Welcome.html
(when (locate-library "gnuplot")
  (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
  (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot-mode" t)
)

(provide 'init-gnuplot)