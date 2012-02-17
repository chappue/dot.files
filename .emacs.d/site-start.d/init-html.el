;; -*- mode:Emacs-Lisp coding:utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; html-helper-mode
;;-> http://www.nongnu.org/baol-hth/index.html
(when (locate-library "html-helper-mode")
  (autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; psgml-mode
;;-> http://www.lysator.liu.se/~lenst/about_psgml/
(when (locate-library "psgml-mmode")
  (autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
  (autoload 'xml-mode "psgml" "Major mode to edit XML files." t)
  (setq sgml-catalog-files '("CATALOG" "~/.emacs.d/psgml/CATALOG"))
  (setq sgml-ecat-files '("ECAT" "~/.emacs.d/psgml/ECAT"))
  (setq sgml-set-face t)
  (setq sgml-custom-dtd
        '(("XHTML 1.0 Strict"
           "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"
\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">")
          ("XHTML 1.0 Translational"
           "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Translational//EN\"
\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">")
          ("XHTML 1.0 Frameset"
           "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE html PUBLIC \"-//W3trict.dtd"
           sgml-omittag nil sgml-shorttag nil)
          ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Nxml-mode
;;-> http://www.thaiopensource.com/nxml-mode/
(when (locate-library "nxml-mode")
  ;(load "nxml-mode/rng-auto.el")
  (setq nxml-syntax-highlight-flag t)
  )

(provide 'init-html)