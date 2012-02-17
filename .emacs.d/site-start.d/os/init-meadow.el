;; For Meadow

;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;                        load path
;------------------------------------------------------------------

;; (setq load-path
;;       (append
;;        (list
;;         (expand-file-name "/usr/local/share/emacs/site-lisp")
;;         )
;;        load-path))

;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;                      font settings
;------------------------------------------------------------------
(w32-add-font
 "fontset-meirio"
 '((strict-spec
    ((:char-spec ascii :height any)
     (w32-logfont "ƒƒCƒŠƒI" 0 18 400 0 nil nil nil 0 1 3 49))
    ((:char-spec ascii :height any :weight bold)
     (w32-logfont "ƒƒCƒŠƒI" 0 18 700 0 nil nil nil 0 1 3 49))
    ((:char-spec ascii :height any :slant italic)
     (w32-logfont "ƒƒCƒŠƒI" 0 18 400 0 t nil nil 0 1 3 49))
    ((:char-spec ascii :height any :weight bold :slant italic)
     (w32-logfont "ƒƒCƒŠƒI" 0 18 700 0 t nil nil 0 1 3 49))
    ((:char-spec japanese-jisx0208 :height any)
     (w32-logfont "ƒƒCƒŠƒI" 0 18 400 0 nil nil nil 128 1 3 49))
    ((:char-spec japanese-jisx0208 :height any :weight bold)
     (w32-logfont "ƒƒCƒŠƒI" 0 18 700 0 nil nil nil 128 1 3 49)
     ((spacing . -1)))
    ((:char-spec japanese-jisx0208 :height any :slant italic)
     (w32-logfont "ƒƒCƒŠƒI" 0 18 400 0 t nil nil 128 1 3 49))
    ((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
     (w32-logfont "ƒƒCƒŠƒI" 0 18 700 0 t nil nil 128 1 3 49)
     ((spacing . -1)))
    ((:char-spec katakana-jisx0201 :height any)
     (w32-logfont "ƒƒCƒŠƒI" 0 18 400 0 nil nil nil 128 1 3 49))
    ((:char-spec katakana-jisx0201 :height any :weight bold)
     (w32-logfont "ƒƒCƒŠƒI" 0 18 700 0 nil nil nil 128 1 3 49)
     ((spacing . -1)))
    ((:char-spec katakana-jisx0201 :height any :slant italic)
     (w32-logfont "ƒƒCƒŠƒI" 0 18 400 0 t nil nil 128 1 3 49))
    ((:char-spec katakana-jisx0201 :height any :weight bold :slant italic)
     (w32-logfont "ƒƒCƒŠƒI" 0 18 700 0 t nil nil 128 1 3 49)
     ((spacing . -1)))
    )))


(w32-add-font
 "ms-gothic 14+"
 '((strict-spec
    ((:char-spec ascii :height any)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 14 400 0 nil nil nil 0 1 0 49))
    ((:char-spec ascii :height any :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 14 400 0   t nil nil 0 1 0 49))
    ((:char-spec ascii :height any :weight bold)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 14 700 0 nil nil nil 0 1 0 49) ((spacing . -1)))
    ((:char-spec ascii :height any :weight bold :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 14 700 0 nil nil nil 0 1 0 49) ((spacing . -1)))
    ((:char-spec japanese-jisx0208 :height any)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 400 0 nil nil nil 128 1 0 49))
    ((:char-spec japanese-jisx0208 :height any :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 400 0   t nil nil 128 1 0 49))
    ((:char-spec japanese-jisx0208 :height any :weight bold)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 700 0 nil nil nil 128 1 0 49) ((spacing . -1)))
    ((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 700 0   t nil nil 128 1 0 49) ((spacing . -1)))
    ((:char-spec katakana-jisx0201 :height any)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 400 0 nil nil nil 128 1 0 49))
    ((:char-spec katakana-jisx0201 :height any :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 400 0   t nil nil 128 1 0 49))
    ((:char-spec katakana-jisx0201 :height any :weight bold)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 700 0 nil nil nil 128 1 0 49) ((spacing . -1)))
    ((:char-spec katakana-jisx0201 :height any :weight bold :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 700 0   t nil nil 128 1 0 49) ((spacing . -1))))))

(w32-add-font
 "Lucida Console"
 '((strict-spec
    ((:char-spec ascii :height any)
     (w32-logfont "Lucida Console" 0 -13 400 0 nil nil nil 0 1 3 49))
    ((:char-spec ascii :height any :slant italic)
     (w32-logfont "Lucida Console" 0 -13 400 0 t nil nil 0 1 3 49))
    ((:char-spec ascii :height any :weight bold)
     (w32-logfont "Lucida Console" 0 -13 700 0 nil nil nil 0 1 3 49) ((spacing . -1)))
    ((:char-spec ascii :height any :weight bold :slant italic)
     (w32-logfont "Lucida Console" 0 -13 700 0 t nil nil 0 1 3 49) ((spacing . -1)))
    ((:char-spec japanese-jisx0208 :height any)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 12 400 0 nil nil nil 128 1 0 49))
    ((:char-spec japanese-jisx0208 :height any :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 12 400 0   t nil nil 128 1 0 49))
    ((:char-spec japanese-jisx0208 :height any :weight bold)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 12 700 0 nil nil nil 128 1 0 49) ((spacing . -1)))
    ((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 12 700 0   t nil nil 128 1 0 49) ((spacing . -1)))
    ((:char-spec katakana-jisx0201 :height any)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 12 400 0 nil nil nil 128 1 0 49))
    ((:char-spec katakana-jisx0201 :height any :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 12 400 0   t nil nil 128 1 0 49))
    ((:char-spec katakana-jisx0201 :height any :weight bold)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 12 700 0 nil nil nil 128 1 0 49) ((spacing . -1)))
    ((:char-spec katakana-jisx0201 :height any :weight bold :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 12 700 0   t nil nil 128 1 0 49) ((spacing . -1))))))

(w32-add-font
 "OCRB"
 '((strict-spec
    ((:char-spec ascii :height any)
     (w32-logfont "OCRB" 0 -15 400 0 nil nil nil 0 1 3 49))
    ((:char-spec ascii :height any :slant italic)
     (w32-logfont "OCRB" 0 -15 400 0 t nil nil 0 1 3 49))
    ((:char-spec ascii :height any :weight bold)
     (w32-logfont "OCRB" 0 -15 700 0 nil nil nil 0 1 3 49) ((spacing . -1)))
    ((:char-spec ascii :height any :weight bold :slant italic)
     (w32-logfont "OCRB" 0 -15 700 0 t nil nil 0 1 3 49) ((spacing . -1)))
    ((:char-spec japanese-jisx0208 :height any)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 400 0 nil nil nil 128 1 0 49))
    ((:char-spec japanese-jisx0208 :height any :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 400 0   t nil nil 128 1 0 49))
    ((:char-spec japanese-jisx0208 :height any :weight bold)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 700 0 nil nil nil 128 1 0 49) ((spacing . -1)))
    ((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 700 0   t nil nil 128 1 0 49) ((spacing . -1)))
    ((:char-spec katakana-jisx0201 :height any)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 400 0 nil nil nil 128 1 0 49))
    ((:char-spec katakana-jisx0201 :height any :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 400 0   t nil nil 128 1 0 49))
    ((:char-spec katakana-jisx0201 :height any :weight bold)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 700 0 nil nil nil 128 1 0 49) ((spacing . -1)))
    ((:char-spec katakana-jisx0201 :height any :weight bold :slant italic)
     (w32-logfont "‚l‚r ƒSƒVƒbƒN" 0 13 700 0   t nil nil 128 1 0 49) ((spacing . -1))))))

;; IE‚Æ“¯‚¶‚É‚·‚é‚È‚ç‚Î…•½•ûŒü‚ğ1ƒhƒbƒg‹ó‚¯‚é‚±‚Æ
(setq-default line-spacing 1)

;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;                        frame settings
;------------------------------------------------------------------
(setq initial-frame-alist
      (append (list
               '(top . 0)
               '(left . 0)
               '(width . 100)
               '(height . 50)

               '(font . "ms-gothic 14+")
               '(cursor-color . "deep pink")
               '(cursor-type . box)
               '(cursor-height . 4)

               )
              initial-frame-alist))

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(case-fold-search t)
 '(cua-mode nil)
 '(current-language-environment "Japanese")
 '(default-input-method "japanese")
 '(global-font-lock-mode t nil (font-lock))
 '(scroll-bar-mode nil)
 '(show-paren-mode t nil (paren))
 '(tool-bar-mode nil nil (tool-bar))
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

;; IME
(set-language-environment "Japanese")
(setq default-buffer-file-coding-system 'sjis-dos)
(setq default-input-method "MW32-IME")
(mw32-ime-initialize)

;Change cursor-color with toggle IME ON/OFF
(add-hook 'mw32-ime-on-hook
		  (lambda () (set-cursor-color "DeepSkyBlue")))
(add-hook 'mw32-ime-off-hook
		  (lambda () (set-cursor-color "deep pink")))

;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;                      misc settings
;------------------------------------------------------------------

;; NagaIGyou woORiKaeSazuniHyouzi suru.
(setq-default truncate-lines t)

;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;                      elisp settings
;------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; open directory
(defun open-directory (dir)
  (interactive "DDirectory? ")
  (shell-command (concat "cygstart " "\"" (expand-file-name dir) "\"")))

(provide 'init-meadow)