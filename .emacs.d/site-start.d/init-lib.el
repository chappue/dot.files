;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mapae
;;-> http://nyam.info/diary/archives/20031130061500.html
(when (locate-library "mapae")
  (require 'mapae)
  (setq mapae-perl-command "/usr/bin/perl")
  (setq mapae-command "/Users/NaCl/local/perl/mapae.pl")
  (setq mapae-favorite-mode 'html-helper-mode)
  (define-key mode-specific-map "wn" 'mapae-new-post)
  (define-key mode-specific-map "wr" 'mapae-get-recent-post)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; htmlize
;;-> http://fly.srk.fer.hr/~hniksic/emacs/htmlize.el
(when (locate-library "htmlize-buffer")
  (autoload 'htmlize-buffer "htmlize" "Convert buffer to html." t)
  (autoload 'htmlize-region "htmlize" "Convert region to html." t)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GNU global -gtag-
;;-> http://www.gnu.org/software/global/global.html
(when (and (locate-library "gtags") (not (locate-library "xcscope")))
  (require 'gtags)
  (setq gtags-mode-hook
        '(lambda ()
           (local-set-key [?\M-.] 'gtags-find-tag)
           (local-set-key "\M-r" 'gtags-find-rtag)
           (local-set-key "\M-s" 'gtags-find-symbol)
           (local-set-key "\M-p" 'gtags-find-pattern)
           (local-set-key "\M-f" 'gtags-find-file)
           (local-set-key [?\C-.] 'gtags-pop-stack)
           ))
  (add-hook 'gtags-select-mode-hook
        '(lambda ()
           (local-set-key [?\M-.] 'gtags-find-tag)
           (local-set-key "\M-r" 'gtags-find-rtag)
           (local-set-key "\M-s" 'gtags-find-symbol)
           (local-set-key "\M-p" 'gtags-find-pattern)
           (local-set-key "\M-f" 'gtags-find-file)
           (local-set-key [?\C-.] 'gtags-pop-stack)
           ))
  ;; C-mode hook
  (add-hook 'c-mode-common-hook
          '(lambda()
             (gtags-mode t)
;;              (gtags-make-complete-list)
             ))

  ;;-> http://d.hatena.ne.jp/rubikitch/20080304/gtags
  (defun gtags-goto-tag (tagname flag)
    (let (save prefix buffer lines)
      (setq save (current-buffer))
      (cond
       ((equal flag "P")
        (setq prefix "(P)"))
       ((equal flag "g")
        (setq prefix "(GREP)"))
       ((equal flag "I")
        (setq prefix "(IDUTILS)"))
       ((equal flag "s")
        (setq prefix "(S)"))
       ((equal flag "r")
        (setq prefix "(R)"))
       (t (setq prefix "(D)")))
      ;; load tag
      (setq buffer (generate-new-buffer (generate-new-buffer-name (concat "*GTAGS* " prefix tagname))))
      (set-buffer buffer)
      (message "Searching %s ..." tagname)
      (if (not (= 0 (call-process "global" nil t nil (concat "-x" flag) tagname))) ; remove '-a' option
          (progn (message (buffer-substring (point-min)(1- (point-max))))
                 (gtags-pop-context))
        (goto-char (point-min))
        (setq lines (count-lines (point-min) (point-max)))
        (cond
         ((= 0 lines)
          (cond
           ((equal flag "P")
            (message "%s: path not found" tagname))
           ((equal flag "g")
            (message "%s: pattern not found" tagname))
           ((equal flag "I")
            (message "%s: token not found" tagname))
           ((equal flag "s")
            (message "%s: symbol not found" tagname))
           (t
            (message "%s: tag not found" tagname)))
          (gtags-pop-context)
          (kill-buffer buffer)
          (set-buffer save))
         ((= 1 lines)
          (message "Searching %s ... Done" tagname)
          (gtags-select-it t))
         (t
          ;; added by rubikitch
          (goto-char (point-min))
;;           (while (not (eobp))
;;             (put-text-property (point) (+ 16 (point)) 'invisible t)
;;             (forward-line 1))
          (while (not (eobp))             ;@@@hack
            (let (bol word-end)
              (setq bol (point))
              (forward-sexp 1)
              (setq word-end (point))
              (if (< (- word-end bol) 16)
                  (setq word-end (+ bol 16)))
              (put-text-property bol word-end 'invisible t)
              ;; (move-beginning-of-line 1))
              (beginning-of-line 1))
            (forward-line 1))
          (goto-char (point-min))
          (switch-to-buffer buffer)
          (gtags-select-mode))))))

  (defun gtags-select-it (delete)
    (let (line file)
      ;; get context from current tag line
      (beginning-of-line)
      (if (not (looking-at "[^ \t]+[ \t]+\\([0-9]+\\)[ \t]\\([^ \t]+\\)[ \t]"))
          (gtags-pop-context)
        (setq line (string-to-number (gtags-match-string 1)))
        (setq file (expand-file-name (gtags-match-string 2)))
        (if delete (kill-buffer (current-buffer)))
        ;; move to the context
        (if gtags-read-only (find-file-read-only file) (find-file file))
        (setq gtags-current-buffer (current-buffer))
        (goto-line line)
        (gtags-mode 1))))

  )

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eldoc
(when (locate-library "eldoc")
  (autoload 'turn-on-eldoc-mode "eldoc" nil t)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cua-mode
;;-> http://dev.ariel-networks.com/articles/emacs/part5
;;-> http://www.emacswiki.org/CuaMode
(when (locate-library "cua-base")
  (cua-mode t)
  (setq cua-enable-cua-keys nil)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rst-mode
;;-> http://docutils.sourceforge.net/rst.html
(when (locate-library "rst")
  (require 'rst)
  (setq frame-background-mode 'dark)
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(rst-level-1-face ((t (:foreground "LightSkyBlue"))) t)
   '(rst-level-2-face ((t (:foreground "LightGoldenrod"))) t)
   '(rst-level-3-face ((t (:foreground "Cyan1"))) t)
   '(rst-level-4-face ((t (:foreground "chocolate1"))) t)
   '(rst-level-5-face ((t (:foreground "PaleGreen"))) t)
   '(rst-level-6-face ((t (:foreground "Aquamarine"))) t)
   '(rst-level-7-face ((t (:foreground "LightSteelBlue"))) t)
   '(rst-level-8-face ((t (:foreground "LightSalmon"))) t))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; win32-symlinks
;;-> http://centaur.maths.qmw.ac.uk/Emacs/
;;-> http://www.bookshelf.jp/soft/meadow_25.html#SEC283
;;-> http://www.bookshelf.jp/pukiwiki/pukiwiki.php?refer=MeadowMemo&cmd=read&page=MeadowMemo%2Fdired%A4%C7Windows%A4%CE%A5%EA%A5%F3%A5%AF%A4%F2%B0%B7%A4%A6%A1%BDw32%2Dsymlinks
(when (locate-library "w32-symlinks")
  (require 'w32-symlinks)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; woman
(when (locate-library "woman")
  (setq woman-use-own-frame nil)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bookmark
(when (locate-library "bookmark")
  (setq bookmark-default-file "~/.emacs.d/.emacs_bmk"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; deferred
(when (locate-library "deferred")
  (require 'deferred)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; deferred
(when (locate-library "evernote-mode")
  (require 'evernote-mode)
  (global-set-key "\C-cec" 'evernote-create-note)
  (global-set-key "\C-ceo" 'evernote-open-note)
  (global-set-key "\C-ces" 'evernote-search-notes)
  (global-set-key "\C-ceS" 'evernote-do-saved-search)
  (global-set-key "\C-cew" 'evernote-write-note)
  (global-set-key "\C-cep" 'evernote-post-region)
  )

;; Emac initialization file

;;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;;                      load path
;;------------------------------------------------------------------
(let ((dir (expand-file-name "~/.emacs.d/site-lisp")))
  (if (member dir load-path)
      nil
    (setq load-path (cons dir load-path))
    (let ((default-directory dir))
      (load (expand-file-name "subdirs.el") t t t))))

;;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;;                      mode settings
;;------------------------------------------------------------------
