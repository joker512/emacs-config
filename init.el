(add-to-list 'load-path "~/.emacs.d/lisp")
(setq def_var 4)
(global-set-key (kbd "C-c u") '(lambda () (interactive) (setq def_var (read-number "Default function parameter: ")) ) )

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
         (progn
           (point-to-register '2)
           (jump-to-register '1)
           (jump-to-register '2))
         (progn
           (window-configuration-to-register '1)
           (delete-other-windows))))
(global-set-key (kbd "C-x 1") 'toggle-maximize-buffer)

; workgroups
(setq wg-prefix-key (kbd "C-x w"))
(global-set-key (kbd "C-c C-<left>") 'wg-switch-to-workgroup-left)
(global-set-key (kbd "C-c ,") 'wg-switch-to-workgroup-left)
(global-set-key (kbd "C-c C-<right>") 'wg-switch-to-workgroup-right)
(global-set-key (kbd "C-c .") 'wg-switch-to-workgroup-right)
(workgroups-mode 1)

; save and restore session
(desktop-save-mode 1)
(winner-mode 1)

;; NAVIGATION

; buffer switch
(global-set-key (kbd "C-x .") 'next-buffer)
(global-set-key (kbd "C-x ,") 'previous-buffer)

; recent files support
(recentf-mode 1)
(setq recentf-max-menu-items 25)

; convenient navigation
(require 'ace-jump-mode)
(global-set-key (kbd "M-h") 'ace-jump-char-mode)
(global-set-key (kbd "M-j") 'ace-jump-word-mode)
(global-set-key (kbd "M-u") 'ace-jump-mode-pop-mark)

; backward-forward paragraph
(global-set-key (kbd "C-M-p") 'backward-paragraph)
(global-set-key (kbd "C-M-n") 'forward-paragraph)

; buffer list on C-x b
(require 'ido)
(ido-mode t)

; line numbers
(add-hook 'find-file-hook (lambda () (linum-mode 1)))
(setq linum-format (lambda (line) (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))
(global-set-key (kbd "C-c L") 'linum-mode)

; working grep search
(global-set-key (kbd "M-g r") 'igrep)

; convenient scroll
(global-set-key (kbd "C-c C-s") 'scroll-lock-mode )
(global-set-key (kbd "C-<next>") '(lambda () (interactive) (scroll-up def_var)) )
(global-set-key (kbd "C-<prior>") '(lambda () (interactive) (scroll-down def_var)) )
(global-set-key (kbd "C-M-<prior>") '(lambda () (interactive) (scroll-other-window-down def_var)) )
(global-set-key (kbd "C-M-<next>") '(lambda () (interactive) (scroll-other-window def_var)) )

; column-number-mode
(column-number-mode)

; go to file under cursor
(global-set-key (kbd "C-c f") 'ffap)

; convenient buffer processing
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-expert t)

; move to the end of line with number
(global-set-key (kbd "M-g M-g") '(lambda(n) (interactive "nGoto line: ") (progn (goto-line n) (move-end-of-line nil))))

; fast file reload
(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
      (interactive) (revert-buffer t t))
(global-set-key (kbd "C-x f") (quote revert-buffer-no-confirm))

;; EDIT

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

; paste previous from buffer
(global-set-key (kbd "C-M-y") '(lambda () (interactive) (yank 2)) )

; delete selection mode
(cua-selection-mode 1)

; move lines
(require 'drag-stuff)
(drag-stuff-global-mode)
(global-set-key (kbd "M-<right>") 'forward-whitespace)
(global-set-key (kbd "C-M-f") 'forward-whitespace)
(global-set-key (kbd "M-<left>") '(lambda () (interactive) (forward-whitespace -1)) )
(global-set-key (kbd "C-M-b") '(lambda () (interactive) (forward-whitespace -1)) )

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

(global-set-key (kbd "C-M-d") 'duplicate-current-line-or-region)

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

(global-set-key (kbd "M-k") 'kill-whole-line)
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

; uncompressing
(defun uncompress-xml ()
  (interactive)
  (beginning-of-buffer)
  (replace-regexp "><" ">\n<")
  (mark-whole-buffer)
  (indent-region 0 most-positive-fixnum)
)

; increment number
(defun increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

(defun decrement-number-decimal (&optional arg)
  (interactive "p*")
    (increment-number-decimal (if arg (- arg) -1)))

(global-set-key (kbd "C-c +") 'increment-number-decimal)
(global-set-key (kbd "C-c -") 'decrement-number-decimal)

;; CODING
;; (if (not (display-graphic-p))
(require 'init-coding)
(require 'cpp)

;; DESIGN
(if (display-graphic-p)
    (progn 
      (global-visual-line-mode 1)
      (custom-set-faces
       ;; custom-set-faces was added by Custom.
       ;; If you edit it by hand, you could mess it up, so be careful.
       ;; Your init file should contain only one such instance.
       ;; If there is more than one, they won't work right.
       '(window-number-face ((t (:background "darkgray" :foreground "black"))) t))
      ))

; custom columns width for ibuffer
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (dichromacy)))
 '(ibuffer-formats
   (quote
    ((mark modified read-only " "
	   (name 25 25 :left :elide)
	   " "
	   (size 9 -1 :right)
	   " "
	   (mode 16 16 :left :elide)
	   " " filename-and-process)
     (mark " "
	   (name 16 -1)
	   " " filename))))
 '(speedbar-show-unknown-files t)
 '(sr-speedbar-auto-refresh nil)
 '(sr-speedbar-delete-windows nil)
 '(sr-speedbar-right-side nil)
 '(sr-speedbar-skip-other-window-p t)
 '(sr-speedbar-width-console 32)
 '(sr-speedbar-width-x 32))

; highlight lines in dired
(add-hook 'dired-mode-hook '(lambda () (interactive) (hl-line-mode t)))

;; DIFFERENT

; backup to one directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

; light mode for big files
(require 'vlf-integrate)

; quick yes-no
(require 'quick-yes)

; empty scratch message
(setq initial-scratch-message "")

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

; fixes for eshell
(require 'init-eshell)

; "emacsclient -nw" support
(defun is-server-running ()
  (and (boundp 'server-process)
       (memq (process-status server-process) '(connect listen open run))))
(if (is-server-running)
    (server-start))
