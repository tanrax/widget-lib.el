
(defun widget-lib-separator (&optional separator)
  (let* ((sep (or separator ?_))
	 (length (window-max-chars-per-line))
	 (line (make-string length sep)))    
    (insert line)))
