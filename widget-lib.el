
(defun widget-lib-separator (&optional separator)
  (let* ((sep (or separator ?_))
	 (size (window-max-chars-per-line))
	 (line (make-string size sep)))    
    (insert line)))
