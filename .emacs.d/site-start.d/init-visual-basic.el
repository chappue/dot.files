;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; visual-basic-mode
(when (locate-library "visual-basic-mode")
  (autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
  (setq auto-mode-alist (append '(("\\.\\(frm\\|bas\\|cls\\|vbs\\|vb\\)$" . 
                                   visual-basic-mode)) auto-mode-alist))
  (add-hook 'visual-basic-mode-hook
            '(lambda () (setq mode-name "vb")))

  (when (locate-library "xcscope")
    (add-hook 'visual-basic-mode-hook (function cscope:hook)))

  (setq visual-basic-mode-indent 4)
  )

(provide 'init-visual-basic)