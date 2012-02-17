;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dired-mode
;;-> http://www.math.s.chiba-u.ac.jp/~matsu/emacs/emacs21/dired.html
(when (locate-library "dired")
  (when (locate-library "dired-x")
    (add-hook 'dired-load-hook (lambda () (load "dired-x")))
    )

  ;; directory open on one window
  ;;-> http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=dired%20single
  (defun dired-my-advertised-find-file ()
    (interactive)
    (let ((kill-target (current-buffer))
          (check-file (dired-get-filename)))
      (funcall 'dired-advertised-find-file)
      (if (file-directory-p check-file)
          (kill-buffer kill-target))))

  (defun dired-my-up-directory (&optional other-window)
    "Run dired on parent directory of current directory.
Find the parent directory either in this buffer or another buffer.
Creates a buffer if necessary."
    (interactive "P")
    (let* ((dir (dired-current-directory))
           (up (file-name-directory (directory-file-name dir))))
      (or (dired-goto-file (directory-file-name dir))
          ;; Only try dired-goto-subdir if buffer has more than one dir.
          (and (cdr dired-subdir-alist)
               (dired-goto-subdir up))
          (progn
            (if other-window
                (dired-other-window up)
              (progn
                (kill-buffer (current-buffer))
                (dired up))
              (dired-goto-file dir))))))

  (add-hook 'dired-mode-hook
            (lambda ()
              (define-key dired-mode-map "\C-m" 'dired-my-advertised-find-file)
              (define-key dired-mode-map "^" 'dired-my-up-directory)))

  ;; open via fiber
  (defun dired-fiber-find ()
    (interactive)
    (let ((file (dired-get-filename)))
      (if (file-directory-p file)
          (start-process "explorer" "diredfiber" "explorer.exe"
                         (unix-to-dos-filename file))
        (start-process "fiber" "diredfiber" "fiber.exe" file))))

  ;; copy to remote file
  (defun dired-copy-remote-file (toFile)
    (interactive (list (dired-copy-remote-file-regexp)))
    (dired-copy-file (dired-get-filename) toFile t))

  (defun dired-copy-remote-file-regexp ()
    (interactive)
    (let ((file (dired-get-filename)))
      (read-file-name "Copy to: " (get-remote-file-path dired-copy-remote-file-table file))))

  (defun search-remote-file-table (regexp file)
    (let ((n 0))
      (while (car (nth n regexp))
        (while (string-match (car (nth n regexp)) file)
          (setq file (concat (substring file 0 (match-beginning 0)) (cadr (nth n regexp)) (substring file (match-end 0)))))
        (setq n (1+ n)))
      file))
  (defmacro get-remote-file-path (lst fname)
    (append '(cond) (mapcar (lambda (regexp)
                              (list (eq 0 (string-match (car regexp) (eval fname)))
                                    (search-remote-file-table (cdr regexp) (eval fname))))
                            (eval lst))))

  (add-hook 'dired-mode-hook
            (lambda ()
              (define-key dired-mode-map "z" 'dired-fiber-find)
              (define-key dired-mode-map "\C-c\C-c" 'dired-copy-remote-file)))

  ;; marked file's coding-system convert
  (require 'dired-aux)
  (add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "T" 'dired-do-convert-coding-system)))

(defvar dired-default-file-coding-system nil
  "*Default coding system for converting file (s).")

(defvar dired-file-coding-system 'no-conversion)

(defun dired-convert-coding-system ()
  (let ((file (dired-get-filename))
        (coding-system-for-write dired-file-coding-system)
        failure)
    (condition-case err
        (with-temp-buffer
          (insert-file file)
          (write-region (point-min) (point-max) file))
      (error (setq failure err)))
    (if (not failure)
        nil
      (dired-log "convert coding system error for %s:\n%s\n" file failure)
      (dired-make-relative file))))

(defun dired-do-convert-coding-system (coding-system &optional arg)
  "Convert file (s) in specified coding system."
  (interactive
   (list (let ((default (or dired-default-file-coding-system
                            buffer-file-coding-system)))
           (read-coding-system
            (format "Coding system for converting file (s) (default, %s): "
                    default)
            default))
         current-prefix-arg))
  (check-coding-system coding-system)
  (setq dired-file-coding-system coding-system)
  (dired-map-over-marks-check
   (function dired-convert-coding-system) arg 'convert-coding-system t))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; wdired
;;->
(when (locate-library "wdired")
  (autoload 'wdired-change-to-wdired-mode "wdired")
  (add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)))
  )

(provide 'init-dired)