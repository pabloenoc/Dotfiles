;; Emacs Init File
;; Last Update: 2025-12-09
;; Pablo Enoc

;; Set Window Size on Launch
(setq default-frame-alist '((width . 124) (height . 50)))

;; Option Key lets me write in Spanish on macOS
(setq mac-option-modifier nil)

;; Font Family - Menlo 14pt - Line Spacing 0.25
(set-face-attribute 'default nil :family "Menlo" :height 140)
(setq-default line-spacing 0.25)

;; Theme: Somnus
(load-theme 'somnus t)

;; Disable Splash Screen
(setq inhibit-startup-message t)

;; Hide Toolbar
(tool-bar-mode -1)

;; Display Time in Mode Line
(display-time-mode 1)

;; Hide details in Dired mode
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

;; Custom Functions

(defun enocc-iso-date-insert ()
  "inserts current date in YYYY-MM-DD format"
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun enocc-center-document ()
  "centers document with equal block margin"
  (interactive)
  (setq visual-fill-column-width 80
	visual-fill-column-center-text t)
  (visual-line-mode 1)
  (visual-fill-column-mode 1))

;; Apply enocc-center-document function
;; to Org Mode and Markdown Mode for prose writing

(add-hook 'markdown-mode-hook #'enocc-center-document)
(add-hook 'org-mode-hook #'enocc-center-document)


