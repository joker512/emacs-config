(add-to-list 'load-path "~/.emacs.d")

; sorting directories before files in dired
(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program t)
(setq insert-directory-program "/bin/ls")
(require 'dired-sort-map)
(setq dired-listing-switches "--group-directories-first -alh")

; don't ask confirmation on delete
(setq dired-recursive-deletes 'always)

; toggle from vertical to horizon split and back
(require 'toggle-window-split)
(global-set-key (kbd "C-x |") 'toggle-window-split)

; recent files support
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

; don't show hidden files
(require 'dired-x)
(setq-default dired-omit-files-p t)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
(global-set-key (kbd "M-o") 'dired-omit-mode)

; convenient windows navigation
(global-set-key (kbd "C-x <up>") '(lambda () (interactive) (other-window -1)) )
(global-set-key (kbd "C-x <down>") 'other-window)
(global-set-key (kbd "M-S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-S-<down>") 'shrink-window)
(global-set-key (kbd "M-S-<up>") 'enlarge-window)

; convenient tail mode
(global-set-key (kbd "M-u") 'auto-revert-tail-mode)

; windows swap
(require 'buffer-move)

; different code edit features
; (load-file "~/.emacs.d/cedet-1.1/common/cedet.el")
; (global-ede-mode 1)                      ; Enable the Project management system
; (semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
; (global-srecode-minor-mode 1)            ; Enable template insertion menu

; files treeview
(require 'sr-speedbar)
;(sr-speedbar-open)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(speedbar-show-unknown-files t)
 '(sr-speedbar-right-side nil)
 '(sr-speedbar-width-console 32)
 '(sr-speedbar-width-x 32)
 '(sr-speedbar-skip-other-window-p t)
 '(sr-speedbar-delete-windows nil)
 '(sr-speedbar-auto-refresh nil))
(global-set-key "\C-o" '(lambda () (interactive) (sr-speedbar-toggle) ) )

; line numbers
(require 'linum)
(global-linum-mode 1)

; show only files in buffer list
;(require 'buff-menu+)

; window numbers
(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

; single buffer for dired
(require 'dired+)

; working grep searh
(require 'ack)
(require 'igrep)
;(require 'grep+)
;(grep-apply-setting 'grep-find-command "find . ! -name \"*~\" ! -name \"#*#\" -type f -print0 | xargs -0 -e grep -nH -e ")
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

; alternative treeview
(require 'tree-mode)
(require 'windata)
(require 'dirtree)
(autoload 'dirtree "dirtree" "Add directory to tree view" t)

; midnight commander mode
(require 'mc)

; delete selection mode
(delete-selection-mode 1)

; scrolling without moving the point
; (global-unset-key (kbd "<C-next>"))
(global-set-key (kbd "<C-next>") '(lambda () (interactive) (scroll-up 1) (delete-selection-mode 1) ) )
(global-set-key (kbd "<C-prior>") '(lambda () (interactive) (scroll-down 1)) )
(global-set-key (kbd "<C-M-prior>") '(lambda () (interactive) (scroll-other-window-down 1)) )
(global-set-key (kbd "<C-M-next>") '(lambda () (interactive) (scroll-other-window 1)) )

; python mode
(require 'cl-lib)

(load "package")
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
    (url-retrieve-synchronously "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)

(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))

(global-set-key (kbd "C-\\") 'auto-complete)
;(add-hook 'python-mode-hook 'auto-complete-mode)
;(add-hook 'python-mode-hook 'jedi:ac-setup)

;(add-hook 'after-init-hook #'global-flycheck-mode)
(require 'autopair)
(autopair-global-mode)

;(setq-default py-shell-name "ipython")
;(setq-default py-which-bufname "IPython")

(push "~/.virtualenvs/default/bin" exec-path)
(setenv "PATH" (concat "~/.virtualenvs/default/bin" ":" (getenv "PATH") ))

(require 'pymacs)
;(autoload 'pymacs-apply "pymacs")
;(autoload 'pymacs-call "pymacs")
;(autoload 'pymacs-eval "pymacs" nil t)
;(autoload 'pymacs-exec "pymacs" nil t)
;(autoload 'pymacs-load "pymacs" nil t)
;(autoload 'pymacs-autoload "pymacs")
(pymacs-load "ropemacs" "rope-")

(setq ropemacs-enable-autoimport 't)
(setq ropemacs-autoimport-modules '("os" "random" "math" "shutil" "sys") )
;(rope-generate-autoimport-cache)

; code autocheck
(when (load "flymake" t)
 (defun flymake-pylint-init ()
   (let* ((temp-file (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
          (local-file (file-relative-name temp-file (file-name-directory buffer-file-name))))
         (list "pep8" (list "--repeat" local-file "--max-line-length=180"))))

 (add-to-list 'flymake-allowed-file-name-masks '("\\.py\\'" flymake-pylint-init)))
(add-hook 'find-file-hook 'flymake-find-file-hook)

(defun my-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))

(add-hook 'post-command-hook 'my-flymake-show-help)

; comment region
(defun comment-dwim-line (&optional arg)
    (interactive "*P")
    (comment-normalize-vars)
    (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
        (comment-or-uncomment-region (line-beginning-position) (line-end-position))
      (comment-dwim arg)))

(global-set-key (kbd "M-;") 'comment-region)
(global-set-key (kbd "M-;") 'comment-dwim-line)

; highlight paranthesis
(require 'highlight-parentheses)
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

; easy switch between buffers
(require 'ido)
(ido-mode 'buffers) ;; only use this line to turn off ido for file names!
(setq ido-ignore-buffers '("^ " "*Completions*" "*Shell Command Output*"
               "*Messages*" "Async Shell Command"))

; save and restore session
(desktop-save-mode 1)
(winner-mode 1)

; go to full screen mode
(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_) 
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))
(global-set-key (kbd "C-f") 'toggle-maximize-buffer)

; move lines
(require 'drag-stuff)
(drag-stuff-global-mode)
(global-set-key (kbd "M-<right>") 'forward-whitespace)
(global-set-key (kbd "M-<left>") '(lambda () (interactive) (forward-whitespace -1)) )

; duplicate line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(global-set-key (kbd "C-D") 'duplicate-line)

; column-number-mode
(column-number-mode)

; go to file under cursor
(global-set-key (kbd "C-b") 'ffap)
(global-set-key (kbd "C-M-b") 'rope-auto-import)

; rectange mark
(require 'rect-mark)
(global-set-key (kbd "C-x r SPC") 'rm-set-mark)
(global-set-key (kbd "C-x r C-x") 'rm-exchange-point-and-mark)
(global-set-key (kbd "C-x r C-w") 'rm-kill-region)
(global-set-key (kbd "C-x r M-w") 'rm-kill-ring-save)
(autoload 'rm-set-mark "rect-mark"
  "Set mark for rectangle." t)
(autoload 'rm-exchange-point-and-mark "rect-mark"
  "Exchange point and mark for rectangle." t)
(autoload 'rm-kill-region "rect-mark"
  "Kill a rectangular region and save it in the kill ring." t)
(autoload 'rm-kill-ring-save "rect-mark"
  "Copy a rectangular region to the kill ring." t)

; backup to one directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

; restore windows layout
(require 'workgroups)
(setq wg-prefix-key (kbd "C-x w"))
(setq wg-morph-on nil)
(workgroups-mode 1)
(wg-load (concat temporary-file-directory "workgroup"))
(add-hook 'kill-emacs-hook 'wg-update-all-workgroups-and-save)

; convenient copying
(require 'copy)

; quick yes-no
(require 'quick-yes)

(global-set-key (kbd "<C-delete>") '(lambda () (interactive) (kill-line 0)) )
(global-set-key (kbd "<C-M-delete>") (quote backward-kill-sexp) )
(global-set-key (kbd "<M-delete>") (quote backward-kill-word) )

; kill to the end of line
(global-set-key (kbd "M-k") 'kill-word )
(global-set-key (kbd "<C-S-delete>") 'kill-whole-line)

; fast file reload
(global-set-key (kbd "C-x f") (quote revert-buffer))

(global-set-key (kbd "C-c w") (quote copy-word))
(global-set-key (kbd "C-c l") (quote copy-line))
(global-set-key (kbd "C-c p") (quote copy-paragraph))
(global-set-key (kbd "C-c s") (quote thing-copy-string-to-mark))
(global-set-key (kbd "C-c b") (quote thing-copy-parenthesis-to-mark))
