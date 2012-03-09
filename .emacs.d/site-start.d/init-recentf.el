;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; recentf
;;-> http://www.emacswiki.org/emacs/RecentFiles
;;-> http://d.hatena.ne.jp/rubikitch/20091224/recentf
(when (locate-library "recentf")
  (require 'recentf)
  (setq recentf-save-file "~/.emacs.d/var/.recentf"
        recentf-auto-cleanup 'never
        recentf-max-menu-items 10
        recentf-max-saved-items 1000
        recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))

  (recentf-mode 1)
  (if (locate-library "recentf-ext")
      (require 'recentf-ext))
  )

(provide 'init-recentf)