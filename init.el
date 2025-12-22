;; Emacs Init File
;; Last Update: 2025-12-22
;; Pablo Enoc

;; MELPA
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

;; Set Window Size on Launch
(setq default-frame-alist '((width . 124) (height . 42)))

;; Option Key lets me write in Spanish on macOS
(setq mac-option-modifier nil)

;; Text Rendering
(set-face-attribute 'default nil :family "Menlo" :height 140)
(setq-default line-spacing 0.25)

;; Scrollbar Disabled
(scroll-bar-mode -1)

;; Theme
(load-theme 'modus-operandi-tinted t)

;; Disable Splash Screen
(setq inhibit-startup-message t)

;; Hide Toolbar
(tool-bar-mode -1)

;; Display Time in Mode Line
(display-time-mode 1)

;; Vertico
(vertico-mode 1)

;; ido
(ido-mode 1)

;; Custom Functions

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
  (setq-local visual-fill-column-width 60
	visual-fill-column-center-text t
	shr-width nil)
  (visual-line-mode 1)
  (visual-fill-column-mode 1))

(defun enocc/set-reading-font ()
  "Customizations for more comfortable reading of documents"
  (variable-pitch-mode 1)
  (set-face-attribute 'variable-pitch nil
		      :family "Verdana"
		      :height 150))


;; Hooks

(add-hook 'dired-mode-hook #'dired-hide-details-mode)

(add-hook 'markdown-mode-hook #'enocc/center-writing-document)
(add-hook 'org-mode-hook #'enocc/center-writing-document)

(add-hook 'eww-mode-hook #'enocc/set-reading-font)
(add-hook 'eww-mode-hook #'enocc/center-reading-document)

(add-hook 'nov-mode-hook #'enocc/set-reading-font)
(add-hook 'nov-mode-hook #'enocc/center-reading-document)

(add-hook 'elfeed-search-mode-hook
	  (lambda()
	    (setq elfeed-search-filter "@1-month-ago +unread")
	    (setq elfeed-search-date-format '("%b %d" 10 :left))
	    (display-line-numbers-mode -1)
	    (elfeed-search-update :force)))

(add-hook 'elfeed-show-mode-hook #'enocc/set-reading-font)
(add-hook 'elfeed-show-mode-hook #'enocc/center-reading-document)

(add-hook 'ruby-mode-hook
	  (lambda ()
	    (display-line-numbers-mode 1)))


;; Elfeed

(setq elfeed-feeds
      '("https://thatalexguy.dev/feed.xml"
	"https://nullprogram.com/feed/"
	"https://halloumithoughts.bearblog.dev/feed/"
	"https://ploum.net/atom.xml"
	"https://protesilaos.com/master.xml"
	"https://lettrss.com/feed.xml"
	"https://thejollyteapot.com/feed.rss"
	"https://winnielim.org/feed/"
	"https://xn--gckvb8fzb.com/index.xml#feed"
	))

(setq browse-url-browser-function #'eww-browse-url)

