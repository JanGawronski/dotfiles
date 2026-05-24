;;; my-project.el --- Project & navigation -*- lexical-binding: t; -*-

;;; Commentary:
;; Project & navigation.

;;; Code:

(use-package projectile
  :config
  (projectile-mode 1))

(use-package neotree
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 30
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action)
  (add-hook 'neo-after-create-hook
            #'(lambda (_)
                (with-current-buffer (get-buffer neo-buffer-name)
                  (setq truncate-lines t)
                  (setq word-wrap nil)
                  (make-local-variable 'auto-hscroll-mode)
                  (setq auto-hscroll-mode nil)
                  (display-line-numbers-mode 0)))))

(provide 'my-project)
;;; my-project.el ends here
