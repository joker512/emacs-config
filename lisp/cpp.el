(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's asynchronous function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async)
  (irony-eldoc))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)

;; (setq irony-libclang-additional-flags
;;       (append '("-I" "include") irony-libclang-additional-flags))

(global-set-key (kbd "M-/") 'completion-at-point)

(require 'yasnippet)
(yas-reload-all)

(defun dts-switch-between-header-and-source ()
  "Switch between a c/c++ header (.h) and its corresponding source (.c/.cpp)."
  (interactive)
  (setq bse (file-name-sans-extension buffer-file-name))
  (setq ext (downcase (file-name-extension buffer-file-name)))
  (cond
   ((or (equal ext "hpp") (equal ext "h"))
    (setq nfn (concat bse ".c"))
    (if (file-exists-p nfn)
        (find-file nfn)
      (progn
        (setq nfn (concat bse ".cpp"))
        (find-file nfn)
        )
      )
    )
   ((or (equal ext "cpp") (equal ext "c"))
    (setq nfn (concat bse ".h"))
    (if (file-exists-p nfn)
        (find-file nfn)
      (progn
        (setq nfn (concat bse ".hpp"))
        (find-file nfn)
        )
      )
    )
   )
  )
(global-set-key (kbd "C-c h") 'dts-switch-between-header-and-source)

(global-set-key  [f1] (lambda () (interactive) (manual-entry (buffer-substring (mark) (point)))))

(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(defun c-predefines ()
	 (local-unset-key (kbd "M-j"))
	 (local-set-key (kbd "C-.") 'company-complete)
	 (company-mode t)
	 (auto-complete-mode nil))

(add-hook 'c-mode-hook 'c-predefines)
(add-hook 'c++-mode-hook 'c-predefines)

(global-set-key (kbd "C-c c") (lambda () (interactive) (save-buffer) (compile "make")))
(global-set-key (kbd "M-g f") 'ctags-search)
(global-set-key (kbd "M-g M-f") 'ctags-search)
(global-set-key (kbd "M-i") 'imenu)

(require 'ctags)

(provide 'cpp)
