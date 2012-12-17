;; -*- mode:Emacs-Lisp coding:utf-8 -*-

(when (locate-library "popwin")
  (require 'popwin)
  (setq display-buffer-function 'popwin:display-buffer)
  (setq popwin:popup-window-height 0.7)

  ;; anything
  (when (locate-library "anything")
    ;; anything
    (setq anything-samewindow nil)
    (push '("*anything file list*" :height 40) popwin:special-display-config)
    (push '("*anything imenu*" :height 40) popwin:special-display-config)
    )

  ;; cscope
  (when (locate-library "cscope")
    (push '("*cscope*" :height 40) popwin:special-display-config)
    )

  ;; dired
  (push '(dired-mode :position top) popwin:special-display-config)

  ;; help
  (push '("*Help*" :height 40) popwin:special-display-config)
)

(provide 'init-popwin)