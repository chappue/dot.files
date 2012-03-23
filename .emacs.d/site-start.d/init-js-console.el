;; -*- mode:Emacs-Lisp coding:utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ejacs
(when (locate-library "js-console")

  ;; C-c C-jでjs-consoleを起動
  ;; C-c rで選択範囲を実行
  (autoload 'js-console "js-console" nil t)
  (defun js-console-execute-region (start end)
    "Execute region"
    (interactive "r")
    (let ((buf-name (buffer-name (current-buffer))))
      (copy-region-as-kill start end)
      (switch-to-buffer-other-window "*js*")
      (js-console-exec-input (car kill-ring))
      (switch-to-buffer-other-window buf-name)))
  (defun run-js-console-and-split-window ()
    "Run js-console and split window horizontally."
    (interactive)
    (split-window-horizontally)
    (js-console)
    (other-window 1)
    )
  (add-hook 'js2-mode-hook
            (lambda ()
              (moz-minor-mode 1) ;; 要moz.el
              (local-set-key "\C-c\C-j" 'run-js-console-and-split-window)
              (local-set-key "\C-cr" 'js-console-execute-region)
              ))
  )

(provide 'init-js-console)