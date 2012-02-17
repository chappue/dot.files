;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;                        load path
;------------------------------------------------------------------

;; exec-path setting
(setq exec-path
      (append
       (list "/usr/local/bin" "/usr/bin" "/Users/chappue/Binaries/bin") exec-path))


;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;                        emacs  settings
;------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacs source path
(setq find-function-source-path (expand-file-name "~/Source/Emacs/emacs/src"))

;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;                        frame settings
;------------------------------------------------------------------
(setq initial-frame-alist
      (append (list ;; FlameSetting
               ;; screen size
               '(top . 0)
               '(left . 0)
               '(width . 237)
               '(height . 66)

               ;; Window Tranparency
               ;'(active-alpha . 0.90) ; Active 
               ;'(inactive-alpha . 0.800) ; Not Active Window

               ;; Font
               ;'(font . "fontset-hiraginomaru12")

               ;; Cursor
               '(cursor-color . "deep pink")

;;                '(foreground-color . "azure3")
;;                '(background-color . "black")
;;                '(border-color     . "black")
;;                '(mouse-color      . "white")
;;                '(cursor-color     . "white")
               )
              initial-frame-alist))

(setq default-frame-alist initial-frame-alist)

(set-face-background 'region "SkyBlue")
(set-face-foreground 'region "black")

(provide 'init-trona)