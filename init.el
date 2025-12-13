;; Emacs Init File
;; Last Update: 2025-12-11
;; Pablo Enoc

;; Set Window Size on Launch
(setq default-frame-alist '((width . 124) (height . 50)))

;; Option Key lets me write in Spanish on macOS
(setq mac-option-modifier nil)

;; Text Rendering
(set-face-attribute 'default nil :family "Menlo" :height 140)
(setq-default line-spacing 0.25)

;; Theme
(setq leuven-scale-outline-headlines nil)
(setq leuven-scale-org-document-title nil)
(setq leuven-dark-scale-outline-headlines nil)
(setq leuven-dark-scale-org-document-title nil)

;; dark theme after 7:00pm
(if (>= (string-to-number (format-time-string "%H")) 19)
    (load-theme 'leuven-dark t)
  (load-theme 'leuven t))

;; Disable Splash Screen
(setq inhibit-startup-message t)

;; Hide Toolbar
(tool-bar-mode -1)

;; Display Time in Mode Line
(display-time-mode 1)

;; Hide details in Dired mode
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

;; Vertico
(vertico-mode 1)

;; Line numbers
(add-hook 'ruby-mode-hook
	  (lambda ()
	    (display-line-numbers-mode 1)))


;; Custom Functions

(defun enocc/iso-date-insert ()
  "inserts current date in YYYY-MM-DD format"
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun enocc/center-document ()
  "centers document with equal block margin"
  (interactive)
  (setq visual-fill-column-width 80
	visual-fill-column-center-text t)
  (visual-line-mode 1)
  (visual-fill-column-mode 1))

;; Apply enocc-center-document function
;; to Org Mode and Markdown Mode for prose writing

(add-hook 'markdown-mode-hook #'enocc/center-document)
(add-hook 'org-mode-hook #'enocc/center-document)


;; Configs

;; eww

(add-hook 'eww-mode-hook
	  (lambda ()
	    (setq shr-width 60)
	    (setq left-margin-width 12)))

    

;; Elfeed

(setq elfeed-feeds
      '("https://thatalexguy.dev/feed.xml"
	"https://nullprogram.com/feed/"
	"https://halloumithoughts.bearblog.dev/feed/"
	"https://ploum.net/atom.xml"
	"https://protesilaos.com/master.xml"
	"https://lettrss.com/feed.xml"
	"https://thejollyteapot.com/feed.rss"))

(setq browse-url-browser-function #'eww-browse-url)

(add-hook 'elfeed-search-mode-hook
	  (lambda()
	    (setq elfeed-search-filter "@1-month-ago +unread")
	    (setq elfeed-search-date-format '("%b %d" 10 :left))
	    (display-line-numbers-mode -1)
	    (elfeed-search-update :force)))

(add-hook 'elfeed-show-mode-hook
	  (lambda ()
	    (setq shr-width 60)
	    (display-line-numbers-mode -1)
	    (variable-pitch-mode 1)
	    (setq left-margin-width 4)
	    (setq line-spacing 0.3)
	    (set-face-attribute 'variable-pitch (selected-frame)
				:family "Arial"
				:height 140)))

;; Test to display Help buffer below current buffer
;; Reference from Prot: https://youtu.be/1-UIzYPn38s?si=TeMSeXCPk2tJM3hP

(add-to-list 'display-buffer-alist
             '("\\*Help\\*"
               (display-buffer-in-side-window)
               (side . bottom)
               (slot . 0)
               (window-height . 0.5)))



