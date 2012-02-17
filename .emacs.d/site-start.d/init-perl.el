;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cperl-mode
;;-> http://www.cpan.org/modules/by-module/CPAN/ILYAZ/cperl-mode/
;;-> http://www.namazu.org/~tsuchiya/elisp/perl-mode.html
(when (locate-library "cperl-mode")
  (setq cperl-continued-statement-offset 2)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; perlplus
;;-> http://www.gentei.org/~yuuji/software/
;;-> http://www.namazu.org/~tsuchiya/elisp/perl-mode.html
(when (locate-library "perlplus")
  (add-hook 'cperl-mode-hook
            (lambda ()
              (require 'perlplus)
              ;; ESC-TAB
              (define-key cperl-mode-map "\M-\t" 'perlplus-complete-symbol)
              (define-key cperl-mode-map [?\C-:?\t] 'perlplus-complete-symbol)
              (perlplus-setup)))
  )

(provide 'init-perl)