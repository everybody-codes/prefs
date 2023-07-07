;; ------------------ General Settings ---------------------
(setq inhibit-startup-message t)

;; Always edit symlinked files under VC
(setq vc-follow-symlinks t)

(setq make-backup-files nil)

;; ------------------ Basic UI Settings ---------------------
(scroll-bar-mode -1)    ; Disable
(tool-bar-mode -1)      ; Disable the toolbar    
(tooltip-mode -1)       ; Disable tooltips       
(set-fringe-mode 10)    ; Give some breathing room    
(menu-bar-mode -1)      ; Disable the menubar

;; ------------------ Line Numbering ---------------------
;; set type of line numbering (global variable)
(setq display-line-numbers-type 'relative) 

;; activate line numbering in all buffers/modes
(global-display-line-numbers-mode 1) 

(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Activate line numbering in programming modes
;; (add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Columns number in the modeline
(column-number-mode)

;; ------------------ Indent Behaviours ---------------------
;; Electric indent mode messes up with a bunch of languages indenting.
;; So disable it.
(setq electric-indent-inhibit t)


(global-visual-line-mode t)

;; ------------------ Fonts ---------------------
(set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 140)

;; ------------------ Recent Files ---------------------
(recentf-mode 1)
(setq recentf-max-menu-items 10)
(setq recentf-max-saved-items 10)

(provide 'synthmacs-general-settings)