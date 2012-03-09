;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;;                         key bind
;;------------------------------------------------------------------

;; [delete]key modified to BackSpace[BS]
(define-key global-map [delete] 'delete-char)
(define-key global-map [kp-delete] 'delete-char)

;; Ctrl-h to BackSpace[BS]
(define-key global-map "\C-h" 'delete-backward-char) 

;; Ctrl-: modified to [ESC]key
;;   Hard-Coding to [?\C-:] in some file
;; (define-key global-map [?\C-:] esc-map)

;; Switch to OtherWindow
(define-key global-map "\C-o" 'other-window)
(add-hook 'dired-mode-hook
          '(lambda ()
             (local-set-key "\C-o" 'other-window)))
(add-hook 'hexl-mode-hook
          '(lambda ()
             (local-set-key "\C-o" 'other-window)))

;; goto-line
(define-key global-map "\M-g" 'goto-line)

;; Window Refresh
(define-key global-map "\C-@" 'recenter)

;; HELP-mode baind to (C-x ?)
(define-key global-map "\C-x?" 'help-command)

;; delete comment in source
(define-key mode-specific-map ";" 'kill-comment)

;; undefined 'iconify-or-deiconify-frame
(define-key global-map "\C-z" 'nil)

;; compare-windows
(define-key mode-specific-map "w" 'compare-windows)

;; delete-region
(define-key global-map "\M-d" 'delete-region)

;; Window resize
(define-key global-map [(ctrl up)] '(lambda (arg) (interactive "p") (shrink-window arg)))
(define-key global-map [(ctrl down)] '(lambda (arg) (interactive "p") (shrink-window (- arg))))
(define-key global-map [(ctrl left)] '(lambda (arg) (interactive "p") (shrink-window-horizontally arg)))
(define-key global-map [(ctrl right)] '(lambda (arg) (interactive "p") (shrink-window-horizontally (- arg))))

;; for elisp editting
(add-hook 'emacs-lisp-mode-hook (lambda () (define-key esc-map "9" 'move-past-close-and-reindent)))
(add-hook 'emacs-lisp-mode-hook (lambda () (define-key esc-map "8" 'insert-parentheses)))

;; kill-emacs
(global-unset-key "\C-x\C-c")
(define-key global-map "\C-x\M-c" 'save-buffers-kill-emacs)


;; kill-buffer
(defun kill-buffer-force ()
  (interactive)
  (kill-buffer (buffer-name)))
(define-key global-map "\C-xk" 'kill-buffer-force)

(provide 'init-keybind)