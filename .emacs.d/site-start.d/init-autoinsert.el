;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; autoinsert
;;-> http://www.bookshelf.jp/soft/meadow_37.html#SEC550
;;-> http://d.hatena.ne.jp/higepon/20080731/1217491155
(when (locate-library "autoinsert")
  (require 'autoinsert)

  ;; テンプレートのディレクトリ
  (setq auto-insert-directory "~/.emacs.d/etc/autoinsert/")

  ;; 各ファイルによってテンプレートを切り替える
  (setq auto-insert-alist
        (nconc '(
                 ("init-.*\\.el$" . ["init-template.el" my-template])
                 ) ;; auto-insert-alist))
               ))
  (require 'cl)

  ;; ここが腕の見せ所
  (defvar template-replacements-alists
    '(("%file%" . (lambda () (file-name-nondirectory (buffer-file-name))))
      ("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
      ("%include-guard%"    . (lambda () (format "__SCHEME_%s__" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))))

  (defun my-template ()
    (time-stamp)
    (mapc #'(lambda(c)
              (progn
                (goto-char (point-min))
                (replace-string (car c) (funcall (cdr c)) nil)))
          template-replacements-alists)
    (goto-char (point-max))
    (message "done."))
  (add-hook 'find-file-not-found-hooks 'auto-insert)
  )
(provide 'init-autoinsert)