(setq package-enable-at-startup nil)
;; Make new frames undecorated (no titlebar) and start maximized.
(add-to-list 'default-frame-alist '(undecorated . t))
(add-to-list 'initial-frame-alist '(undecorated . t))

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
