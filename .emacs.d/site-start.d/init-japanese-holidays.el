;; -*- mode:Emacs-Lisp coding:utf-8 -*-

(when (locate-library "japanese-holidays")
  (require 'japanese-holidays)
  (setq mark-holidays-in-calendar t)
  (setq calendar-holidays
        (append japanese-holidays local-holidays other-holidays))
  (setq calendar-weekend-marker 'diary)
  (add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
  (add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend)
  )

(provide 'init-japanese-holidays)