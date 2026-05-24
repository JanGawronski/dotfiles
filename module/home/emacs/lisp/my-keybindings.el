;;; my-keybindings.el --- Keybindings -*- lexical-binding: t; -*-

;;; Commentary:
;; Keybindings.

;;; Code:

(require 'windmove)

;;;###autoload
(defun buf-move-up ()
  "Swap the current buffer and the buffer above the split.
If there is no split, ie now window above the current one, an
error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'up))
         (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No window above this one")
      (set-window-buffer (selected-window) (window-buffer other-win))
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-down ()
  "Swap the current buffer and the buffer under the split.
If there is no split, ie now window under the current one, an
error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'down))
         (buf-this-buf (window-buffer (selected-window))))
    (if (or (null other-win)
            (string-match "^ \\*Minibuf" (buffer-name (window-buffer other-win))))
        (error "No window under this one")
      (set-window-buffer (selected-window) (window-buffer other-win))
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-left ()
  "Swap the current buffer and the buffer on the left of the split.
If there is no split, ie now window on the left of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'left))
         (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No left split")
      (set-window-buffer (selected-window) (window-buffer other-win))
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-right ()
  "Swap the current buffer and the buffer on the right of the split.
If there is no split, ie now window on the right of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'right))
         (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No right split")
      (set-window-buffer (selected-window) (window-buffer other-win))
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

(eval-when-compile
  (require 'general))
(require 'general)

(defun main/window-new ()
  (interactive)
  (let ((win (split-window-sensibly)))
    (when (windowp win)
      (select-window win)
      (balance-windows))))

(defun main/window-split-below ()
  (interactive)
  (select-window (split-window-below))
  (balance-windows))

(defun main/window-split-right ()
  (interactive)
  (select-window (split-window-right))
  (balance-windows))

(general-create-definer main/leader-keys
  :keymaps 'override
  :prefix "M-SPC"
  :global-prefix "M-SPC")

(main/leader-keys
  "SPC" '(counsel-M-x :wk "Counsel M-x")
  "." '(counsel-find-file :wk "Find file")
  "f c" '((lambda ()
            (interactive)
            (find-file (expand-file-name "init.el" user-emacs-directory)))
           :wk "Edit emacs config")
  "f r" '(counsel-recentf :wk "Find recent files"))

(main/leader-keys
  "b" '(:ignore t :wk "buffer")
  "b b" '(switch-to-buffer :wk "Switch buffer")
  "b i" '(ibuffer :wk "IBuffer")
  "b k" '(kill-buffer-and-window :wk "Kill this buffer")
  "b n" '(next-buffer :wk "Next buffer")
  "b p" '(previous-buffer :wk "Previous buffer")
  "b r" '(revert-buffer :wk "Reload buffer"))

(main/leader-keys
  "h" '(:ignore t :wk "Help")
  "h f" '(describe-function :wk "Describe function")
  "h v" '(describe-variable :wk "Describe variable"))

(main/leader-keys
  "`" '(vterm-toggle :wk "Toggle vterm")
  "TAB" '(neotree-toggle :wk "Toggle neotree file viewer"))

(main/leader-keys
  "w" '(:ignore t :wk "Windows")
  "w c" '(delete-window :wk "Close window")
  "w n" '(main/window-new :wk "New window")
  "w s" '(main/window-split-below :wk "Horizontal split window")
  "w v" '(main/window-split-right :wk "Vertical split window")
  "w h" '(windmove-left :wk "Window left")
  "w j" '(windmove-down :wk "Window down")
  "w k" '(windmove-up :wk "Window up")
  "w l" '(windmove-right :wk "Window right")
  "w w" '(other-window :wk "Goto next window")
  "w H" '(buf-move-left :wk "Buffer move left")
  "w J" '(buf-move-down :wk "Buffer move down")
  "w K" '(buf-move-up :wk "Buffer move up")
  "w L" '(buf-move-right :wk "Buffer move right"))

(main/leader-keys
  "a" '(:ignore t :wk "Code actions")
  "a l" '(lsp-execute-code-action :wk "Apply hint / code action")
  "a d" '(lsp-describe-thing-at-point :wk "Describe thing at cursor")
  "a c" '(my/compile-file :wk "Compile and run file")
  "a C" '(my/compile-project :wk "Compile and run project")
  "a r" '(my/run-file :wk "Run file")
  "a R" '(my/run-project :wk "Run project"))

(main/leader-keys
  "g" '(:ignore t :wk "Git")
  "g s" '(magit-status :wk "Git status")
  "g c" '(magit-commit-create :wk "Git commit")
  "g p" '(magit-push-implicitly :wk "Git push"))

(main/leader-keys
  "c" '(:ignore t :wk "Multiple cursors")
  "c n" '(mc/mark-next-like-this :wk "Next like selected")
  "c a" '(mc/mark-all-like-this :wk "All like selected")
  "c u" '(mc/keyboard-quit :wk "Remove all additional cursors"))

(provide 'my-keybindings)
;;; my-keybindings.el ends here
