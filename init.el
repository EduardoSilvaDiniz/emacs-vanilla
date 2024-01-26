(global-unset-key (kbd "C-SPC")) ; Inibe Ctrl-Z (suspend frame)
(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(use-package evil
  :ensure t
  :config
  (evil-mode)
  (evil-set-undo-system 'undo-redo))

(use-package rainbow-mode
  :ensure t)

(use-package vertico 
  :ensure t
  :config
  (vertico-mode))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless)))

(use-package treemacs
  :ensure t)

(use-package treemacs-evil
  :ensure t)

(use-package winum
  :ensure t
  :config
  (global-set-key (kbd "M-0") 'treemacs-select-window)
  (global-set-key (kbd "M-1") 'winum-select-window-1)
  (global-set-key (kbd "M-2") 'winum-select-window-2)
  (global-set-key (kbd "M-3") 'winum-select-window-3)
  (global-set-key (kbd "M-4") 'winum-select-window-4)
  (global-set-key (kbd "M-5") 'winum-select-window-5)
  (global-set-key (kbd "M-6") 'winum-select-window-6)
  (global-set-key (kbd "M-7") 'winum-select-window-7)
  (global-set-key (kbd "M-8") 'winum-select-window-8)
  (winum-mode))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package lsp-mode
  :ensure t
  :bind (:map lsp-mode-map
	      ("C-c d" . lsp-decribe-thing-at-point)
	      ("C-c a" . lsp-execute-code-action))
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (lsp-enable-which-key-integration t))

(use-package company
  :ensure t
  :hook ((emacs-lisp-mode . (lambda ()
			      (setq-local company-backends '(company-elisp))))
	 (emacs-lisp-mode . company-mode))
  :config
  (global-set-key (kbd "C-SPC") 'company-auto-complete)
  (company-keymap--unbind-quick-access company-active-map)
  (company-tng-configure-default)
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1))

(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
	 (go-mdoe . company-mode))
  :bind (:map go-mode-map
	      ("<f6>" . gofmt)
	      ("C-c 6" . gofmt))
  :config
  (require 'lsp-go)
  (setq lsp-go-analyses
	'((fieldalignment . t)
	  (nilness        . t)
	  (unusedwrite    . t)
	  (unusedparams   . t)))
  ;; GOPATH/bin
  (add-to-list 'exec-path "goimports"))

(use-package flycheck
  :ensure t)

(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-dark-medium t))

(use-package lsp-java
  :ensure t
  :config (add-hook 'java-mode-hook 'lsp))

(use-package yasnippet
  :ensure t
  :config (yas-global-mode))

(global-set-key (kbd "<f5>") #'recompile)
(setq custom-file "~/.config/emacs/custom.el")
(load custom-file t)

;; Não funciona 
;;(setq auto-save-file-name-transforms
;;      '(("." "~/.config/emacs/auto-save-list/" t))
;;      backup-directory-alist
;;      '(("." . "~/.config/emacs/backups")))

; Organizando os backups
(setq backup-directory-alist `(("." . "~/.saves")))


;;(set-face-attribute 'region nil :background "deep sky blue")
(set-face-attribute 'default nil :height 140)
;; Configuração básica do Emacs
(setq inhibit-startup-message t)     ; Adeus, buffer assustador!

(tool-bar-mode   -1)                 ; Oculta a barra de ferramentas
(menu-bar-mode   -1)                 ; Oculta a barra de menu
(scroll-bar-mode -1)                 ; Oculta a barra de rolagem
(tooltip-mode    -1)                 ; Oculta dicas

(global-display-line-numbers-mode t) ; Exibe numeração de linhas
(column-number-mode t)               ; Exibe coluna atual na modeline
(global-hl-line-mode t)              ; Exibe destaque de linha

;; Alertas visuais
(setq visible-bell t)

;; Espaçamento das bordas laterais
(set-fringe-mode 10)

;; Ajustes para a minha sanidade mental
(global-unset-key (kbd "C-z")) ; Inibe Ctrl-Z (suspend frame)
(delete-selection-mode t)      ; O texto digitado substitui a seleção

;; Rolagem mais suave
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1)) ; 2 linhas por vez
      mouse-wheel-progressive-speed nil            ; Não acelera a rolagem
      mouse-wheel-follow-mouse 't                  ; Rola a janela sob o mouse
      scroll-step 1)                               ; Rola 1 linha com teclado

;; Quebras de linha
(global-visual-line-mode t)

;; META -> space
(global-unset-key (kbd "M-SPC"))
(global-set-key (kbd "M-SPC n") #'suspend-frame)

;; Instalação do auto-update
(use-package auto-package-update
  :ensure t
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "21:00"))
(custom-set-variables
 '(ispell-dictionary "brasileiro")
 '(package-selected-packages
   '(company flycheck lsp-mode auto-package-update use-package cmake-mode)))
(custom-set-faces)

;; Tipo de cursor (box, bar ou hbar)
(setq-default cursor-type 'box)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(vertico use-package rainbow-mode evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
