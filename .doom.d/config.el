;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;; Using newer byte compiled file
;; (setq load-prefer-newer t)

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; :q should kill the current buffer rather than quitting emacs entirely
;; Evil mode rebinds
(evil-ex-define-cmd "q" 'kill-this-buffer)
(evil-ex-define-cmd "wq" 'save-and-kill-this-buffer)
(defun save-and-kill-this-buffer()(interactive)(save-buffer)(kill-current-buffer))
  ;; Need to type out :quit to close emacs
(evil-ex-define-cmd "quit" 'evil-quit)
(define-key evil-normal-state-map "U" 'evil-redo)
(define-key evil-normal-state-map "\C-z" 'evil-undo)
(define-key evil-insert-state-map "\C-z" 'evil-undo)
(define-key evil-insert-state-map "\C-v" 'evil-paste-before)
;; don't auto complete current sentence when enter
(define-key evil-insert-state-map "\M-ENT" 'vertico-exit-input)

;; wordcount
(wc-mode t)
(define-key evil-normal-state-map "\M-c" 'wc-count)

;; Swap workspace
(map! :leader
      :prefix "TAB"
      :desc "+workspace/swap-left" "-" #'+workspace/swap-left)
(map! :leader
      :prefix "TAB"
      :desc "+workspace/swap-right" "=" #'+workspace/swap-right)

;; faster split manipulation
(map! :leader
      :desc "evil-window-delete" "d" #'evil-window-delete)
(map! :leader
      :desc "evil-window-delete" "k" #'evil-window-next)
(map! :leader
      :desc "evil-window-delete" "j" #'evil-window-prev)

;; org2blog mappings
(map! :leader
      :prefix "o"
      :desc "org2blog-user-interface" "o" #'org2blog-user-interface)

;; faster terminal access
(map! :leader
      :desc "toggle vterm popup" "m" #'+vterm/toggle)

;; dired vim keys
(evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
(evil-define-key 'normal dired-mode-map (kbd "l") 'dired-find-file)

;; org2blog setup
;; (require 'netrc)
;; (setq blog (netrc-machine (netrc-parse "~/.netrc") "peter" t))
;; (setq wpuser (netrc-get blog "login")
;;       wppass (netrc-get blog "password"))
;; (setq config `(("peter"
;;                 :url "https://peterconfidential.com/xmlrpc.php"
;;                 :username ,wpuser
;;                 :password ,wppass)))
;; (setq org2blog/wp-blog-alist config)

(require 'org2blog)
(add-hook 'org-mode-hook 'org2blog/wp-mode)
(require 'auth-source)
;;(customize-variable 'auth-source)
;; (setq auth-sources '((:source "~/.emacs.d/.local/etc/authinfo")))
;; (auth-source-forget-all-cached)

;; (let* (credentials (auth-source-user-and-password "blog")))
(defun org2blogcreds ()
        (let*   ((creds (nth 0 (auth-source-search :host "blog")))
                (url (plist-get creds :port))
                (user (plist-get creds :user))
                (pass (funcall (plist-get creds :secret)))
                (config `(("blog"
                        :url ,url
                        :username ,user
                        :password ,pass))))
                (setq org2blog/wp-blog-alist config)))

;; (org2blog-user-login)
(defun org2blog-creds-and-login()(interactive)(org2blogcreds)(org2blog-user-login))
(map! :leader
      :desc "Input credentials and Login to org2blog" "l" #'org2blog-creds-and-login)

;; (org2blogcreds)
        ;; (url (nth 0 (auth-source-user-and-password "url")))
        ;; (urls (auth-source-user-and-password "url"))
;; (setq blog  "peter" t)
;;       wpuser (netrc-get blog "login")
;;       wppass (netrc-get blog "password"))
;; (setq config `(("peter"
;;          :url "https://peterconfidential.com/xmlrpc.php"
;;          :username "hp27596")))
;; (setq org2blog/wp-blog-alist config)

(setq org2blog/wp-image-upload t)


;; doom dashboard doesn't display a whole lot information so I replace it with the dashboard package
(require 'dashboard)
(dashboard-setup-startup-hook)
(defun new-dashboard ()
  (interactive)
  (switch-to-buffer dashboard-buffer-name)
  (dashboard-mode)
  (dashboard-insert-startupify-lists)
  (dashboard-refresh-buffer))
(setq doom-fallback-buffer-name "*dashboard*")

;; beacon scrolling
(beacon-mode 1)

;; buffer scroll bar on the right for easier navigation and knowing where in the document the cursor is
(scroll-bar-mode 1)

;; enable word-wrap
(+global-word-wrap-mode +1)
;; (adaptive-wrap-prefix-mode t)

;; Prompt for buffers to open after split
(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

;; Org Auto Tangle
(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

;; full link instead of shortcut
;; (setq org-descriptive-links nil)

;; scroll margin
(setq scroll-margin 8)

(define-skeleton autofill-blog-tags
  "Blog tags for Wordpress "
  "function name: "

  "#+BLOG: peterconfidential
#+PERMALINK:
#+CATEGORY:
#+POST_TAGS:
#+TITLE:
#+DESCRIPTION:
#+AUTHOR: Hp")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; .netrc hack to avoid personal information in dotfiles.
;; (setq github (netrc-machine (netrc-parse "~/.netrc") "github" t))
(setq user-full-name "Peter Nguyen"
      user-mail-address "peter@peterconfidential.com")

(setq vterm-shell '/usr/bin/zsh)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
(setq doom-font (font-spec :family "Comic Code Ligatures" :size 27)
      doom-big-font (font-spec :family "Comic Code Ligatures" :size 35)
      doom-variable-pitch-font (font-spec :family "Comic Code Ligatures" :size 27))

;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-molokai)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are di55sabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
