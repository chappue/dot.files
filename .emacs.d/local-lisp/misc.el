
;; �}�E�X�|�C���^���face�𒲂ׂ�
(defun describe-face-at-point ()
 (interactive)
 (message "%s" (get-char-property (point) 'face)))

