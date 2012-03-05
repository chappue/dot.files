
;; マウスポインタ上のfaceを調べる
(defun describe-face-at-point ()
 (interactive)
 (message "%s" (get-char-property (point) 'face)))

