; auto-complete
(global-set-key (kbd "C-\\") 'auto-complete)
(global-auto-complete-mode t)

; pair brackets, quotes, etc.
(autopair-global-mode)

(defun rope-after-save-actions () )

; keybindings for jedi
(add-hook 'python-mode-hook (lambda() (jedi:setup) (define-key python-mode-map (kbd "C-\\") 'jedi:complete) ) )

; python code refactoring
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport 't)

; code autocheck
;; (when (load "flymake" t)
;;  (defun flymake-pylint-init ()
;;    (let* ((temp-file (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
;;           (local-file (file-relative-name temp-file (file-name-directory buffer-file-name))))
;;          (list "pep8" (list "--repeat" local-file "--max-line-length=180"))))

;; (add-to-list 'flymake-allowed-file-name-masks '("\\.py\\'" flymake-pylint-init)))
;; (add-hook 'find-file-hook 'flymake-find-file-hook)

;; (defun my-flymake-show-help ()
;;   (when (get-char-property (point) 'flymake-overlay)
;;     (let ((help (get-char-property (point) 'help-echo)))
;;       (if help (message "%s" help)))))

;; (custom-set-faces
;;   '(flymake-errline ((((class color)) (:background "Gray"))))
;; )

;; (add-hook 'post-command-hook 'my-flymake-show-help)

; commenting
(defun comment-dwim-line (&optional arg)
    (interactive "*P")
    (comment-normalize-vars)
    (if (not (region-active-p))
        (comment-or-uncomment-region (line-beginning-position) (line-end-position))
      (comment-dwim arg)))

(global-set-key (kbd "M-;") 'comment-dwim-line)

; highlight paranthesis
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (highlight-parentheses-mode)
             (setq autopair-handle-action-fns
                   (list 'autopair-default-handle-action
                         '(lambda (action pair pos-before)
                            (hl-paren-color-update))))))

; protobuf mode
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))

; variable logging in python
(defun python-log-var ()
  (interactive)
  (copy-line)
  (move-beginning-of-line nil)
  (insert "print '")
  (move-end-of-line nil)
  (insert " = %s' % ")
  (yank))
(global-set-key (kbd "C-c v") 'python-log-var)

(provide 'init-coding)
