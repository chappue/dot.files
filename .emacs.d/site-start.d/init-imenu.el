;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; imenu
(when (and (locate-library "imenu") (locate-library "mcomplete"))
  (defadvice imenu--completion-buffer
    (around mcomplete activate preactivate)
    "Support for mcomplete-mode."
    (require 'mcomplete)
    (let ((imenu-use-popup-menu 'never)
          (mode mcomplete-mode)
          ;; the order of completion methods
          (mcomplete-default-method-set '(mcomplete-substr-method
                                          mcomplete-prefix-method))
          ;; when to display completion candidates in the minibuffer
          (mcomplete-default-exhibit-start-chars 0)
          (completion-ignore-case t))
      ;; display *Completions* buffer on entering the minibuffer
      (setq unread-command-events
            (cons (funcall (if (fboundp 'character-to-event)
                               'character-to-event
                             'identity)
                           ?\?)
                  unread-command-events))
      (turn-on-mcomplete-mode)
      (unwind-protect
          ad-do-it
        (unless mode
          (turn-off-mcomplete-mode)))))
  )

(provide 'init-imenu)