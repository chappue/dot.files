;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; recentf
;;-> http://www.emacswiki.org/emacs/RecentFiles
;;-> http://d.hatena.ne.jp/rubikitch/20091224/recentf
(when (locate-library "recentf")
  (require 'recentf)
  (setq recentf-save-file "~/.emacs.d/.recentf"
        recentf-auto-cleanup 'never
        recentf-max-menu-items 10
        recentf-max-saved-items 1000
        recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list)
        recentf-exclude '("\\(\.howm$\\|~$\\)" "^//"
                          "^c:/Documents and Settings/0096913/デスクトップ"
                          "^c:/tanemura_work/source/misc"
                          "^C:/Program Files/MMI-TEST-"
                          "^C:/Program Files/MMI-TEST("
                          "^[^C]"
                          "^c:/tanemura_work/document/work"))
  (recentf-mode 1)
  (if (locate-library "recentf-ext")
      (require 'recentf-ext))
  )

(provide 'init-recentf)