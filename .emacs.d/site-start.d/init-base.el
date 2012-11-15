;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;;                      base settings
;;------------------------------------------------------------------

;; whole-line To Kill-buffer
(setq kill-whole-line t)

;; TAB width
(setq-default tab-width 4)

;; Don't create #file# file
(setq delete-auto-save-file t)
(setq auto-save-default nil)
(auto-save-mode -1)
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)
;; Don't create file~
(setq backup-inhibited t)
(setq make-backup-files nil)

;; insert new-line where end of file
(setq require-final-newline t)
(setq mode-require-final-newline t)
(setq next-line-add-newlines nil)

;; Switching Between Buffers using Substrings
(iswitchb-mode t)

;; case insensitive search
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq case-fold-search t)

;; ;; not multi line on minibuffer
;; (resize-minibuffer-mode nil)

;; filename patterns vs corresponding major mode functions
(setq auto-mode-alist
      (append
       '(("\\.h$" . c++-mode)
         ("\\.c$" . c++-mode)
         ("\\.hpp$" . c++-mode)
         ("\\.perl$" . cperl-mode)
         ("\\.p[hlm]$" . cperl-mode)
         ("\\.mix$" . asm-mode)
         ("\\.css$" . css-mode)
         )
       auto-mode-alist))

;; Use narrowing
(put 'narrow-to-region 'disabled nil)

;; Use upcase-region downcase-region
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; indent current line
(setq indent-line-function
      'indent-relative-maybe)

;; indent with spaces
(setq-default indent-tabs-mode nil)

;; *Message* Buffers display line-number (default:50)
(setq message-log-max 200)

;; Fringe width
(if (fboundp 'fringe-mode)
    (fringe-mode '(5 . 5)))

;; Scroll-bar OFF
(scroll-bar-mode -1)
;; Menu-bar OFF
(menu-bar-mode -1)
;; Tool-bar OFF
(tool-bar-mode -1)

;; Title indication
(setq frame-title-format "%b")

;; Display current time
(setq display-time-24hr-format t)
(setq display-time-format "%m/%d(%a)%R")
(setq display-time-day-and-date t)
(display-time)

;; add syntax as a bonus
(global-font-lock-mode t)
(setq font-lock-support-mode 'jit-lock-mode)

;; region high-light
(transient-mark-mode t)

;; hight-light parenthesis
(show-paren-mode t)

;; Not display "scratch-message"
(setq initial-scratch-message nil)

;; disable auto save
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq buffer-offer-save nil)
            (auto-save-mode -1)))

;; Show line-number
(line-number-mode t)

;; Don't make me type out 'yes', 'y' is good enough.
(fset 'yes-or-no-p 'y-or-n-p)

;; repeat command -> NOT echo to minibuffer
(setq repeat-message-function 'ignore)

;; don't beep
(setq ring-bell-function 'ignore)

;; screen flash as Beep
(setq visible-bell t)

;; disable splashscreen
(setq inhibit-splash-screen t)

;; mouse cursur
(mouse-avoidance-mode 'jump)

;; ;; server-mode ON
(server-start)

;;(setq scroll-margin 3
;;      scroll-preserve-screen-position t
;;      scroll-conservatively 4
;;      next-screen-context-lines 3)

;; for security (local-variables injection??)
(setq enable-local-eval 'maybe)
(setq enable-local-variables 'query)

;;; mode-line setting
(setq display-time-string-forms '(month "/" day "(" dayname ")" 24-hours ":" minutes))
(setq-default mode-line-format
              '("-"
                mode-line-mule-info
                mode-line-modified
                mode-line-buffer-identification
                " "
                (line-number-mode "L%l{%p}-")
                (column-number-mode "C%c-")
                global-mode-string
                " %[("
                mode-name
                mode-line-process
                minor-mode-alist
                "%n" ")%]-"
                (which-func-mode ( "" which-func-format "-"))
                "-%-")
              )
;; Encoded-kb
;; (eval-after-load "encoded-kb"
;;   '(setcar (cdr (assq 'encoded-kbd-mode minor-mode-alist)) ""))
;; Abbrev
(eval-after-load "abbrev"
  '(setcar (cdr (assq 'abbrev-mode minor-mode-alist)) ""))
;; Isearch
(add-hook 'isearch-mode-hook
          '(lambda () (setcar (cdr (assq 'isearch-mode minor-mode-alist)) "")))
;; Texinfo
(add-hook 'texinfo-mode-hook
          '(lambda ()
             (setq mode-name "Texi")))
;; *scratch* Emacs Lisp Interaction
(add-hook 'lisp-interaction-mode-hook
          '(lambda ()
             (setq mode-name "Lisp-Int")))
;; Emacs-Lisp
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (setq mode-name "Elisp")))

(provide 'init-base)
