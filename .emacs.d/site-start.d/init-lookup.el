;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lookup
;;-> http://openlab.ring.gr.jp/edict/lookup/
(when (locate-library "lookup")
  (autoload 'lookup "lookup" nil t)
  (autoload 'lookup-region "lookup" nil t)
  (autoload 'lookup-pattern "lookup" nil t)
  (autoload 'lookup-word "lookup" nil t)
  (setq lookup-search-agents '((ndeb "~/.emacs.d/etc/Dictionary/EDICT")
                               (ndeb "~/.emacs.d/etc/Dictionary/VERA/")
                               (ndeb "~/.emacs.d/etc/Dictionary/JARGON/")
                               (ndeb "~/.emacs.d/etc/Dictionary/GENE95/")
                               (ndeb "~/.emacs.d/etc/Dictionary/FOLDOC/")
                               (ndeb "~/.emacs.d/etc/Dictionary/WDIC/")
                               (ndeb "~/.emacs.d/etc/Dictionary/PEJV/")
                               (ndeb "~/.emacs.d/etc/Dictionary/ASCDATES/")
                               ))
  (setq lookup-enable-splash nil)
  (setq lookup-use-kakasi t)
  (setq lookup-default-dictionary-options '((:stemmer . stem-english)))
  (define-key mode-specific-map "\C-l" 'lookup-pattern)
  (define-key mode-specific-map "l" 'lookup-word)
  )

(provide 'init-lookup)