(add-to-list 'load-path "~/.emacs.d/lisp")

;; REPOSITORIES
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))
(setq package-enable-at-startup nil)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
    (url-retrieve-synchronously "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)

;; DIRED
; sorting directories before files in dired
(setq ls-lisp-use-insert-directory-program t)
(setq insert-directory-program "/bin/ls")

(require 'dired-sort-map)
(setq dired-listing-switches "--group-directories-first -alh")

; don't show hidden files
(require 'dired-x)
(setq-default dired-omit-files-p t)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
(global-set-key (kbd "M-.") 'dired-omit-mode)

; don't ask confirmation on delete
(setq dired-recursive-deletes 'always)

;; WINDOWS MANAGEMENT
; toggle from vertical to horizontal split and back
(require 'toggle-window-split)
(global-set-key (kbd "C-x |") 'toggle-window-split)

; windows navigation
(global-set-key (kbd "C-x <up>") '(lambda () (interactive) (other-window -1)) )
(global-set-key (kbd "C-x <down>") 'other-window)
(global-set-key (kbd "M-S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-S-<down>") 'shrink-window)
(global-set-key (kbd "M-S-<up>") 'enlarge-window)

; windows swap
(global-set-key (kbd "C-x <C-up>")     'buf-move-up)
(global-set-key (kbd "C-x <C-down>")   'buf-move-down)
(global-set-key (kbd "C-x <C-left>")   'buf-move-left)
(global-set-key (kbd "C-x <C-right>")  'buf-move-right)

; window numbers
(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

; go to full screen mode
(defun toggle-maximize-buffer () "Maximize buffer"
       (interactive)
       (if (= 1 (length (window-list)))
           (jump-to-register '_)
         (progn
           (window-configuration-to-register '_)
           (delete-other-windows))))
(global-set-key (kbd "C-x 1") 'toggle-maximize-buffer)

; workgroups
(setq wg-prefix-key (kbd "C-x w"))
(global-set-key (kbd "C-c C-<left>") 'wg-switch-to-workgroup-left)
(global-set-key (kbd "C-c C-<right>") 'wg-switch-to-workgroup-right)
(workgroups-mode 1)

; save and restore session
(desktop-save-mode 1)
(winner-mode 1)

;; NAVIGATION

; recent files support
(recentf-mode 1)
(setq recentf-max-menu-items 25)

; convenient navigation
(require 'ace-jump-mode)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

; buffer list on C-x b
(require 'ido)
(ido-mode t)

; line numbers
(global-linum-mode 1)
(setq linum-format (lambda (line) (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

; working grep search
(custom-set-faces)
(global-set-key (kbd "M-g r") 'igrep)

; scrolling without moving the point
(global-set-key (kbd "C-<next>") '(lambda () (interactive) (scroll-up 1)) )
(global-set-key (kbd "C-<prior>") '(lambda () (interactive) (scroll-down 1)) )
(global-set-key (kbd "C-M-<prior>") '(lambda () (interactive) (scroll-other-window-down 1)) )
(global-set-key (kbd "C-M-<next>") '(lambda () (interactive) (scroll-other-window 1)) )

; column-number-mode
(column-number-mode)

; go to file under cursor
(global-set-key (kbd "C-M-f") 'ffap)

; convenient buffer processing
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-expert t)

; fast file reload
(global-set-key (kbd "C-x f") (quote revert-buffer))

; treeview mode
(defun ad-advised-definition-p (definition)
  "Return non-nil if DEFINITION was generated from advice information."
  (if (or (ad-lambda-p definition)
	  (macrop definition)
	  (ad-compiled-p definition))
      (let ((docstring (ad-docstring definition)))
	(and (stringp docstring)
	          (get-text-property 0 'dynamic-docstring-function docstring)))))

(require 'sr-speedbar)
(custom-set-variables
'(speedbar-show-unknown-files t)
'(sr-speedbar-right-side nil)
'(sr-speedbar-width-console 32)
'(sr-speedbar-width-x 32)
'(sr-speedbar-skip-other-window-p t)
'(sr-speedbar-delete-windows nil)
'(sr-speedbar-auto-refresh nil))
(global-set-key "\C-o" '(lambda () (interactive) (sr-speedbar-toggle) ) )
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; EDIT

; paste previous from buffer
(global-set-key (kbd "C-M-y") '(lambda () (interactive) (yank 2)) )

; delete selection mode
(cua-selection-mode 1)

; tail mode
(global-set-key (kbd "M-u") 'auto-revert-tail-mode)

; move lines
(require 'drag-stuff)
(drag-stuff-global-mode)
(global-set-key (kbd "M-<right>") 'forward-whitespace)
(global-set-key (kbd "M-<left>") '(lambda () (interactive) (forward-whitespace -1)) )

; duplicate line or region
(defun duplicate-current-line-or-region (arg)
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (if (and mark-active (> (length (thing-at-point 'line)) 1))
	(previous-line))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(global-set-key (kbd "C-d") 'duplicate-current-line-or-region)

; rectange mark
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

; copying
(require 'copy)

; unified remove text scheme
(global-set-key (kbd "<C-delete>") '(lambda () (interactive) (kill-line 0)) )
(global-set-key (kbd "<C-M-delete>") (quote backward-kill-sexp) )
(global-set-key (kbd "<M-delete>") (quote backward-kill-word) )

(global-set-key (kbd "M-k") 'kill-word )
(global-set-key (kbd "<C-S-delete>") 'kill-whole-line)

(defun backwards-zap-to-char (char)
  (interactive "cZap backwards to char: ")
  (zap-to-char -1 char))
(global-set-key (kbd "C-M-z") 'backwards-zap-to-char)

; fasy copying
(global-set-key (kbd "C-c w") (quote copy-word))
(global-set-key (kbd "C-c l") (quote copy-line))
(global-set-key (kbd "C-c p") (quote copy-paragraph))
(global-set-key (kbd "C-c s") (quote thing-copy-string-to-mark))
(global-set-key (kbd "C-c b") (quote thing-copy-parenthesis-to-mark))

;; CODING
(if (not (display-graphic-p))
    (require 'init-coding))    

;; DIFFERENT

; backup to one directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

; quick yes-no
(require 'quick-yes)

; statistics
(defun word-count-analysis (start end)
  "Count how many times each word is used in the region.
    Punctuation is ignored."
  (interactive "r")
  (let (words)
    (save-excursion
      (goto-char start)
      (while (re-search-forward "\\w+" end t)
	(let* ((word (intern (match-string 0)))
	       (cell (assq word words)))
	  (if cell
	      (setcdr cell (1+ (cdr cell)))
	    (setq words (cons (cons word 1) words))))))
    (when (interactive-p)
      (message "%S" words))
    words))

; emacsclient -nw support
(server-start)
