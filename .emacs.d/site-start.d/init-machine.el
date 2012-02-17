;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;;                 Machine specification settings
;;------------------------------------------------------------------

(cond
 ((equal system-name "trona.local") (load-safe "~/.emacs.d/site-start.d/machine/init-trona.el"))
 ((equal system-name "zircon") (load "~/.emacs.d/site-start.d/machine/init-zircon.el"))
 ((equal system-name "1H1_704") (load "~/.emacs.d/site-start.d/machine/init-1H1_704.el"))
 ((equal system-name "1H1_1034") (load "~/.emacs.d/site-start.d/machine/init-1H1_1034.el"))
 (t (load "~/.emacs.d/site-start.d/machine/init-defult.el"))
 )

(provide 'init-machine)