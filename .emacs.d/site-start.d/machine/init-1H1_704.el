;; -*- mode:Emacs-Lisp coding:utf-8 -*-

;; cscope
(setq cscope-program "c:/tanemura_work/application/cygwin/usr/local/bin/cscope.exe")
(setq cscope-database-regexps
      '(( "^c:/tanemura_work/source/hmi/" (t ("-d" "-L" "-k")) ("c:/tanemura_work/source/windows/" ("-d" "-L" "-k")) t)
        ( "^c:/tanemura_work/source/EWS/" (t ("-d" "-L" "-k")) ("c:/tanemura_work/source/windows/" ("-d" "-L" "-k")) t)
        ( "^c:/tanemura_work/source/BakApp/" (t ("-d" "-L" "-k")) ("c:/tanemura_work/source/windows/" ("-d" "-L" "-k")) t)
        ( "^c:/tanemura_work/source/equipment/" (t ("-d" "-L" "-k")) t)
        ))

;; c-mode
(remove-hook 'c-mode-common-hook
          '(lambda ()
             (c-add-style "my-c-style" my-c-style t)
             (setq indent-tabs-mode nil)
             (local-set-key "\C-c\C-c" 'compile)
             ))
(add-hook 'c-mode-common-hook
          '(lambda ()
             (c-add-style "my-c-style" my-c-style t)
             (setq indent-tabs-mode t)
             (local-set-key "\C-c\C-c" 'compile)
             ))

;; fringe
(set-face-foreground 'fringe "yellow1")

(provide 'init-1H1_704)