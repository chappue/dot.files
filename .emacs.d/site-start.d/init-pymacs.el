;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pymacs
;;->http://pymacs.progiciels-bpi.ca/pymacs.html
(when (locate-library "pymacs")
  (autoload 'pymacs-apply "pymacs")
  (autoload 'pymacs-call "pymacs")
  (autoload 'pymacs-eval "pymacs" nil t)
  (autoload 'pymacs-exec "pymacs" nil t)
  (autoload 'pymacs-load "pymacs" nil t)
  (require 'pymacs-ustr)

  (eval-after-load "pymacs"
    '(add-to-list 'pymacs-load-path "~/.emacs.d/share/pymacs"))
  (defun pymacs-maybe-reload ()
    (interactive)
    (let ((pymacsdir (expand-file-name "~/.emacs.d/share/pymacs/")))
      (when (and (string-equal (file-name-directory buffer-file-name)
                               pymacsdir)
                 (string-match "\\.py\\'" buffer-file-name))
        (pymacs-load (substring buffer-file-name 0 -3)))))

  (pymacs-load "howm" "howm-")
  )

(provide 'init-pymacs)