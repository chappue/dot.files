;; -*- mode:Emacs-Lisp coding:utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; xcscope
;;->http://cscope.sourceforge.net/
(when (locate-library "xcscope")
  (require 'xcscope)

  (define-key cscope-list-entry-keymap "\C-m" 'cscope-select-entry-other-window)

  (defun cscope-search-dir-list (directory arg)
    "List the cscope.out files in DIRECTORY and in its sub-directories."
    (interactive "DDirectory name: \np")
    (if (<= 0 arg)
        (let (dir-lists
              (current-directory-list
               (directory-files-and-attributes directory t)))
          (while current-directory-list
            (cond
             ((equal "cscope.out" (substring (car (car current-directory-list)) -10))
              (setq dir-lists
                    (cons (file-name-directory (car (car current-directory-list))) dir-lists)))
             ((eq t (car (cdr (car current-directory-list))))
              (if (equal (or "." "..")
                         (substring (car (car current-directory-list)) -1))
                  ()
                (setq dir-lists
                      (append
                       (cscope-search-dir-list
                        (car (car current-directory-list)) (- arg 1))
                       dir-lists)))))
            (setq current-directory-list (cdr current-directory-list)))
          dir-lists)))
  (defun append-cscope-database-regexp (regexp &rest lst)
    (setq cscope-database-regexps
          (append cscope-database-regexps
                  (list (append (list regexp)
                                (apply #'append (mapcar (lambda (x) (if (stringp (car x)) (list x) x)) lst))
                                (list t))))))
  )

(provide 'init-xcscope)