;; -*- mode:Emacs-Lisp coding:utf-8 -*-

(require 'webjump)
(setq webjump-sites
      (append '(
                ("GJ" .                 ; Google Japan
                 [simple-query
                  "http://www.google.co.jp/"
                  "http://www.google.co.jp/search?q=" "&num=100&hl=ja&newwindow=1"] )
                ("E" .                  ; Eijiro
                 [simple-query
                  "http://www.alc.co.jp/"
                  "http://eow.alc.co.jp/" "/UTF-8/?ref=sa"] )
                )
              webjump-sample-sites))

(provide 'init-webjump)
