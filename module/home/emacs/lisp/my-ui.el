;;; my-ui.el --- UI tweaks -*- lexical-binding: t; -*-

;;; Commentary:
;; UI tweaks.

;;; Code:

(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(use-package nerd-icons
  :if (display-graphic-p))

(use-package dashboard
  :config
  (setq dashboard-projects-backend 'projectile)
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (setq dashboard-items '((recents   . 10)
                          (projects  . 10)))
  (dashboard-setup-startup-hook))

(use-package diminish)

(setq ring-bell-function #'ignore)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(column-number-mode t)
(setq mode-line-position '("Line %l Column %c " (-3 "%p")))

(electric-pair-mode 1)

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(use-package doom-themes
  :demand t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  (doom-themes-treemacs-theme "doom-atom")
  :config
  (load-theme 'doom-dark+ t)

  (require 'doom-themes-ext-visual-bell nil t)
  (when (fboundp 'doom-themes-visual-bell-config)
    (doom-themes-visual-bell-config))

  (when (fboundp 'doom-themes-neotree-config)
    (doom-themes-neotree-config))
  (when (fboundp 'doom-themes-treemacs-config)
    (doom-themes-treemacs-config))
  (when (fboundp 'doom-themes-org-config)
    (doom-themes-org-config)))

(use-package which-key
  :init
  (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
        which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.8
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit t
        which-key-separator " → "))

(provide 'my-ui)
;;; my-ui.el ends here
