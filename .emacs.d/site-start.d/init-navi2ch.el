;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; navi2ch
;;-> http://navi2ch.sourceforge.net/
(when (locate-library "navi2ch")
  (autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)
  (setq navi2ch-directory "~/.emacs.d/navi2ch")

  ;;送信控えをとる
  (setq navi2ch-message-save-sendlog t)
  (add-to-list 'navi2ch-list-navi2ch-category-alist
                   navi2ch-message-sendlog-board)
  ;;スレをデフォルトで全件表示
  (setq navi2ch-article-exist-message-range '(1 . 1000))
  (setq navi2ch-article-auto-range nil)
  ;;バッファは5つまで
  (setq navi2ch-article-max-buffers 5)
  ;;あぼ~ん時元のファイルは保存しない
  (setq navi2ch-net-save-old-file-when-aborn nil)
  ;;5つを超えたバッファは消す
  (setq navi2ch-article-auto-expunge t)

  ;;コテハン対策
  (add-to-list 'navi2ch-article-message-filter-by-name-alist
               (cons (list (regexp-opt '("◆xlAOIq6jZw"
                                         "◆yChdjWk9Ko"))
                           'r) 'hide))
  )

(provide 'init-navi2ch)