;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;;                     Initialization Main
;;------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; base settings
(require 'init-base)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keybinding
(require 'init-keybind)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; library loading

;; for c language
(require 'init-c)

;; hide-ifdef-mode
(require 'init-hide-ifdef)

;; hexl-mode
(require 'init-hexl)

;; for perl language
(require 'init-perl)

;; auto-insert
(require 'init-autoinsert)

;; css-mode
(require 'init-css)

;; eshell
(require 'init-eshell)

;; shell-mode
(require 'init-shell)

;; for scheme language
(require 'init-scheme)

;; abbrev-mode
(require 'init-abbrev)

;; uniquify
(require 'init-uniquify)

;; gdb-mode
(require 'init-gdb)

;; dired
(require 'init-dired)

;; flymake
(require 'init-flymake)

;; migemo @@@todo
(require 'init-migemo)

;; color-theme
(require 'init-color-theme)

;; mcomplete
(require 'init-mcomplete)

;; w3m @@@todo
(require 'init-w3m)

;; lookup
(require 'init-lookup)

;; gnuplot-mode
(require 'init-gnuplot)

;; navi2ch
(require 'init-navi2ch)

;; skk
(require 'init-skk)

;; YaTex @@@todo
(require 'init-yatex)

;; howm @@@todo
(require 'init-howm)

;; eblook @@@todo
(require 'init-eblook)

;; for haskell language
(require 'init-haskell)

;; for html language @@@todo
(require 'init-html)

;; smart-compile
(require 'init-smart-compile)

;; keisen
(require 'init-keisen)

;; for php language
(require 'init-php)

;; for ruby language
(require 'init-ruby)

;; lcomp
(require 'init-lcomp)

;; moccur
(require 'init-moccur)

;; for lisp language
(require 'init-lisp)

;; subversion
(require 'init-svn)

;; paren-face
(require 'init-paren-face)

;; for python language
(require 'init-python)

;; yasnippet
(require 'init-yasnippet)

;; for javascript language
(require 'init-javascript)

;; auto-save-buffers
(require 'init-auto-save-buffers)

;; anything
(require 'init-anything)

;; ;; pymacs
;; (require 'init-pymacs)

;; org-mode
(require 'init-org)

;; markdown-mode
(require 'init-markdown)

;; recentf
(require 'init-recentf)

;; imenu
(require 'init-imenu)

;; for visual-basic language
(require 'init-visual-basic)

;; auto-install
;; (require 'init-auto-install)

;; deferred
(require 'init-deferred)

;; evernote-mode
(require 'init-evernote)

;; rst-mode
(require 'init-rst)

;; cscope
(require 'init-xcscope)

;; popwin
(require 'init-popwin)

;; find-file
(require 'init-find-file)

;; cycle-buffer
(require 'init-cycle-buffer)

;; newcomment
(require 'init-newcomment)

;; japanese-holidays
(require 'init-japanese-holidays)

;; bookmark
(require 'init-bookmark)

;; package
(require 'init-package)

;; smartrep
(require 'init-smartrep)

;; expand-region
(require 'init-expand-region)

;; webjump
(require 'init-webjump)

;; mark-multiple
(require 'init-mark-multiple)

;; auto-complete
(require 'init-auto-complete)

;; ace-jump
(require 'init-ace-jump-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; os specifcation
(cond ((or darwin-p mac-p carbon-p) (require 'init-mac))
      (linux-p (require 'init-linux))
      (meadow-p (require 'init-meadow))
      )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; machine specification
(require 'init-machine)

;; ----------------------------------------------------------------
(provide 'init-main)
