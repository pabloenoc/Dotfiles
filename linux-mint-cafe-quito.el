;; Hello, Linux Mint

;; Mac-style Command shortcuts
(global-set-key (kbd "s-a") #'mark-whole-buffer)
(global-set-key (kbd "s-c") #'kill-ring-save)      ; copy
(global-set-key (kbd "s-x") #'kill-region)         ; cut
(global-set-key (kbd "s-v") #'yank)                ; paste
(global-set-key (kbd "s-z") #'undo)
(global-set-key (kbd "s-Z") #'undo-redo)           ; Cmd-Shift-Z redo
(global-set-key (kbd "s-s") #'save-buffer)
(global-set-key (kbd "s-f") #'isearch-forward)
(global-set-key (kbd "s-w") #'kill-current-buffer)
(global-set-key (kbd "s-q") #'save-buffers-kill-terminal)

;; Set window size on launch
;; Dedicated custom.el file 
;; found in Reddit, thanks /u/GoldUTop
;; https://www.reddit.com/r/emacs/comments/9rrhy8/comment/e8j58jb/

;; custom-file is a variable defined in `cus-edit.el'
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; Set Window Size on Launch
(setq default-frame-alist '((width . 122) (height . 40)))

;; FONTS
;;(set-face-attribute 'default nil :family "Menlo" :height 150)
;;(set-face-attribute 'default nil :family "Ubuntu Mono" :height 170)
(set-face-attribute 'default nil :family "Maple Mono" :height 120)
(setq-default line-spacing 0.2)

;; MELPA
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; CUSTOM PACKAGES
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/rellyk")
;; (require 'rellyk)
;; (setq rellyk-blog-root "~/Desktop/enocc.com")

;; INSTALLED PACKAGES
;; See with M-x list-packages then / s (filter by: installed)

;; completion-at-point will fire with M-TAB

;; Bring in my terminal (required installing package exec-path-from-shell)
;; Save backups to a dedicated backups dir
(setq backup-directory-alist
      '(("." . "~/.emacs.d/backups")))

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))

(exec-path-from-shell-initialize)
(load-theme 'ef-kassio t)
(vertico-mode 1)
(display-time-mode 1)
(tool-bar-mode 0)
(yas-global-mode 1) ;; i should use more snippets!
(scroll-bar-mode 0)
(global-auto-revert-mode 1) ;; Auto-revert (update) buffers if change on disk
(delete-selection-mode 1) ;; Delete text when pasting
(setq-default require-final-newline t) ;; bit me in the ass for the rellyk new link function




;; File-based mode inits
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb?\\'" . web-mode))

;; Hooks
(add-hook 'dired-mode-hook #'dired-hide-details-mode)
(add-hook 'org-mode-hook #'olivetti-mode)
(add-hook 'markdown-mode-hook #'olivetti-mode)
(add-hook 'elfeed-show-mode-hook #'olivetti-mode)

(add-hook 'web-mode-hook
	  (lambda ()
	    (display-line-numbers-mode 1)
	    (yas-minor-mode)
	    (emmet-mode 1)
	    (prettier-mode 1)
	    (setq web-mode-markup-indent-offset 2)
	    (setq web-mode-css-indent-offset 2)
	    (define-key emmet-mode-keymap (kbd "TAB") 'emmet-expand-line)))


;; Custom Functions

(defun insert-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun insert-datetime ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M")))

(defun rae-lookup ()
  (interactive)
  (browse-url
   (concat "https://dle.rae.es/"
	   (word-at-point))))

(defun powRSS-search (query)
  (interactive "sSearch powRSS: ")
  (browse-url
   (concat "https://powrss.com/search?q="
	   query "&date_range=any")))

(defun google-search (query)
  (interactive "sSearch Google: ")
  (browse-url
   (concat "https://www.google.com/search?q="
	   (url-hexify-string query))))

;; (defun enocc/toggle-font-family ()
;;   "Cycle the default face through mono, sans, and serif families."
;;   (interactive)
;;   (let* ((families '(("Maple Mono" . 170)
;;                       ("Helvetica Neue" . 170)
;;                       ("Caecilia LT Pro" . 180)))
;;          (idx (mod (1+ (or (get 'enocc/toggle-font-family 'idx) -1))
;;                    (length families)))
;;          (pair (nth idx families)))
;;     (put 'enocc/toggle-font-family 'idx idx)
;;     (set-face-attribute 'default nil :family (car pair) :height (cdr pair))
;;     (message "Font set to %s" (car pair))))
