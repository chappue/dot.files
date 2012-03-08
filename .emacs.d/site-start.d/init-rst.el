;; -*- mode:Emacs-Lisp coding:utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rst-mode
;;-> http://docutils.sourceforge.net/rst.html
(when (locate-library "rst")
  (require 'rst)
  (setq frame-background-mode 'dark)
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(rst-level-1-face ((t (:foreground "LightSkyBlue"))) t)
   '(rst-level-2-face ((t (:foreground "LightGoldenrod"))) t)
   '(rst-level-3-face ((t (:foreground "Cyan1"))) t)
   '(rst-level-4-face ((t (:foreground "chocolate1"))) t)
   '(rst-level-5-face ((t (:foreground "PaleGreen"))) t)
   '(rst-level-6-face ((t (:foreground "Aquamarine"))) t)
   '(rst-level-7-face ((t (:foreground "LightSteelBlue"))) t)
   '(rst-level-8-face ((t (:foreground "LightSalmon"))) t))
  )

(provide 'init-rst)