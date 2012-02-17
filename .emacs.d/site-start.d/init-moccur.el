;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; color-moccur
;;-> http://www.bookshelf.jp/soft/meadow_50.html#SEC727
(when (locate-library "color-moccur")
  (if (not (featurep 'color-moccur))
      (require 'color-moccur)
    )
  ;; http://www.bookshelf.jp/soft/meadow_50.html#SEC751
  (setq moccur-split-word t)

  (when (locate-library "migemo")
    (setq moccur-use-migemo t))

  (define-key mode-specific-map "m" 'dired-do-moccur)
  (define-key ctl-x-map "m" 'moccur-grep-find)

  (defun alt-moccur-next-file()
    (interactive)
    (re-search-forward "^[-+ ]*Buffer: " nil t)
    (re-search-forward "^[-+ ]*Buffer: " nil t)
    (beginning-of-line)
    )

  (defadvice moccur-next-file (around alt-moccur-next-file act)
    (alt-moccur-next-file))

  (defun alt-moccur-prev-file()
    (interactive)
    (re-search-backward "^[-+ ]*Buffer: " nil t))

  (defadvice moccur-prev-file (around alt-moccur-prev-file act)
    (alt-moccur-prev-file))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; occur
(when (locate-library "replace")
  (add-hook 'occur-hook '(lambda () (define-key occur-mode-map "\C-o" 'other-window)))
  )

(provide 'init-moccur)