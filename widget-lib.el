
(defun widget-lib-separator (&optional separator)
  (let* ((sep (or separator ?_))
	 (size (window-max-chars-per-line))
	 (line (make-string size sep)))    
    (insert line)))


;; Imports
(require 'widget)

(eval-when-compile
  (require 'wid-edit))

(defvar loading--name-buffer "*Loading*")
(defvar loading-text "Loading")
(defvar widget-label)

(defun loading--horizontal-padding ()
  "Calculate the horizontal padding for the loading text."
  (let* ((buffer-width (window-width))
	 (text-length (length loading-text))
         (horizontal-padding (/ (- buffer-width text-length) 2)))
    (make-string (max 0 horizontal-padding) ?\s)))

(defun loading--vertical-padding ()
  "Calculate the vertical padding for the loading text."
  (let* ((buffer-height (window-height))
	 (vertical-padding (/ (- buffer-height 1) 2))) ;; Subtract 1 for the mode line
    (make-string (max 0 vertical-padding) ?\n)))

(defun loading--format-text ()
  "Format the loading text with padding."
  (format "%s%s%s" (loading--vertical-padding) (loading--horizontal-padding) loading-text))

(defun main-layout ()
  "Create the main layout for the loading screen."
  (switch-to-buffer loading--name-buffer)
  (read-only-mode 1)
  (kill-all-local-variables)
  (let ((inhibit-read-only t))
    (erase-buffer))
  (remove-overlays)
  (erase-buffer)
  (widget-create 'item :value (loading--format-text))
  (use-local-map widget-keymap)
  (widget-setup)
  (display-line-numbers-mode 0))

(defun loading--show ()
  "Show the loading screen."
  (main-layout))

(defun loading--hide ()
  "Hide the loading screen."
  (interactive)
  (kill-buffer loading--name-buffer))
