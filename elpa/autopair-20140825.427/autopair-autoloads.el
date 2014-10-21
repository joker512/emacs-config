;;; autopair-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (autopair-global-mode autopair-mode) "autopair"
;;;;;;  "autopair.el" (21541 26199))
;;; Generated autoloads from autopair.el

(autoload 'autopair-mode "autopair" "\
Automagically pair braces and quotes like in TextMate.

\(fn &optional ARG)" t nil)

(defvar autopair-global-mode nil "\
Non-nil if Autopair-Global mode is enabled.
See the command `autopair-global-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `autopair-global-mode'.")

(custom-autoload 'autopair-global-mode "autopair" nil)

(autoload 'autopair-global-mode "autopair" "\
Toggle Autopair mode in every possible buffer.
With prefix ARG, turn Autopair-Global mode on if and only if
ARG is positive.
Autopair mode is enabled in all buffers where
`autopair-on' would do it.
See `autopair-mode' for more information on Autopair mode.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("autopair-pkg.el") (21541 26199 620839))

;;;***

(provide 'autopair-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; autopair-autoloads.el ends here
