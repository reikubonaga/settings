;; ロードパス
(setq load-path (cons "~/.emacs.d/site-lisp" load-path))

;; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;;delete
(global-set-key "\C-h" 'delete-backward-char)

;;行数ジャンプ
(global-set-key "\C-x\C-g" 'goto-line)

;; 行数表示
(line-number-mode t)

;; スタートアップページを表示しない
(setq inhibit-startup-message t)

;; バックアップファイルを作らない
(setq backup-inhibited t)

;; Macのキーバインドを使う。optionをメタキーにする。
(when (eq window-system 'mac)
  (mac-key-mode 1)
  (setq mac-option-modifier 'meta))

;; タブキー
(setq-default tab-width 2 indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)

;; シフト + 矢印で範囲選択
(setq pc-select-selection-keys-only t)
(pc-selection-mode 1)

 ;; 対応する括弧を光らせる（グラフィック環境のみ作用）
(show-paren-mode t)

;;Color
(if window-system (progn
   (set-background-color "Black")
   (set-foreground-color "LightGray")
   (set-cursor-color "Gray")
   (set-frame-parameter nil 'alpha 80)
   ))

;;bookmarkを保存
(setq bookmark-save-flag 1)

;;key of how to move to other-window
(global-set-key "\C-^" 'other-window)

;;copy
(defun copy-from-osx ()
 (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
 (let ((process-connection-type nil))
     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
       (process-send-string proc text)
       (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

(global-font-lock-mode t)

;; python-mode
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode) auto-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;;python-mode
(add-hook 'python-mode-hook
      '(lambda()
         (setq indent-tabs-mode nil)
         ;;(setq indent-level 2)
         ;;(setq python-indent 2)
         (setq tab-width 2)))

;;php-mode
(load-library "php-mode")
(require 'php-mode)
(add-hook 'php-mode-pear-hook
	  '(lambda ()
	     (setq tab-width 2)
	     (setq indent-tabs-mode nil))
	  (setq php-completion-file "~/.emacs.d/site-lisp/php.dict")
	  (define-key php-mode-map [(C-t)] 'php-complete-function)
	  )

;;ruby-mode
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".rhtml$" . html-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '("Gemfile" . ruby-mode) auto-mode-alist))

(require 'ruby-mode)
(defun ruby-mode-set-encoding () ())

;;coffee script
(add-to-list 'load-path "~/.emacs.d/lib/coffee-mode")
(require 'coffee-mode)
(setq auto-complete-mode)
(setq auto-mode-alist  (cons '(".cofee$" . coffee-mode) auto-mode-alist))

;;jade
(add-to-list 'load-path "~/.emacs.d/lib/jade-mode")
    (require 'sws-mode)
    (require 'jade-mode)
    (add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
    (add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
    (setq auto-complete-mode)
