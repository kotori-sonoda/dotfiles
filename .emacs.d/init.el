(setq load-path (append
		 '("~/.emacs.d"
		   "~/.emacs.d/packages")
		 load-path))

(set-locale-environment nil)

(auto-image-file-mode t)

;; hide menubar and toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; display column and line number
(column-number-mode t)
(line-number-mode t)

(setq require-final-newline t)

;; backup settings
(setq backup-inhibited t)
(setq delete-auto-save-files t)

;; completion settings
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; histroy settings
(setq history-length 10000)
(savehist-mode 1)
(setq recentf-max-saved-items 10000)

;; edit .gz
(auto-compression-mode t)

;; diff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq diff-switches '("-u" "-p" "-N"))

;; dired
(require 'dired-x)
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(require 'lcomp)
(lcomp-install)

(require 'ibuffer)
(global-set-key "\C-x\C-b" 'ibuffer)

(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/packages")
(auto-install-update-emacswiki-package-name t)

(auto-install-from-url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el")
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(setq package-user-dir (concat user-emacs-directory "packages"))
(package-initialize)

(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/packages/auto-complete-1.4/dict")
(require 'auto-complete-config)
(ac-config-default)
(add-hook 'auto-complete-mode-hook
	  (lambda()
	    (define-key ac-completing-map (kbd "C-n") 'ac-next)
	    (define-key ac-completing-map (kbd "C-p") 'ac-previous)))

(defun dired-vc-status (&rest args)
  (interactive)
  (cond ((file-exists-p (concat (dired-current-directory) ".svn"))
	 (svn-status (dired-current-directory)))
	((file-exists-p (concat (dired-current-directory) ".git"))
	 (magit-status (dired-current-directory)))
	(t
	 (message "version controlled?"))))
(define-key dired-mode-map "V" 'dired-vc-status)
