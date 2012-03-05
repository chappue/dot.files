;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; skk
;;-> http://openlab.ring.gr.jp/skk/main-ja.html
;;-> http://openlab.ring.gr.jp/skk/skk/dic/
(when (locate-library "skk")
  (setq default-input-method "japanese-skk")
  ;; File open with SKK-mode
  (add-hook 'find-file-hooks 'skk-mode)
  (add-hook 'skk-mode-hook
            (lambda ()
              (skk-latin-mode 1)))

  ;; http://openlab.ring.gr.jp/skk/maintrunk/
  ;; http://openlab.ring.gr.jp/skk/skk-manual/skk-manual-ja.html
  (require 'skk-autoloads)
  (define-key ctl-x-map "\C-j" 'skk-mode)
  ;; (define-key ctl-x-map "t" 'skk-tutorial)
  (autoload 'skk-mode "skk" nil t)
  (autoload 'skk-auto-fill-mode "skk" nil t)
  ;; (autoload 'skk-tutorial "skk-tut" nil t)
  (autoload 'skk-check-jisyo "skk-tools" nil t)
  (autoload 'skk-merge "skk-tools" nil t)
  (autoload 'skk-diff "skk-tools" nil t)
  ;; (autoload 'skk-isearch-mode-setup "skk-isearch" nil t)
  ;; (autoload 'skk-isearch-mode-cleanup "skk-isearch" nil t)
  ;; (add-hook 'isearch-mode-hook
  ;;           (function (lambda ()
  ;;                       (and (boundp 'skk-mode) skk-mode
  ;;                            (skk-isearch-mode-setup)))))
  
  ;; (add-hook 'isearch-mode-end-hook
  ;;           (function
  ;;            (lambda ()
  ;;              (and (boundp 'skk-mode) skk-mode (skk-isearch-mode-cleanup))
  ;;              (and (boundp 'skk-mode-invoked) skk-mode-invoked
  ;;                   (skk-set-cursor-properly)))))

  (setq skk-use-color-cursor t)
  (setq skk-report-set-cursor-error t)
  (setq skk-status-indicator 'left) ;default 'nil
  (setq skk-use-look t)
  (setq skk-look-recursive-search t)

;;; skkファイルの置き場所
  (setq skk-jisyo               "~/.emacs.d/share/skk/skk-jisyo"
        skk-backup-jisyo        "~/.emacs.d/share/skk/skk-jisyo.BAK"
        skk-record-file         "~/.emacs.d/share/skk/skk-record"
        skktut-tut-jisyo        "~/.emacs.d/share/skk/skk-tut-jisyo")

  ;; migemo を使うから skk-isearch にはおとなしくしていて欲しい
  ;; (setq skk-isearch-start-mode 'latin)
  (setq skk-isearch-mode-enable nil)

  ;; 変換のときEnterを押しても確定のみで改行しない。
  (setq skk-egg-like-newline t)

  ;; 変換の確定等をCtrl-lに変更
  ;; (define-key skk-latin-mode-map "\C-j" 'newline-and-indent)
  ;; (define-key skk-jisx0208-latin-mode-map "\C-j" 'newline-and-indent)
  (setq skk-kakutei-key "\C-l")

  ;; 辞書登録時に送り仮名のチェックを行う
  (setq skk-check-okurigana-on-touroku t)

  ;; My key table
  (add-hook 'skk-load-hook
            (lambda ()
              (progn
                (setq skk-rom-kana-rule-list
                      (append skk-rom-kana-rule-list
                              '(([non-convert] nil skk-latin-mode)
                                ))))))

  ;; モードライン行の表示
  (setq skk-indicator-use-cursor-color nil)
  (setq skk-cursor-latin-color "deep pink")
  (setq skk-latin-mode-string "a")
  (setq skk-hiragana-mode-string "あ")
  (setq skk-katakana-mode-string "ア")
  (setq skk-jisx0208-latin-mode-string "Ａ")

;;; sticky-shiftを使う
  ;;    http://homepage1.nifty.com/blankspace/emacs/sticky.html
  ;;     ここが本家ながら、ここのコードでは動かなかったで
  ;;    http://www.bookshelf.jp/soft/meadow_21.html
  ;;     このサイトのコードを頂いた。
  (defvar sticky-key ";")
  (defvar sticky-list  ;; 日本語配列
    '(("a" . "A") ("b" . "B") ("c" . "C") ("d" . "D") ("e" . "E") ("f" . "F") ("g" . "G")
      ("h" . "H") ("i" . "I") ("j" . "J") ("k" . "K") ("l" . "L") ("m" . "M") ("n" . "N")
      ("o" . "O") ("p" . "P") ("q" . "Q") ("r" . "R") ("s" . "S") ("t" . "T") ("u" . "U")
      ("v" . "V") ("w" . "W") ("x" . "X") ("y" . "Y") ("z" . "Z")
      ("1" . "!") ("2" . "\"") ("3" . "#") ("4" . "$") ("5" . "%") ("6" . "&") ("7" . "'")
      ("8" . "(") ("9" . ")") ("0" . "_")
      ("@" . "`") ("[" . "{") ("]" . "}") ("-" . "=") (":" . "*") ("," . "<") ("." . ">")
      ("/" . "?") (";" . "+") ("\\" . "|") ("^" . "~")
      ))
  ;; (defvar sticky-list  ;; 英字配列
  ;;   '(("a" . "A")("b" . "B")("c" . "C")("d" . "D")("e" . "E")("f" . "F")("g" . "G")
  ;;     ("h" . "H")("i" . "I")("j" . "J")("k" . "K")("l" . "L")("m" . "M")("n" . "N")
  ;;     ("o" . "O")("p" . "P")("q" . "Q")("r" . "R")("s" . "S")("t" . "T")("u" . "U")
  ;;     ("v" . "V")("w" . "W")("x" . "X")("y" . "Y")("z" . "Z")
  ;;     ("1" . "!")("2" . "@")("3" . "#")("4" . "$")("5" . "%")("6" . "^")("7" . "&")
  ;;     ("8" . "*")("9" . "(")("0" . ")")
  ;;     ("`" . "~")("[" . "{")("]" . "}")("-" . "_")("=" . "+")("," . "<")("." . ">")
  ;;     ("/" . "?")(";" . ":")("'" . "\"")("\\" . "|")
  ;;     ))  
  (defvar sticky-map (make-sparse-keymap))

  ;; SKK以外でもsticky shiftを使う？
  ;; (define-key global-map sticky-key sticky-map)

  (mapcar (lambda (pair)
            (define-key sticky-map (car pair)
              `(lambda() (interactive)
                 (setq unread-command-events
                       (cons , (string-to-char (cdr pair)) unread-command-events)))))
          sticky-list)
  (define-key sticky-map sticky-key '(lambda () (interactive) (insert sticky-key)))
  (add-hook 'skk-mode-hook
            (lambda ()
              (progn
                (define-key skk-j-mode-map sticky-key sticky-map)
                (define-key skk-jisx0208-latin-mode-map sticky-key sticky-map)
                (define-key skk-abbrev-mode-map sticky-key sticky-map)
                )
              ))
  )

(provide 'init-skk)