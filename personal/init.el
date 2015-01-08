;; load theme
;; (load-theme 'gandalf t)

;; setting font
(set-frame-font "Source Code Pro 15" nil t)

(toggle-scroll-bar -1)

;; disable whitespace mode
;;(add-hook 'prelude-prog-mode-hook 'prelude-turn-off-whitespace t)
;;(add-hook 'prelude-prog-mode-hook 'turn-off-flyspell t)
(setq prelude-whitespace nil)

;; multi term
(prelude-require-package 'multi-term)
(setq multi-term-program "/bin/zsh")

(require 'cider)
(cider-repl-toggle-pretty-printing)

;; https://github.com/clojure-emacs/clj-refactor.el
(prelude-require-package 'clj-refactor)
(require 'clj-refactor)
(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               (cljr-add-keybindings-with-prefix "C-c C-m")
                               (add-hook 'nrepl-connected-hook #'cljr-update-artifact-cache)))

;; tramp
(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil nil))


;; (if (locate-library "tramp")
;;     (eval-after-load "tramp"

;;       ;; The actual TRAMP configuration
;;       '(add-to-list 'tramp-default-proxies-alist
;;                     '("\\`default\\'"
;;                       "\\`vagrant\\'"
;;                       "/ssh:%h:"))))

(defun edit-current-file-as-root ()
  "Edit the file that is associated with the current buffer as root"
  (interactive)
  (if (buffer-file-name)
      (progn
        (setq file (concat "/sudo::" (buffer-file-name)))
        (find-file file))
    (message "Current buffer does not have an associated file.")))

;; turn hs-minor-mode on globally
(define-globalized-minor-mode global-hs-minor-mode
  hs-minor-mode hs-minor-mode)

(add-hook 'prog-mode-hook #'hs-minor-mode)

;; multiple cursors
(prelude-require-package 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;; org mode

;; loading the latest version of org
(add-to-list 'load-path "~/repos/org-mode/org-loaddefs.el")

;;adding backend for github markdown
(prelude-require-package 'ox-gfm)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-export-backends (quote (ascii html icalendar latex md gfm))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://beatofthegeek.com/2014/02/my-setup-for-using-emacs-as-web-browser.html
;; setup w3m
(prelude-require-package 'w3m)

;;change default browser for 'browse-url' to w3m
(setq browse-url-browser-function 'w3m-goto-url-new-session)

;;change w3m user-agent to android
(setq w3m-user-agent "Mozilla/5.0 (Linux; U; Android 2.3.3; zh-tw; HTC_Pyramid Build/GRI40) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.")

;;quick access hacker news
(defun hn ()
  (interactive)
  (browse-url "http://news.ycombinator.com"))

;;when I want to enter the web address all by hand
(defun w3m-open-site (site)
  "Opens site in new w3m session with 'http://' appended"
  (interactive
   (list (read-string "Enter website address(default: w3m-home):" nil nil w3m-home-page nil )))
  (w3m-goto-url-new-session
   (concat "http://" site)))

;; project explorer
(prelude-require-package 'project-explorer)

(prelude-require-package 'powerline)
(require 'powerline)
(powerline-default-theme)


;; https://github.com/gstamp/align-cljlet
;; (prelude-require-package 'align-cljet)
;;(require 'align-cljet)



;; emacs webkit
;;(prelude-require-package 'epc)
;;(load "~/repos/deepin-emacs/site-lisp/extensions/webkit/webkit.el")
