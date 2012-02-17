;; -*- mode:Emacs-Lisp coding:utf-8 -*-

(setq initial-frame-alist
      (append (list
               '(top . 0)
               '(left. 0)
               '(width . 125)
               '(height . 43)

               '(font . "-unknown-DejaVu Sans Mono-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
               '(cursor-color . "deep pink")
               )
              initial-frame-alist))

(setq defaut-frame-alist initial-frame-alist)

(set-face-background 'region "SkyBlue")
(set-face-foreground 'region "black")

;; Input Method
(when (locate-library "scim-bridge")
  (require 'scim-bridge)
  (add-hook 'after-init-hook 'scim-mode-on))
(when (locate-library "anthy")
  (load-library "anthy")
  (setq default-input-method "japanese-anthy"))

(provide 'init-zircon)