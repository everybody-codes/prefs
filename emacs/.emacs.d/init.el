;; I need to keep this here commented out like this to prevent package.el from
;; automatically adding it again. I call `(package-initalize)' manually from
;; the `core/siren-packages.el' file that's loaded in further down.
;;
;; (package-initialize)

;; Always load newest byte code
(setq load-prefer-newer t)
(load (expand-file-name "synthmacs/synthmacs-init.el"
                        (file-name-directory load-file-name)))