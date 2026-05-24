;;; my-completion.el --- Completion & minibuffer -*- lexical-binding: t; -*-

;;; Commentary:
;; Completion & minibuffer.

;;; Code:

(use-package company
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 0)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package ivy
  :demand t
  :bind
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :diminish
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  (enable-recursive-minibuffers t)
  :config
  (ivy-mode 1))

(use-package counsel
  :after ivy
  :demand t
  :diminish
  :config
  (counsel-mode 1))


(use-package ivy-rich
  :after ivy
  :demand t
  :custom
  (ivy-virtual-abbreviate 'full)
  (ivy-rich-switch-buffer-align-virtual-buffer t)
  (ivy-rich-path-style 'abbrev)
  :config
  (ivy-rich-mode 1))

(use-package all-the-icons-ivy-rich
  :after ivy-rich
  :demand t
  :config
  (all-the-icons-ivy-rich-mode 1))

(provide 'my-completion)
;;; my-completion.el ends here
