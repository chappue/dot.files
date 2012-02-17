;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode
;;->
(when (locate-library "org")
  (require 'org-install)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (setq org-startup-truncated nil)
  (setq org-return-follows-link t)
  (setq org-directory "~/.emacs.d/org/")
  (setq org-default-notes-file (concat org-directory "work.org"))
  (setq org-agenda-files (list org-default-notes-file))
  (define-key mode-specific-map "a" 'org-agenda)

  (setq org-use-fast-todo-selection t)
  (setq org-agenda-use-time-grid t)

  (defun org-dblock-write:rangereport (params)
    "Display day-by-day time reports."
    (let* ((ts (plist-get params :tstart))
           (te (plist-get params :tend))
           (start (time-to-seconds
                   (apply 'encode-time (org-parse-time-string ts))))
           (end (time-to-seconds
                 (apply 'encode-time (org-parse-time-string te))))
           day-numbers)
      (setq params (plist-put params :tstart nil))
      (setq params (plist-put params :end nil))
      (while (<= start end)
        (save-excursion
          (insert "\n\n"
                  (format-time-string (car org-time-stamp-formats)
                                      (seconds-to-time start))
                  "----------------\n")
          (org-dblock-write:clocktable
           (plist-put
            (plist-put
             params
             :tstart
             (format-time-string (car org-time-stamp-formats)
                                 (seconds-to-time start)))
            :tend
            (format-time-string (car org-time-stamp-formats)
                                (seconds-to-time end))))
          (setq start (+ 86400 start))))))

  (when (locate-library "remember")
    (autoload 'remember "remember" nil t)
    (org-remember-insinuate)
    (setq org-remember-templates
          '(("Todo" ?t "** TODO %?\n   SCHEDULED: %t\n   %i\n   %a\n" nil "Inbox")
            ("Bug" ?b "** TODO %?   :bug:\n   SCHEDULED: %t\n   %i\n   %a" nil "Inbox")
            ("Idea" ?i "** %?\n   SCHEDULED: %t\n   %i\n   %a" nil "Inbox")
            ))

;;     ;; for code-reading
;;     (defvar org-code-reading-software-name nil)
;;     (defvar org-code-reading-file "code-reading.org")
;;     (defun org-code-reading-read-software-name ()
;;       (set (make-local-variable 'org-code-reading-software-name)
;;            (read-string "Code Reading Software: " 
;;                         (or org-code-reading-software-name
;;                             (file-name-nondirectory
;;                              (buffer-file-name))))))

;;     (defun org-code-reading-get-prefix (lang)
;;       (concat "[" lang "]"
;;               "[" (org-code-reading-read-software-name) "]"))
;;     (defun org-remember-code-reading ()
;;       (interactive)
;;       (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
;;              (org-remember-templates
;;               `(("CodeReading" ?r "** %(identity prefix)%?\n   \n   %a\n   %t"
;;                  ,(concat org-directory org-code-reading-file) "Memo"))))
;;         (org-remember)))
;;     (define-key mode-specific-map "\C-oc" 'org-remember-code-reading)
    )
  )

(provide 'init-org)