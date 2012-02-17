;;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;;                       misc settings
;;------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Don't erase *scratch* buffer
;;-> http://www-tsujii.is.s.u-tokyo.ac.jp/~yoshinag/tips/elisp_tips.html#scratch
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; reminder "*scratch*" buffer
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))

(add-hook 'kill-buffer-query-functions
          ;; Erase Buffer when kill-buffer for *scratch*
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (progn (my-make-scratch 0) nil)
              t)))

(add-hook 'after-save-hook
          ;; when "*scratch*" saved create New *scratch* buffer
          (lambda ()
            (unless (member (get-buffer "*scratch*") (buffer-list))
              (my-make-scratch 1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; remove duplicate entry from history
;;-> http://www.bookshelf.jp/soft/meadow_27.html#SEC322
(require 'cl)
(defun minibuffer-delete-duplicate ()
  (let (list)
    (dolist (elt (symbol-value minibuffer-history-variable))
      (unless (member elt list)
        (push elt list)))
    (set minibuffer-history-variable (nreverse list))))
(add-hook 'minibuffer-setup-hook 'minibuffer-delete-duplicate)




;;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;;                       misc function
;;------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Script file saveing with $chmod a+x
;;   Katsumi Yamaoka <yamaoka@ga.sony.co.jp>
(defun make-file-executable ()
  "Make the file of this buffer executable, when it is a script source."
  (save-restriction
    (widen)
    (if (string= "#!" (buffer-substring-no-properties 1 (min 3 (point-max))))
        (let ((name (buffer-file-name)))
          (or (equal ?. (string-to-char (file-name-nondirectory name)))
              (let ((mode (file-modes name)))
                (set-file-modes name (logior mode (logand (/ mode 4) 73)))
                ;;(message (concat "Wrote " name " (a+xw)"))
                ))))))
(add-hook 'after-save-hook 'make-file-executable)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;-> http://homepage1.nifty.com/blankspace/emacs/tips.html
(defun chop-region-side (beg end)
  (interactive "r")
  (and (> (- end beg) 2)
       (let ((str (buffer-substring (1+ beg) (1- end))))
         (delete-region beg end)
         (insert str))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; file reopen
;;-> http://namazu.org/~satoru/diary/20020327.html#p02
(defun reopen-file ()
  (interactive)
  (let ((file-name (buffer-file-name))
        (old-supersession-threat
         (symbol-function 'ask-user-about-supersession-threat))
        (point (point)))
    (when file-name
      (fset 'ask-user-about-supersession-threat (lambda (fn)))
      (unwind-protect
          (progn
            (erase-buffer)
            (insert-file file-name)
            (set-visited-file-modtime)
            (goto-char point))
        (fset 'ask-user-about-supersession-threat 
              old-supersession-threat)))))
(define-key ctl-x-map "\C-r"  'reopen-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Change file attribule
;;->http://localhost
(defun writeable ()
  "set file attribute on read and write"
  (interactive)
  (let ((file (buffer-file-name)) (point_l (point)))
    ;; chmod 666 FILE_NAME
    (set-file-modes (buffer-file-name) 438)
    (write-file (concat (buffer-file-name) ".orig"))
    (kill-buffer (current-buffer))
    (find-file file)
    (goto-char point_l)))

(defun readonly ()
  "set file attribute on readonly"
  (interactive)
  (let ((file (buffer-file-name)) (point_l (point)))
    ;; chmod 444 FILE_NAME
    (set-file-modes (buffer-file-name) 292)
    (kill-buffer (current-buffer))
    (find-file file)
    (goto-char point_l)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; insert sequencial number
(require 'rect)
(lexical-let ((init-num 0) (inc-num 0))
  (defun seq-number-rectangle-line (startcol endcol ininum delete)
    (move-to-column-force startcol)
    (if delete
        (delete-rectangle-line startcol endcol nil))
    (if (not (= init-num ininum))
        (progn
          (setq init-num ininum)
          (setq inc-num init-num)))
    (insert (format "%d" inc-num))
    (setq inc-num (1+ inc-num)))

;;   (defun seq-number-rectangle-word-line (startcol ininum delete)
;;     (move-to-column-force startcol)
;;     (if delete
;;         (delete-word-line startcol))
;;     )

  (defun seq-number-rectangle (start end init-number)
    "to wite"
    (interactive "*r\nnfirst number: ")
    (setq init-num 0)
    (apply-on-rectangle 'seq-number-rectangle-line start end init-number t))

  (defun seq-number-rectangle-word (start end init-number)
    "rev. word"
    (interactive "*r\nnfirst number: ")
    (setq init-num 0)
    (apply-on-rectangle 'seq-number-rectangle-word-line start end init-number t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; number-region-to-register
(defun number-region-to-register (start end register)
  "Store a number in a register from region."
  (interactive "r\ncNumber to register: ")
  (let ((number (string-to-number (buffer-substring start end))))
    (set-register register
                  (if (numberp number)
                      number
                    0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; charactor-to-register
(defun charactor-to-register (char register)
  "Store a charactor in a register."
  (interactive "ctype charactor: \ncNumber to register: ")
  (set-register register (char-to-string char)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; char-increment-register
(defun char-increment-register (number register)
  "Store a charactor in a register."
  (interactive "p\ncNumber to register: ")
  (or (char-or-string-p (get-register register))
      (error "Register does not contain a charactor"))
  (set-register register (char-to-string (+ number (string-to-char (get-register register))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; searching files related visual-basic
(lexical-let ((point-stack (list nil)))
  (defun vb-grep-find (string)
    (interactive (list (read-from-minibuffer "Input Regexp: " (thing-at-point 'symbol))))
    (push (point-marker) point-stack)
    (moccur-grep-find (expand-file-name ".") (list string "\\.\\(frm\\|bas\\)$")))
  (defun pop-stack-vb-grep-find ()
    (interactive)
    (let ((marker (pop point-stack)))
      (switch-to-buffer (marker-buffer marker))
      (goto-char marker)
    ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; delete from begin-region to end-of-line
(defun delete-to-end-of-line (beg end)
  (interactive "r")
  (save-excursion
    (apply-on-rectangle
     '(lambda (st ed)
        (let (st-pos)
          (move-to-column st 'force)
          (setq st-pos (point))
          (delete-region st-pos (progn (end-of-line) (point)))))
     beg end)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; insert string to end-fo-line
(defun insert-string-to-end-of-line (beg end str)
  (interactive "r\nMstring? ")
  (save-excursion
    (apply-on-rectangle
     '(lambda (st ed)
          (end-of-line)
          (insert str))
     beg end)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; colornize space,tab
;;-> http://homepage1.nifty.com/blankspace/emacs/color.html
(defface my-face-b-1 '((t (:background "dark slate gray"))) nil)
;; dark slate gray, RoyalBlue4
(defface my-face-b-2 '((t (:background "gray19"))) nil)
(defface my-face-u-1 '((t (:foreground "magenta1" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("　" 0 my-face-b-1 append)
     ("\t" 0 my-face-b-2 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; which func
(defun my-which-func ()
  (interactive)
  (let ((name))
    (when (and (null name)
               (boundp 'imenu--index-alist) imenu--index-alist)
      (let ((alist imenu--index-alist)
            (minoffset (point-max))
            offset elem pair mark)
        (while alist
        (setq elem  (car-safe alist)
              alist (cdr-safe alist))
        ;; Elements of alist are either ("name" . marker), or
        ;; ("submenu" ("name" . marker) ... ).
        (unless (listp (cdr elem))
          (setq elem (list elem)))
        (while elem
          (setq pair (car elem)
                elem (cdr elem))
          (and (consp pair)
               (number-or-marker-p (setq mark (cdr pair)))
               (if (>= (setq offset (- (point) mark)) 0)
                   (if (< offset minoffset) ; find the closest item
                       (setq minoffset offset
                             name (car pair)))
                 ;; Entries in order, so can skip all those after point.
                 (setq elem nil)))))))
    name))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TIME(HH:MM:SS.xxx) string convert to SECONDS integer
(defun time-to-sec(str)
  (let ((time-str (mapcar 'string-to-int (split-string (replace str ":" :start1 8) ":"))))
    (+ (* (* 60.0 60.0) (nth 0 time-str)) (* 60.0 (nth 1 time-str)) (nth 2 time-str) (/ (nth 3 time-str) 1000.0))))

