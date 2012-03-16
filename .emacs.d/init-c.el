;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-mode
;;-> http://miyoshi.meadowy.org/Meadow/elisp.html
(c-set-offset 'c-basic-offset tab-width)
(defconst my-c-style
  '(
    ;;TAB
    (c-tab-always-indent        . nil)

    (c-comment-only-line-offset . 0)

    (c-hanging-braces-alist
     . (
        (class-open before after)
        (class-close after)
        (defun-open before after)
        (defun-close after)
        (inline-open after)
        (inline-close after)
        (brace-list-open after)
        (brace-list-close before after)
        (block-open after)
        (block-close after)
        (substatement-open after)
        (statement-case-open after)
        (extern-lang-open before after)
        (extern-lang-close before)
        ))

    (c-hanging-colons-alist
     . (
        (case-label after)
        (label after)
        (access-label after)
        (member-init-intro)
        (inher-intro before)
        ))

    (c-cleanup-list
     . (
        brace-else-brace
        brace-elseif-brace
        empty-defun-braces
        defun-close-semi 
        list-close-comma
        scope-operator
        ))

    (c-offsets-alist
     . (
        (arglist-intro          . 0)
        (arglist-close          . c-lineup-arglist)
        (substatement-open      . 0)
        (statement-cont         . 0)
        (case-label             . 0)
        (statement-case-intro   . +)
        (statement-case-open    . +)
        (label                  . 0)
        (block-open             . /)
        (member-init-intro      . 0)
        ))
    (c-echo-syntactic-information-p . t)
    )
  "My C Programming Style")

(add-hook 'c-mode-common-hook
          '(lambda ()
             (c-add-style "my-c-style" my-c-style t)
;;           (c-set-style "bsd")
;;           (c-set-style "gnu")
             (setq indent-tabs-mode nil)
             (local-set-key "\C-c\C-c" 'compile)
             ))

;; Don't insert to spaces where parens
(setq parens-require-spaces nil)

;; toggle indent-tabs-mode
(defun toggle-indent-tabs-mode()
  (interactive)
  (if (eq indent-tabs-mode nil)
      (setq indent-tabs-mode t)))

(provide 'init-c)