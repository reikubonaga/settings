(defun mac? () (string-match "apple-darwin" system-configuration))

;; ロードパス
(setq load-path (cons "~/.emacs.d/site-lisp" load-path))

;;delete
(global-set-key "\C-h" 'delete-backward-char)

;;grep-find
(global-set-key "\C-xg" 'grep-find)

;;各行の先頭に文字列を挿入する
(global-set-key "\C-xrd" 'delete-whitespace-rectangle)

;;各行をインデント
(global-set-key "\C-xri" 'indent-region)

;;行数ジャンプ
(global-set-key "\C-x\C-g" 'goto-line)

;; 行数表示
(line-number-mode t)

;; スタートアップページを表示しない
(setq inhibit-startup-message t)

;; バックアップファイルを作らない
(setq backup-inhibited t)

;; Macのキーバインドを使う。optionをメタキーにする。
;;(when (mac?)
;;  (mac-key-mode 1)
;;  (setq mac-option-modifier 'meta))

;; タブキー
(setq-default tab-width 2 indent-tabs-mode nil)
;;(setq indent-line-function 'indent-relative-maybe)

;; シフト + 矢印で範囲選択
;;(setq pc-select-selection-keys-only t)
;;(pc-selection-mode 1)

 ;; 対応する括弧を光らせる（グラフィック環境のみ作用）
(show-paren-mode t)

;;bookmarkを保存
(setq bookmark-save-flag 1)

;;key of how to move to other-window
(global-set-key "\C-^" 'other-window)

;;copy
(when (mac?)
 (defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

 (defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
       (process-send-string proc text)
       (process-send-eof proc))))

 (setq interprogram-cut-function 'paste-to-osx)
 (setq interprogram-paste-function 'copy-from-osx))

(global-font-lock-mode t)

;; python-mode
;;(setq auto-mode-alist
;;      (cons '("\\.py$" . python-mode) auto-mode-alist))
;;(autoload 'python-mode "python-mode" "Python editing mode." t)

;;python-mode
;;(add-hook 'python-mode-hook
;;      '(lambda()
;;         (setq indent-tabs-mode nil)
         ;;(setq indent-level 2)
         ;;(setq python-indent 2)
;;         (setq tab-width 2)))

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

;; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;;Delete excess white space
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default require-final-newline t)

;;find grep
(setq grep-find-command "find . -type f ! -name '*.png' ! -path '.git*' ! -path '.bundle*' -print0 | xargs -0 grep -n ")

;;textmate and peepopen
(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(require 'textmate)
(add-to-list 'load-path "~/.emacs.d/vendor/")
(require 'peepopen)
(textmate-mode)

;;
(require 'web-mode)

;;; emacs 23以下の互換
(when (< emacs-major-version 24)
  (defalias 'prog-mode 'fundamental-mode))

;;; 適用する拡張子
(add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))

;;; インデント数
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-html-offset   2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-php-offset    2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2))
(add-hook 'web-mode-hook 'web-mode-hook)

;;linum-mode off (高速化)
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(setq auto-mode-alist  (cons '("\\.md$" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '("\\.markdown$" . markdown-mode) auto-mode-alist))

;; 1文字削除して次の行に
(global-set-key "\C-x\C-n" (kbd "C-d C-n"))
;; 2文字削除して次の行に
(global-set-key "\C-x\C-n" (kbd "C-d C-d C-n"))

(defun git-blame-current-buffer () ;; shell-command を使うより、vc-annotete を利用した方がさらに過去にさかのぼれるので良いのでは？
  (interactive)
  (let ((result-buf "*git blame*")
        (popup-context (git-blame-current-line))
        (hoge-line (line-number-at-pos)))
    (shell-command (concat "git blame " (buffer-file-name (current-buffer))) result-buf)
    (view-buffer-other-window result-buf t                              (lambda (buf)
                                (kill-buffer-and-window)))
  (switch-to-buffer result-buf)
  (goto-line hoge-line)
  (recenter)
  (popup-tip popup-context)))

(global-set-key "\C-cb" 'git-blame-current-buffer)

(defun git-blame-current-line ()
  (interactive)
  (let ((old-buf (current-buffer))
    (blame-buf (get-buffer-create "*blame*"))
    (line-num (number-to-string (line-number-at-pos))))
    (set-buffer blame-buf)
    (erase-buffer)
    (call-process "git-blame-oneline" nil "*blame*" t (buffer-file-name old-buf) line-num)
    (setq content (buffer-string))
    (set-buffer old-buf)
    (when (not (eq (length content) 0)) ;;この when に入らない場合は想定していないです
      content)))
