;; -*- mode:Emacs-Lisp coding:utf-8 -*-

;; FONTS
(when (>= emacs-major-version 23)
 (set-face-attribute 'default nil
                     :family "ＭＳ ゴシック"
                     :height 110)
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0208
  '("ＭＳ ゴシック" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0212
  '("ＭＳ ゴシック" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'FONT)
  'mule-unicode-0100-24ff
  '("ＭＳ ゴシック" . "iso10646-1"))
 )

(when (locate-library "xcscope")
  ;; cscope
  (setq cscope-program "c:/tanemura_work/application/cygwin/usr/local/bin/cscope.exe")

  (setq cscope-database-regexps nil)
  (append-cscope-database-regexp "^c:/tanemura_work/source/hmi/" '(t ("-L" "-k")) '("C:/Program Files/Microsoft Visual Studio .NET/Vc7" ("-L" "-k")))
  (append-cscope-database-regexp "^c:/tanemura_work/source/BESTEM/EWS/" '(t ("-L" "-k")) '("C:/Program Files/Microsoft Visual Studio .NET/Vc7" ("-L" "-k")))
  (append-cscope-database-regexp "^c:/tanemura_work/source/BESTEM/BakApp/" '(t ("-L" "-k")) '("C:/Program Files/Microsoft Visual Studio .NET/Vc7" ("-L" "-k")))
  (append-cscope-database-regexp "^c:/tanemura_work/source/misc/msvc/" '("C:/Program Files/Microsoft Visual Studio .NET/Vc7" ("-L" "-k")) '(t ("-L" "-k")))
  (append-cscope-database-regexp "^c:/tanemura_work/document/work/" '(t ("-L" "-k")) '("C:/Program Files/Microsoft Visual Studio .NET/Vc7" ("-L" "-k")))
  ;; (append-cscope-database-regexp "^c:/Program Files/mmi-test/" '(t ("-L" "-k")) '("C:/Program Files/Microsoft Visual Studio .NET/Vc7" ("-L" "-k")))
  (append-cscope-database-regexp "^c:/tanemura_work/source/BESTEM/controller/src/D01Np"
                                 (mapcar (lambda (x) (list x '("-L" "-k"))) (cscope-search-dir-list "c:/tanemura_work/source/BESTEM/controller/src/D01Np" 2))
                                 '("C:/tanemura_work/source/BESTEM/controller/src/QNX" ("-L" "-k")))
  (append-cscope-database-regexp "^c:/tanemura_work/source/BESTEM/controller/src/D01R"
                                 (mapcar (lambda (x) (list x '("-L" "-k"))) (cscope-search-dir-list "c:/tanemura_work/source/BESTEM/controller/src/D01R" 2))
                                 '("C:/tanemura_work/source/BESTEM/controller/src/QNX" ("-L" "-k")))
  (append-cscope-database-regexp "^c:/tanemura_work/source/BESTEM/controller/src/D01"
                                 (mapcar (lambda (x) (list x '("-L" "-k"))) (cscope-search-dir-list "c:/tanemura_work/source/BESTEM/controller/src/D01" 2))
                                 '("C:/tanemura_work/source/BESTEM/controller/src/QNX" ("-L" "-k")))
  (append-cscope-database-regexp "^c:/tanemura_work/source/BESTEM/controller/src/D02"
                                 (mapcar (lambda (x) (list x '("-L" "-k"))) (cscope-search-dir-list "c:/tanemura_work/source/BESTEM/controller/src/D02" 2))
                                 '("C:/tanemura_work/source/BESTEM/controller/src/QNX" ("-L" "-k")))
  (append-cscope-database-regexp "^c:/tanemura_work/source/BESTEM/controller/src/D03Hp"
                                 (mapcar (lambda (x) (list x '("-L" "-k"))) (cscope-search-dir-list "c:/tanemura_work/source/BESTEM/controller/src/D03Hp" 2))
                                 '("C:/tanemura_work/source/BESTEM/controller/src/QNX" ("-L" "-k")))
  )

;; dired ftp address
(setq dired-copy-remote-file-table
      '(("^c:/tanemura_work/source/BESTEM/controller/src/D01R/UNIT"
         ("^c:/tanemura_work/source/BESTEM/controller/src/D01R/UNIT" "/cps@192.168.111.19:/home/noa/std_test/application/src/Unit")
         ("V[0-9]?[0-9]?[0-9][0-9][0-9][0-9]R[0-9]?[0-9]/" ""))
        ("^c:/tanemura_work/source/BESTEM/controller/src/D01R/BASE"
         ("^c:/tanemura_work/source/BESTEM/controller/src/D01R/BASE" "/cps@192.168.111.19:/home/noa/std_test/application/src"))
        ("^c:/tanemura_work/source/BESTEM/controller/src/D01/UNIT"
         ("^c:/tanemura_work/source/BESTEM/controller/src/D01/UNIT" "/cps@192.168.111.254:/home/noa/std_test/application/src/Unit")
         ("V[0-9]?[0-9]?[0-9][0-9][0-9][0-9]R[0-9]?[0-9]/" ""))
        ("^c:/tanemura_work/source/BESTEM/controller/src/D01/BASE"
         ("^c:/tanemura_work/source/BESTEM/controller/src/D01/BASE" "/cps@192.168.111.254:/home/noa/std_test/application/src")
         ("V[0-9]?[0-9]?[0-9][0-9][0-9][0-9]R[0-9]?[0-9]/" ""))
        ("^c:/tanemura_work/source/BESTEM/controller/src/D02/UNIT"
         ("^c:/tanemura_work/source/BESTEM/controller/src/D02/UNIT" "/cps@192.168.111.66:/home/noa/Debug/Bestem-D02/src/Unit")
         ("V[0-9]?[0-9]?[0-9][0-9][0-9][0-9]R[0-9]?[0-9]/" ""))
        ("^c:/tanemura_work/source/misc/QNX"
         ("^c:/tanemura_work/source/misc/QNX" "/cps@192.168.111.254:/home/Personal/tanemura/sandbox"))))

;; c-mode
(remove-hook 'c-mode-common-hook
          '(lambda ()
             (c-add-style "my-c-style" my-c-style t)
             (setq indent-tabs-mode nil)
             (local-set-key "\C-c\C-c" 'compile)
             ))
(add-hook 'c-mode-common-hook
          '(lambda ()
             (c-add-style "my-c-style" my-c-style t)
             (setq indent-tabs-mode t)
             (local-set-key "\C-c\C-c" 'compile)
             ))

;; fringe
(set-face-foreground 'fringe "yellow1")

;; frame setting
(setq initial-frame-alist
      (append (list
               '(top . 0)
               '(left . 0)
               '(width . 156)
               '(height . 49)

               '(cursor-color . "deep pink")
               '(cursor-type . box)
               '(cursor-height . 4)

               )
              initial-frame-alist))
(set-language-environment "Japanese")

;; NagaIGyou woORiKaeSazuniHyouzi suru.
(setq-default truncate-lines t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; open directory
(defun open-directory (dir)
  (interactive "DDirectory? ")
  (shell-command (concat "cygstart " "\"" (expand-file-name dir) "\"")))

;; info
;; (defadvice info-initialize
;;   (after info-initialize-after-local activate)
;;   "add info directory to Info-directory-list."
;;   (let ((dir (expand-file-name "/tanemura_work/source/misc/python/Python_2.5_info")))
;;     (unless (member dir Info-directory-list)
;;       (setq Info-directory-list (append (list dir) Info-directory-list)))))
;; (setq Info-additional-directory-list (list (expand-file-name "/tanemura_work/source/misc/python/Python_2.5_info")))

;; woman
(setq woman-manpath '("c:/tanemura_work/application/cygwin/usr/share/man/"
                      "c:/tanemura_work/application/cygwin/usr/local/share/man"
                      "c:/tanemura_work/application/cygwin/usr/man"
                      "c:/tanemura_work/application/cygwin/usr/share/doc/man"
                      "c:/tanemura_work/application/cygwin/usr/ssl/"))

;; w3m
(when (locate-library "w3m-load")
  (setq w3m-command "/tanemura_work/application/cygwin/bin/w3m")
  )


;; python
(setq gud-pdb-command-name "c:/tanemura_work/application/Python/python.exe -u c:/tanemura_work/application/Python/lib/pdb.py ")

;; search words in source files by moccur-grep-find
(defun moccur-extract-symbol-at-cursor ()
  (let* ((symbol-chars "A-Za-z0-9_")
         (symbol-char-regexp (concat "[" symbol-chars "]")))
    (save-excursion
      (buffer-substring-no-properties
       (progn
         (if (not (looking-at symbol-char-regexp))
             (re-search-backward "\\w" nil t))
         (skip-chars-backward symbol-chars)
         (point))
       (progn
         (skip-chars-forward symbol-chars)
         (point)
         )))
    ))
(defun moccur-grep-find-source (search)
  (interactive (list (read-string "Search String: " (moccur-extract-symbol-at-cursor))))
  (moccur-grep-find default-directory (list search "\\.[hcbf][parl]?[psm]?$")))

;; recentf
(setq recentf-exclude '("\\(\.howm$\\|~$\\)" "^//"
                        "^c:/Documents and Settings/0096913/デスクトップ"
                        "^c:/tanemura_work/source/misc"
                        "^C:/Program Files/MMI-TEST-"
                        "^C:/Program Files/MMI-TEST("
                        "^C:/Program Files/MMI-TEST_"
                        "^[^C]"
                        "^c:/tanemura_work/document/work"
                        "^C:/Program Files/MMI/PRO-D1/WinMMI/GUI"))

;; copy file when edit file in GUI folder
(defun file-mirror-copy()
             (interactive)
             (let ((base-name (file-name-nondirectory buffer-file-name))
                   (dir-name (file-name-directory buffer-file-name)))
               (if (equal (string-match "c:/Program Files/MMI-TEST/PRO-D1/WinMMI/GUI/" dir-name) 0)
                   (copy-file buffer-file-name (concat "C:/Program Files/MMI/PRO-D1/WinMMI/GUI/" base-name) t)
                 )))
(add-hook 'after-save-hook
          'file-mirror-copy)


;; initial screen
(when (locate-library "org")
  (setq org-agenda-files (concat org-directory "nippou.org"))
  (setq org-default-notes-file org-agenda-files)
  (find-file org-default-notes-file))

(provide 'init-1H1_1034)
