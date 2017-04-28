;;;     PACKAGE ORGANIZING     ;;;

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/package/")
      package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
      package-archives )
;; line & column numbers
(add-hook 'prog-mode-hook 'linum-mode)
(setq column-number-mode t)
;; associate .cu files with c++ mode
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))
;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
    ;; c++ tabs
    (setq-default c-basic-offset 4)



;;;     EVIL MODE     ;;;
(add-to-list 'load-path "~/.emacs.d/elpa/evil-20150304.49")
(require 'evil)
(evil-mode 1)

;; jk instead of esc for evil mode
(add-to-list 'load-path "~/.emacs.d/elpa/key-chord-20140929.2246")
(require 'key-chord)
(key-chord-mode 1)
(setq key-chord-two-key-delay 0.3)
(key-chord-define evil-insert-state-map "kj" 'evil-normal-state)


;; emacs key bindings 
(define-key evil-normal-state-map (kbd "C-f") ctl-x-map)
(define-key evil-insert-state-map (kbd "C-f") ctl-x-map)
(define-key evil-normal-state-map (kbd "SPC") 'evil-scroll-line-to-center)
(define-key evil-normal-state-map (kbd "m")   'scroll-up-command)
(define-key evil-normal-state-map (kbd "M")   'scroll-down-command)


;;;     COLOR THEME     ;;;
(add-to-list 'load-path "~/.emacs.d/elpa/color-theme-20080305.34")
(require 'color-theme)
   (color-theme-initialize)
   ; molokai theme
   (load "~/.emacs.d/packages/color-themes/color-theme-molokai.el")
   (color-theme-molokai)


;;;     OS SPECIFIC    ;;;
(if (eq system-type 'windows-nt)
    (progn
      ;; start maximized 
      (add-to-list 'default-frame-alist '(fullscreen . maximized)) )

)
(if (eq system-type 'darwin)
   (progn 
      ;; shell toggle
      (add-to-list 'load-path "~/.emacs.d/packages/shell-toggle")
      (autoload 'shell-toggle "shell-toggle" t)
      (autoload 'shell-toggle-cd "shell-toggle-cd" t) 
      (define-key evil-normal-state-map (kbd "C-j") 'shell-toggle)
      (define-key evil-insert-state-map (kbd "C-j") 'shell-toggle)

      ;; start maximized
      (defun toggle-fullscreen ()
	      "Toggle full screen"
	      (interactive)
	      (set-frame-parameter
	          nil 'fullscreen
	          (when (not (frame-parameter nil 'fullscreen)) 'fullboth)) )

      (toggle-fullscreen)
      (menu-bar-mode -1)
      (tool-bar-mode -1) )

)

(if (eq system-type 'gnu/linux)
    (progn
      ;; shell toggle
      (add-to-list 'load-path "~/.emacs.d/packages/shell-toggle")
      (autoload 'shell-toggle "shell-toggle" t)
      (autoload 'shell-toggle-cd "shell-toggle-cd" t) 
      (define-key evil-normal-state-map (kbd "C-j") 'shell-toggle)
      (define-key evil-insert-state-map (kbd "C-j") 'shell-toggle)

      ;; start maximized
      (add-to-list 'default-frame-alist '(fullscreen . maximized))

      ;; hide toolbar, menu bar, and scroll bar
      (menu-bar-mode -1)
      (toggle-scroll-bar -1)
      (tool-bar-mode -1) )

)
