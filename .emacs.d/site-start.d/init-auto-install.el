;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-install
;;-> http://www.emacswiki.org/emacs/AutoInstall
(when (locate-library "auto-install")
  (require 'auto-install)
  (setq auto-install-directory "~/.emacs.d/lisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup)
  )

(provide 'init-auto-install)