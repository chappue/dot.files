;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hide-ifdef-mode
(when (locate-library "hideif")
  ;; initially hidden
  (setq hide-ifdef-initially nil)
  ;; C-mode hook
  (add-hook 'c-mode-common-hook
            '(lambda()
               (hide-ifdef-mode nil)))

  ;; key bind
  (define-key mode-specific-map "bs" 'show-ifdef-block)
  (define-key mode-specific-map "bh" 'hide-ifdef-block)
  (define-key mode-specific-map "@\C-n" 'next-ifdef)
  (define-key mode-specific-map "@\C-p" 'previous-ifdef)

  ;; symbol define
  (set-default 'hide-ifdef-env '((1 . t) (0 . nil)))
  )

(provide 'init-hide-ifdef)