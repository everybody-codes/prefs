;; [[file:../synthmacs.org::*Themes][Themes:1]]
(use-package doom-themes
  :config
  ;; Global settings (defaults)


  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled


  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)

  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package afternoon-theme)
(use-package alect-themes)
(use-package ample-theme)
(use-package ample-zen-theme)
(use-package badwolf-theme)
(use-package catppuccin-theme)
(use-package clues-theme)
(use-package color-theme-sanityinc-solarized)
(use-package color-theme-sanityinc-tomorrow)
(use-package cyberpunk-theme)
(use-package darktooth-theme)
(use-package flatland-theme)
(use-package gruvbox-theme)
(use-package jazz-theme)
(use-package kaolin-themes)
(use-package material-theme)
(use-package modus-themes)
(use-package monokai-theme)
(use-package seti-theme)
(use-package soothe-theme)
(use-package subatomic-theme)
(use-package sublime-themes)

(use-package solaire-mode
  :init
  (solaire-global-mode +1))


;;; Functions:
(defvar synthmacs--fallback-theme 'kaolin-bubblegum
  "Fallback theme if user theme cannot be applied.")

(defvar synthmacs--cur-theme nil
  "Internal variable storing currently loaded theme.")

(defvar synthmacs--user-themes '(kaolin-bubblegum
				 doom-challenger-deep
				 cyberpunk
				 jazz
				 afternoon
				 ample-zen
				 doom-1337
				 catppuccin
				 manoj-dark
				 doom-snazzy
				 kaolin-dark
				 doom-gruvbox
				 doom-old-hope
				 kaolin-aurora
				 doom-acario-dark
				 gruvbox-dark-hard
				 modus-vivendi
				 alect-black
				 modus-operandi
				 gruvbox-light-hard))

(defun synthmacs/load-theme (&optional theme)
  "Apply user theme."
  (if theme
      (progn
	(load-theme theme t)
	(setq-default synthmacs--cur-theme theme))
    (progn
      (load-theme synthmacs--fallback-theme t)
      (setq-default spacemacs--cur-theme synthmacs--fallback-theme))))

(defun synthmacs/load-random-theme ()
  (interactive)
  (let* ((size (length synthmacs--user-themes))
         (index (random size))
         (randomTheme (nth index synthmacs--user-themes)))
    (synthmacs/load-theme randomTheme)))

(defun synthmacs/cycle-synthmacs-theme (&optional backward)
  "Cycle through themes defined in `synthmacs-themes'.
When BACKWARD is non-nil, or with universal-argument, cycle backwards."
  (interactive "P")
  (let* (
	 ;; (theme-names (mapcar 'synthmacs--user-themes)
         (themes (if backward
		     (reverse synthmacs--user-themes)
		   synthmacs--user-themes))
         (next-theme
	  (car (or (cdr (memq synthmacs--cur-theme themes))
		   ;; if current theme isn't in cycleable themes, start
		   ;; over
		   themes))))
    (when synthmacs--cur-theme
      (disable-theme synthmacs--cur-theme))
    (let ((progress-reporter
           (make-progress-reporter
            (format "Loading theme %s..." next-theme))))
      (synthmacs/load-theme next-theme)
      (progress-reporter-done progress-reporter))))

(defun synthmacs/cycle-synthmacs-theme-backward ()
  "Cycle through themes defined in `dotsynthmacs-themes' backward."
  (interactive)
  (synthmacs/cycle-synthmacs-theme t))

(synthmacs/leader-keys
  "tt" '(:ignore t :wk "themes")
  "ttn" '(synthmacs/hydra-theme-cycle :wk "cycle-themes")
  "ttN" '(synthmacs/hydra-theme-cycle-backward :wk "cycle-themes-backwards")
  "ttr" '(synthmacs/hydra-theme-random :wk "random-theme"))

(defun synthmacs/hydra-theme-cycle ()
  (interactive)
  (synthmacs/cycle-synthmacs-theme)
  (synthmacs/hydra/cycle-themes/body))

(defun synthmacs/hydra-theme-cycle-backward ()
  (interactive)
  (synthmacs/cycle-synthmacs-theme t)
  (synthmacs/hydra/cycle-themes/body))

(defun synthmacs/hydra-theme-random ()
  (interactive)
  (synthmacs/load-random-theme)
  (synthmacs/hydra/cycle-themes/body))

(defhydra synthmacs/hydra/cycle-themes (:timeout 20)
  "
^Themes Menu
^^^^^^^^------------------------
[_n_]     cycle-theme
[_p_/_N_]   cycle-theme-backward
[_r_]     random-theme
[_q_] quit
"
  ("n" synthmacs/cycle-synthmacs-theme)
  ("p" synthmacs/cycle-synthmacs-theme-backward)
  ("N" synthmacs/cycle-synthmacs-theme-backward)
  ("r" synthmacs/load-random-theme)
  ("q" nil :exit t))

(synthmacs/load-random-theme)
;; Themes:1 ends here

;; [[file:../synthmacs.org::*Navigation][Navigation:1]]
(use-package winum
  :general
  (synthmacs/leader-keys
    "1" '(winum-select-window-1 :wk "winum-select-window-1")
    "2" '(winum-select-window-2 :wk "winum-select-window-2")
    "3" '(winum-select-window-3 :wk "winum-select-window-3")
    "4" '(winum-select-window-4 :wk "winum-select-window-4")
    "5" '(winum-select-window-5 :wk "winum-select-window-5")
    "6" '(winum-select-window-6 :wk "winum-select-window-6")
    "7" '(winum-select-window-7 :wk "winum-select-window-7")
    "8" '(winum-select-window-8 :wk "winum-select-window-8")
    "9" '(winum-select-window-9 :wk "winum-select-window-9"))
  :init
  (setq winum-auto-setup-mode-line nil
	winum-ignored-buffers '(" *which-key*"))
  (winum-mode))
;; Navigation:1 ends here

;; [[file:../synthmacs.org::*ace-window][ace-window:1]]
(use-package ace-window
  :general
  (synthmacs/leader-keys
    "wD" '(ace-delete-window :wk "ace-delete-window")
    "wS" '(ace-swap-window :wk "ace-swap-window")
    ))
;; ace-window:1 ends here

;; [[file:../synthmacs.org::*Avy][Avy:1]]
(use-package avy
  :general
  (synthmacs/leader-keys
    "jj" '(avy-goto-char-timer :wk "avy-goto-char-timer")
    "jc" '(avy-goto-char :wk "avy-goto-char")
    "jl" '(avy-goto-line :wk "avy-goto-line")
    ))
;; Avy:1 ends here

;; [[file:../synthmacs.org::*Icons][Icons:1]]
(setq nerd-icons-scale-factor 1.2)

(use-package nerd-icons
  :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  (nerd-icons-font-family "FiraCode Nerd Font"))

(use-package all-the-icons
  :if (display-graphic-p))
;; Icons:1 ends here

;; [[file:../synthmacs.org::*Modeline][Modeline:1]]
(use-package minions
  :hook (doom-modeline-mode . minions-mode))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 45
	doom-modeline-project-detection 'auto
	doom-modeline-icon t
	doom-modeline-major-mode-icon t
	doom-modeline-major-mode-color-icon t
	doom-modeline-buffer-state-icon t
	doom-modeline-buffer-modification-icon t
	doom-modeline-time-icon nil
	doom-modeline-buffer-encoding t
	doom-modeline-vcs-max-length 15
	doom-modeline-lsp t
	doom-modeline-modal-icon t))
;; Modeline:1 ends here

;; [[file:../synthmacs.org::*which-key][which-key:1]]
(setq which-key-idle-delay 0.4)
(use-package which-key
  :init
  (which-key-mode 1)
  :config
  (setq which-key-side-window-location 'bottom
	which-key-sort-order #'which-key-key-order-alpha
	;; which-key-sort-order #'which-key-prefix-then-key-order
	which-key-sort-uppercase-first nil
	which-key-add-column-padding 1
	which-key-max-display-columns nil
	which-key-min-display-lines 6
	which-key-side-window-slot -10
	which-key-side-window-max-height 0.25
	which-key-max-description-length 25
	which-key-allow-imprecise-window-fit t
	which-key-separator " → "
	which-key-prefix-prefix "+")
  ;; Rename the entry for M-1 in the SPC h k Top-level bindings,
  ;; and for 1 in the SPC- Spacemacs root, to 1..9
  (push '(("\\(.*\\)1" . "winum-select-window-1") .
	  ("\\11..9" . "select window 1..9"))
	which-key-replacement-alist)

  ;; Hide the entries for M-[2-9] in the SPC h k Top-level bindings,
  ;; and for [2-9] in the SPC- Spacemacs root
  (push '((nil . "winum-select-window-[2-9]") . t)
	which-key-replacement-alist))
;; which-key:1 ends here

;; [[file:../synthmacs.org::*rainbow][rainbow:1]]
;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
;; rainbow:1 ends here

;; [[file:../synthmacs.org::*synthmacs-ui][synthmacs-ui:1]]
(provide 'synthmacs-ui)
;;; synthmacs-ui.el ends here
;; synthmacs-ui:1 ends here