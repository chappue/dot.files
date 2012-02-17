;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; smart-compile
(when (locate-library "smart-compile")
  (require 'smart-compile)
  (defvar smart-compile-alist '(
                                ("\\.c\\'"          . "gcc -O2 %f -lm -o %n")
                                ("\\.[Cc]+[Pp]*\\'" . "g++ -O2 %f -lm -o %n")
                                ("\\.java\\'"       . "javac %f")
                                ("\\.f90\\'"        . "f90 %f -o %n")
                                ("\\.[Ff]\\'"       . "f77 %f -o %n")
                                ("\\.tex\\'"        . (tex-file))
                                ("\\.pl\\'"         . "perl -cw %f")
                                (emacs-lisp-mode    . (emacs-lisp-byte-compile))
                                ) "...")
  (add-hook 'c-mode-common-hook
            '(lambda() (define-key c-mode-base-map "\C-c\C-c" 'smart-compile)))
  (add-hook 'emacs-lisp-mode-hook
            '(lambda() (define-key lisp-mode-shared-map "\C-c\C-c" 'smart-compile)))
  )

(provide 'init-smart-compile)