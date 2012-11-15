;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet
;;->http://code.google.com/p/yasnippet/
(when (locate-library "yasnippet")
  (require 'yasnippet)
  (require 'dropdown-list)
  (setq yas-snippet-dirs
        (append '("~/.emacs.d/share/snippets") (cdr yas-snippet-dirs)))
  (yas-global-mode 1)
  (define-key global-map [?\C-\:] 'yas-expand)

  ;; anything interface
  ;;->https://github.com/sugyan/dotfiles/blob/master/.emacs.d/conf/04-yasnippet.el
  (eval-after-load "anything-config"
    '(progn
       (defun yas-anything-prompt (prompt choices &optional display-fn)
         (let* ((names (loop for choice in choices
                             collect (or (and display-fn (funcall display-fn choice))
                                         choice)))
                (selected (anything-other-buffer
                           `(((name . ,(format "%s" prompt))
                              (candidates . names)
                              (action . (("Insert snippet" . (lambda (arg) arg))))))
                           "*anything yas-prompt*")))
           (if selected
               (let ((n (position selected names :test 'equal)))
                 (nth n choices))
             (signal 'quit "user quit!"))))
       (defun my-yas-prompt( prompt choices &optional display-fn )
         (if (< 5 (length choices))
             (yas-anything-prompt prompt choices display-fn)
           (yas-dropdown-prompt prompt choices display-fn)))
       (custom-set-variables '(yas-prompt-functions '(my-yas-prompt)))
       ))
  )

(provide 'init-yasnippet)
