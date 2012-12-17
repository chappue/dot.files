;; -*- mode:Emacs-Lisp coding:utf-8 -*-

(when (locate-library "auto-complete")
  (require 'auto-complete)

  ;;; C-n / C-p で選択
  (setq ac-use-menu-map t)

  (when (boundp 'ac-modes)
    (setq ac-modes
          (append ac-modes
                  (list 'visual-basic-mode))))

  ;;; ベースとなるソースを指定
  (setq ac-sources
    '(ac-source-yasnippet
      ac-source-abbrev
      ac-source-dictionary
      ac-source-words-in-same-mode-buffers))

  (global-auto-complete-mode t)

  ;;; yasnippetのbindingを指定するとエラーが出るので回避する方法。
  (setf (symbol-function 'yas-active-keys)
        (lambda ()
          (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))
  )
(provide 'init-auto-complete)