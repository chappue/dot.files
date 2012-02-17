;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eblook
;;-> http://openlab.ring.gr.jp/edict/eblook/
(when (locate-library "eblook")
  (if (getenv "DYLD_LIBRARY_PATH")
      (setenv "DYLD_LIBRARY_PATH" (concat (getenv "DYLD_LIBRARY_PATH") ":" "/usr/local" "/lib"))
    (setenv "DYLD_LIBRARY_PATH" (concat "/usr/local" "/lib"))
    )
  (setq ndeb-program-name "/usr/local/bin/eblook")
  )

(provide 'init-eblook)