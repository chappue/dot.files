;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; abbrev-mode
;;-> http://www.emacswiki.org/emacs/AbbrevMode
(when (locate-library "abbrev")
  (setq abbrev-file-name "~/.emacs.d/var/.abbrev_defs")
  (setq default-abbrev-mode t)

  (defun expand-abbrev-region (beg end)
    (interactive "r")
    (let ((str (buffer-substring beg end)))
      (if (abbrev-expansion str)
          (progn (delete-region beg end)
                 (insert (abbrev-expansion str))))))
  (define-key global-map "\C-xar" 'expand-abbrev-region)
  )

(provide 'init-abbrev)