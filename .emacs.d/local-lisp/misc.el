
;; マウスポインタ上のfaceを調べる
(defun describe-face-at-point ()
 (interactive)
 (message "%s" (get-char-property (point) 'face)))

;; リストを平滑化
(defun flatten (lis)
  (cond ((atom lis) lis)
        ((listp (car lis))
         (append (flatten (car lis)) (flatten (cdr lis))))
        (t (append (list (car lis)) (flatten (cdr lis))))))

;; 各行に関数を適用
(defun apply-function-to-region-lines (fn)
  (interactive "aFunction to apply to lines in region: ")
  (save-excursion
    (goto-char (region-end))
    (let ((end-marker (copy-marker (point-marker)))
          next-line-marker)
      (goto-char (region-beginning))
      (if (not (bolp))
          (forward-line 1))
      (setq next-line-marker (point-marker))
      (while (< next-line-marker end-marker)
        (let ((start nil)
              (end nil))
          (goto-char next-line-marker)
          (save-excursion
            (setq start (point))
            (forward-line 1)
            (set-marker next-line-marker (point))
            (setq end (point)))
          (save-excursion
            (let ((mark-active nil))
              (narrow-to-region start end)
              (funcall fn)
              (widen)))))
      (set-marker end-marker nil)
      (set-marker next-line-marker nil))))

;; (defun sample()
;;   (interactive)
;;   (progn
;;     (goto-char (line-beginning-position))
;;     (let ((st (point)) ed str buffer)
;;       (goto-char (line-end-position))
;;       (setq ed (point))
;;       (setq str (split-string (buffer-substring-no-properties st ed) ","))
;;       (setq buffer (buffer-name))
;;       (set-buffer "foo")
;;       (goto-char (point-min))
;;       (let ((dup 0))
;;         (while (search-forward (nth 0 str) nil t)
;;           (progn
;;             (if (< 0 dup)
;;                 (insert-string (concat "	" (number-to-string dup))))
;;             (setq dup (+ dup 1)))))
;;       (set-buffer buffer)
;; )))
