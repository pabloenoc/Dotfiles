;; Emacs Init File
;; Last Update: 2025-02-20
;; Pablo Enoc

;; Bring in my terminal
(exec-path-from-shell-initialize)

;; MELPA
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

;; Set Window Size on Launch
(setq default-frame-alist '((width . 142) (height . 46)))

;; Option Key lets me write in Spanish on macOS
(setq mac-option-modifier nil)

;; Text Rendering
(set-face-attribute 'default nil :family "Menlo" :height 140)
(setq-default line-spacing 0.25)

;; Scrollbar Disabled
(scroll-bar-mode -1)

;; Theme
;; (load-theme 'ef-deuteranopia-dark t)
;; (load-theme 'ef-night t)
(load-theme 'ef-light t)

;; Disable Splash Screen
(setq inhibit-startup-message t)

;; Hide Toolbar
(tool-bar-mode -1)

;; Display Time in Mode Line
(display-time-mode 1)

;; Vertico
(vertico-mode 1)

;; Set 12-hr clock in Org Agenda
(setq org-agenda-timegrid-use-ampm 1)

;; Save backups to a dedicated backups dir
(setq backup-directory-alist
      '(("." . "~/.emacs.d/backups")))

;; Custom Functions

(defun enocc/ddg-lookup ()
  "Searches selected text or word in DuckDuckGo with eww browser"
  (interactive)
  (let ((search-term 
         (if (use-region-p)
             (buffer-substring-no-properties (region-beginning) (region-end))
           (thing-at-point 'word t))))
    (when search-term
      (browse-url 
       (concat "https://lite.duckduckgo.com/lite/?q=" 
               (url-hexify-string (string-trim search-term)))))))

(defun enocc/rae-lookup ()
  (interactive)
  (browse-url
   (concat "https://dle.rae.es/"
	   (thing-at-point 'word t))))

(defun enocc/iso-date-insert ()
  "inserts current date in YYYY-MM-DD format"
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun enocc/center-writing-document ()
  "centers document with equal block margin for writing"
  (setq-local visual-fill-column-width 80
	visual-fill-column-center-text t)
  (visual-line-mode 1)
  (visual-fill-column-mode 1))

(defun enocc/center-reading-document ()
  "centers document with equal block margin for reading"
  (interactive)
  (setq-local visual-fill-column-width 80
	visual-fill-column-center-text t
	shr-width nil)
  (visual-line-mode 1)
  (visual-fill-column-mode 1))

(defun enocc/set-reading-font ()
  "Customizations for more comfortable reading of documents"
  (variable-pitch-mode 1)
  (set-face-attribute 'variable-pitch nil
		      :family "Verdana"
		      :height 140))

(defun enocc/set-line-width (desired-width)
  "sets visual-fill-column-width value for current buffer"
  (interactive "NLine width: ")
  (setq-local visual-fill-column-width desired-width))

;; Hooks

;; Start Emacs on Agenda View
(add-hook 'emacs-startup-hook
	  (lambda()
	    (org-agenda nil "n")
	    (delete-other-windows)))

(add-hook 'dired-mode-hook #'dired-hide-details-mode)

(add-hook 'markdown-mode-hook #'enocc/center-writing-document)
(add-hook 'org-mode-hook #'enocc/center-writing-document)

(add-hook 'eww-mode-hook #'enocc/set-reading-font)
(add-hook 'eww-mode-hook #'enocc/center-reading-document)

(add-hook 'nov-mode-hook #'enocc/set-reading-font)
(add-hook 'nov-mode-hook #'enocc/center-reading-document)

(add-hook 'elfeed-search-mode-hook
	  (lambda()
	    (setq elfeed-search-filter "@1-week-ago +unread")
	    (setq elfeed-search-date-format '("%b %d" 10 :left))
	    (display-line-numbers-mode -1)
	    (elfeed-search-update :force)))

(add-hook 'elfeed-show-mode-hook #'enocc/set-reading-font)
(add-hook 'elfeed-show-mode-hook #'enocc/center-reading-document)

(add-hook 'html-mode-hook
	  (lambda ()
	    (display-line-numbers-mode 1)))

(add-hook 'css-mode-hook
	  (lambda ()
	    (display-line-numbers-mode 1)))

(add-hook 'php-mode-hook
	  (lambda ()
	    (display-line-numbers-mode 1)))

(add-hook 'web-mode-hook
	  (lambda ()
	    (display-line-numbers-mode 1)
	    (emmet-mode 1)
	    (define-key emmet-mode-keymap (kbd "TAB") 'emmet-expand-line)
	    (define-key emmet-mode-keymap (kbd "<tab>") 'emmet-expand-line)))

(add-hook 'ruby-mode-hook
	  (lambda ()
	    (display-line-numbers-mode 1)))

(add-hook 'emacs-lisp-mode-hook
	  (lambda()
	    (display-line-numbers-mode 1)))

;; Elfeed

(setq browse-url-browser-function #'eww-browse-url)

;; My Elfeed Feeds

;; (setq elfeed-feeds
;;       '(URL
;; 	URL
;; 	))


