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

  (setq anything-kill-ring-threshold 5)

  (setq anything-c-adaptive-history-file "~/.emacs.d/var/anything-c-adaptive-history")
  (define-prefix-command 'anything-key-map)
  (define-key global-map [?\C-\;] 'anything-key-map)
  (define-key anything-key-map [?\C-\;] 'anything-execute-anything-command)

  ;; anything-c-moccur
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

;;   (defvar anything-c-source-mmi-test-file
;;     `((name . "MMI-TEST")
;;       (init . (lambda ()
;;                 (require 'recentf)
;;                 (or recentf-mode (recentf-mode 1))))
;;       (disable-shortcuts)
;;       (candidates . recentf-list)
;;       (keymap . ,anything-generic-files-map)
;;       (help-message . anything-generic-file-help-message)
;;       (mode-line . anything-generic-file-mode-line-string)
;;       (match anything-c-match-on-basename)
;;       (type . file))
;;     "See (info \"(emacs)File Conveniences\").
;; Set `recentf-max-saved-items' to a bigger value if default is too small.")
;;   (defun anything-filelist+custom ()
;;     "Preconfigured `anything' to open files/buffers/bookmarks instantly.

;; This is a replacement for `anything-for-files'.
;; See `anything-c-filelist-file-name' docstring for usage."
;;     (interactive)
;;     (anything-other-buffer
;;      '(anything-c-source-ffap-line
;;        anything-c-source-ffap-guesser
;;        anything-c-source-buffers
;;        anything-c-source-recentf
;;        anything-c-source-files-in-current-dir+
;;        anything-c-source-bookmarks
;;        anything-c-source-file-cache
;;        anything-c-source-filelist)
;;      "*anything file list*"))

  ;; anything keymap
  (define-key anything-key-map "\C-f" 'anything-filelist+)
  (define-key anything-key-map "\C-i" 'anything-imenu)
  (define-key anything-key-map "\C-y" 'anything-show-kill-ring)
  (define-key anything-key-map "\C-e" 'anything-M-x)

  )

(provide 'init-anything)
