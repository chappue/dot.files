;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hexl-mode
(when (locate-library "hexl")
  (autoload 'hexl-mode "hex" "" t)

  (when (locate-library "auto-save-buffers")
    (defadvice other-window (after hexl-mode-auto-save-buffers-off act)
      (if (string= mode-name "Hexl")
          (auto-save-buffers-enable nil)
        (auto-save-buffers-enable t)))
    )
  )

(provide 'init-hexl)