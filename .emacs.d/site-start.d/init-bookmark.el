;; -*- mode:Emacs-Lisp coding:utf-8 -*-

(when (locate-library "bookmark")
  (setq bookmark-default-file "~/.emacs.d/var/.emacs_bmk")
  )

(provide 'init-bookmark)