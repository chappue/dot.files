;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; anything
;;->http://www.emacswiki.org/cgi-bin/wiki/Anything
(when (locate-library "anything")
  (setq anything-sources
        '(anything-c-source-recentf
;;           anything-c-source-imenu
          anything-c-source-emacs-commands
          anything-c-source-emacs-functions
          ))

  (require 'anything-config)
  (setq anything-command-map nil)
  (require 'anything-auto-install nil t)
  (require 'anything-grep nil t)
  (and (equal current-language-environment "Japanese")
       (require 'anything-migemo nil t))

  (setq anything-c-adaptive-history-file "~/.emacs.d/var/anything-c-adaptive-history")
  (define-prefix-command 'anything-key-map)
  (define-key global-map [?\C-\;] 'anything-key-map)
  (define-key anything-key-map [?\C-\;] 'anything-execute-anything-command)
  (define-key anything-key-map "\C-f" 'anything-filelist+)
  (define-key anything-key-map "\C-b" 'anything-buffers+)
  (define-key anything-key-map "\C-i" 'anything-imenu)
  (define-key anything-key-map "\C-y" 'anything-show-kill-ring)
  (define-key anything-key-map "\C-e" 'anything-M-x)

  (when (and (locate-library "anything-c-moccur")
             (locate-library "color-moccur"))
    (setq moccur-split-word t)
    (require 'anything-c-moccur)
    (setq anything-c-moccur-anything-idle-delay 0.2
          anything-c-moccur-higligt-info-line-flag t
          anything-c-moccur-enable-auto-look-flag t
          anything-c-moccur-enable-initial-pattern t)

    (add-hook 'dired-mode-hook
              '(lambda ()
                 (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))
    (define-key anything-key-map "\C-m" 'anything-c-moccur-dmoccur)
    (define-key anything-key-map "\C-o" 'anything-c-moccur-occur-by-moccur))
  )

(provide 'init-anything)