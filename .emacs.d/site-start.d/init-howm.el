;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; howm
;;-> http://howm.sourceforge.jp/index-j.html
;;-> http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi
(when (and (locate-library "howm") (not (featurep 'howm)))
  (require 'howm)
  (setq howm-menu-lang 'ja)
  (define-key mode-specific-map ",," 'howm-menu)

  ;; Initialize
  (setq howm-directory "~/.emacs.d/howm/")
  (setq howm-keyword-file "~/.emacs.d/howm/.howm-keys")

  ;; use grep command
  (setq howm-view-use-grep t)

  ;; template
  (setq howm-template (lambda (&rest args)
                        (let ((which-templete (car args)))
                          (case which-template
                            (1 "= %title%cursor\n%date %file\n\n")
                            (2 (concat "= [日報] " (format-time-string "%Y/%m/%d") "\n\n%cursor" (howm-nippou) "\n%date \n"))
                            (3 (concat "= [patch] CKT" (get-patch-id) "%cursor\n\n[version]\n\n\n" (file-string "c:/tanemura_work/document/temporary/patch.diff") "\n%date \n"))
                            (4 (concat "= [patch] %cursor\n\n\n" (file-string "c:/tanemura_work/document/temporary/patch.diff") "\n%date \n"))
                            (5 (concat "= [作業ログ] %cursor\n\n* 装置詳細\n[version] \n[Order No] none\n[Equipment type] D02\n\n* "))
                            ))))

  ;; patch
  (defun get-patch-id ()
    (let (str)
      (with-current-buffer
          (find-file-noselect "~/.emacs.d/howm/patch_list.tmp")
        (re-search-forward "\\( *-?[0-9]+\\)" nil t)
        (setq str (format "%03d" (1+ (string-to-number (buffer-string)))))
        (replace-match str)
        (save-buffer)
        (kill-buffer (current-buffer)))
      str))

  (defun file-string (file)
    (let (str)
      (with-current-buffer (find-file-noselect file)
        (setq str (buffer-string)))
      str))

  ;; enhanced edit
  (if (not (locate-library "markdown-mode"))
      (progn
        (add-hook 'howm-mode-hook (lambda () (markdown-mode)))
        (custom-set-faces
         '(markdown-font-lock-italic-face ((t nil)))))

    (progn
      (defadvice howm-mode
        (before outline-minor activate)
        (outline-minor-mode t))
      (require 'outline)
      (defun my-outline-flip-subtree (&optional dummy)
        (interactive)
        (if (save-excursion
              (forward-line 1)
              (let ((p (overlays-at (line-beginning-position)))
                    (ol nil))
                (while (and p (not ol))
                  (setq ol (overlay-get (car p) 'invisible))
                  (setq p (cdr p)))
                ol))
            (show-subtree)
          (hide-subtree)))
      (defun add-my-action-lock-rule ()
        (let ((rule
               (action-lock-general
                'my-outline-flip-subtree
                (if (and
                     buffer-file-name
                     (string-match "\\.howm$" buffer-file-name))
                    "^ *\\(\\*\\**\\)"
                  (concat "\\(" outline-regexp "\\)"))
                1 1)))
          (if (not (member rule action-lock-default-rules))
              (progn (setq action-lock-default-rules
                           (cons rule action-lock-default-rules))
                     (action-lock-set-rules action-lock-default-rules)))))
      (add-hook 'action-lock-mode-on-hook 'add-my-action-lock-rule)
      ))

  ;; re-date
  (defun howm-reinsert-date()
    (interactive)
    (howm-action-lock-date (thing-at-point 'sexp)))
  (define-key howm-mode-map (concat howm-prefix "@") 'howm-reinsert-date)

  ;; change date action in howm-menu buffer
  ;; (defadvice action-lock-magic-return (around howm-menu-buffer-change-date act)
  ;;   (if (and (string= (buffer-name) (format howm-menu-name-format howm-menu-top))
  ;;            (string-match howm-date-regexp (thing-at-point 'sexp)))
  ;;       (let ((i 0) (lst (buffer-list)))
  ;;         ad-do-it
  ;;         (while lst
  ;;           (if (string= ".howm" (substring (buffer-name (car lst)) -5))
  ;;               (progn
  ;; ;;                 (kill-buffer (car lst))
  ;; ;;                 (setq lst nil))
  ;;                 (princ (concat (format "%d " i) (buffer-name (car lst))))
  ;;                 (setq lst (cdr lst)))
  ;;             (setq lst (cdr lst)))
  ;;           (setq i (1+ i))))
  ;;     (princ "FALSE")))

  )

(provide 'init-howm)