;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-save-buffers
;;-> http://homepage3.nifty.com/oatu/emacs/misc.html#asb
(when (locate-library "auto-save-buffers")
  (require 'auto-save-buffers)
  (run-with-idle-timer 0.5 t 'auto-save-buffers)
  (define-key ctl-x-map "as" 'auto-save-buffers-toggle)

  (defun auto-save-buffers-enable (enable)
    (if enable
        (setq auto-save-buffers-active-p t)
      (setq auto-save-buffers-active-p nil)))
;;   (defadvice switch-to-buffer (after disable-auto-save-when-remote-file activate)
;;     "auto-save-buffers disable when switch to remote file."
;;     (if (numberp (string-match "\\`/\\(\\([^/:]*\\)@\\)?\\([^@/:]*[^@/:.]\\):\\(.*\\)" (buffer-file-name (current-buffer))))
;;         (setq auto-save-buffers-active-p nil)
;;       (setq auto-save-buffers-active-p t)))
  )

(provide 'init-auto-save-buffers)