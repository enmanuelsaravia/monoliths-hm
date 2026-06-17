;; Add this on your init file
(defun erc-update-mode-line () "Only remove mode-line erc notifications")
;; for hotplug modification disable
(defun my/erc-update-mode-line-disable ()
  "To disable mode line erc notifications"
  (interactive)
  (defun erc-update-mode-line () "Only remove mode-line erc notifications"))
;; for hotplug modification enable
(defun my/erc-update-mode-line-enable ()
  "To disable mode line erc notifications"
  (interactive)
  (defun erc-update-mode-line (&optional buffer)
    "Update the mode line in BUFFER.

If BUFFER is nil, update the mode line in all ERC buffers."
    (if (and buffer (bufferp buffer))
	(erc-update-mode-line-buffer buffer)
      (dolist (buf (erc-buffer-list))
	(when (buffer-live-p buf)
          (erc-update-mode-line-buffer buf))))))