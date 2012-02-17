;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;; For Mac OS X

;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;                     language settings
;------------------------------------------------------------------

; For Japanese
(set-default-coding-systems 'utf-8-unix)
(set-keyboard-coding-system 'sjis-mac)
(set-clipboard-coding-system 'sjis-mac)
(set-terminal-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)
(set-selection-coding-system 'sjis-mac)

(setq default-input-method "MacOSX")

;; Font setting

(set-face-attribute 'default nil
					:family "Monaco"
					:height 120)
(set-fontset-font "fontset-default"
				  'japanese-jisx0208
				  '("Hiragino_Kaku_Gothic_Pro" . "iso10646-1"))
(set-fontset-font "fontset-default"
				  'katakana-jisx0201
				  '("Hiragino_Kaku_Gothic_Pro" . "iso10646-1"))
(setq face-font-rescale-alist
	  '((".*Monaco-medium.*" . 1.0)
		(".*Monaco-bold.*" . 1.0)
		(".*Hiragino_Kaku_Gothic_Pro-bold.*" . 1.0)
		(".*Hiragino_Kaku_Gothic_Pro-medium.*" . 1.0)))

;;    (#x370 . #x3ff)                      ; ギリシャ
;;    (#x400 . #x4ff)                      ; キリル
;;    (#x2000 . #x206f)                    ; 一般句読点
;;    (#x2103 . #x2103)                    ; ℃
;;    (#x212b . #x212b)                    ; Å
;;    (#x2190 . #x21ff)                    ; 矢印
;;    (#x2200 . #x22ff)                    ; 数学記号
;;    (#x2300 . #x23ff)                    ; 技術記号
;;    (#x2460 . #x2473)                    ; 円囲み数字
;;    (#x2500 . #x257f)                    ; 罫線
;;    (#x25a0 . #x25ff)                    ; 幾何学模様
;;    (#x2600 . #x26ff)                    ; その他の記号

;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;                        environment
;------------------------------------------------------------------

; Use Anti-alising
(setq mac-allow-anti-aliasing t)

;; Yen2BackSlash
(define-key global-map [?\C-¥] [?\C-\\])
(define-key global-map [?\M-¥] [?\M-\\])
(define-key global-map [?\C-\M-¥] [?\C-\M-\\])

;; modifier key
(setq ns-alternate-modifier 'super)
(setq ns-command-modifier 'meta)

;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;                          library
;------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mac-drag-N-drop
;;   Drag&Drop機能をカスタマイズ
;;-> http://macwiki.sourceforge.jp/cgi-bin/wiki.cgi?mac%2ddrag%2dN%2ddrop
;(autoload 'mac-mac-drag-N-drop "mac-drag-N-drop" "An alternative to mac-drag-n-drop." t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mac-key-mode
;;   Mac風のキーバインドや周辺機能を提供する
;;-> http://macwiki.sourceforge.jp/cgi-bin/wiki.cgi?mac%2dkey%2dmode
;;(autoload 'mac-key-mode "mac-key-mode" "Mac-style key-binding mode." t)
;;(require 'mac-key-mode)
;;(mac-key-mode)
;;; Command+f を goto-line に割り当てる
;;(define-key mac-key-mode-map [(alt f)] 'goto-line)

(provide 'init-mac)