(global-unset-key (kbd "C-SPC")) ; Inibe Ctrl-Z (suspend frame)
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))) ; define dashboard como pagina inicial
(require 'package)
(package-initialize)


(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(use-package evil
  :ensure t
  :init (setq evil-want-C-i-jump nil)
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

;; TESTANDO A CONFIG DO TREEMACS ;;
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))
;; TESTANDO A CONFIG DO TREEMACS ;;

;;(use-package treemacs
;;  :ensure t
;;  :bind
;;  (:map global-map
;;        ("M-0"       . treemacs-select-window)
;;        ("C-x t 1"   . treemacs-delete-other-windows)
;;        ("C-x t t"   . treemacs)
;;        ("C-x t d"   . treemacs-select-directory)
;;        ("C-x t B"   . treemacs-bookmark)
;;        ("C-x t C-t" . treemacs-find-file)
;;        ("C-x t M-t" . treemacs-find-tag)))
;;
;;(use-package treemacs-evil
;;  :ensure t)

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
  (company-keymap--unbind-quick-access company-active-map)
  (company-tng-configure-default)
  (add-hook 'sh-mode-hook 'company-mode)
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
  :ensure t
  :config
  (add-hook 'sh-mode-hook 'flycheck-mode))

;; Minha Config

(use-package haskell-mode
  :ensure t
  :hook ((haskell-mode . lsp-deferred)
	 (haskell-mode . company-mode)))

(use-package org
  :ensure t
  :config
  (setq org-startup-indented t))

(use-package magit
  :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

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
