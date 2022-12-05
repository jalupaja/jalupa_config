;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
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
(setq doom-theme 'doom-ayu-dark)
;; (set-face-foreground 'font-lock-string-face "dark green")
(set-face-foreground 'font-lock-comment-face "dark green")
;; (setq doom-theme 'leuven) ; bright theme

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/lists/")


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

;; Hotkeys
; 
; code
(map! :leader
      :desc "Comment code"
      "c SPC" #'evilnc-comment-or-uncomment-lines)

; insert
(map! :leader
      :desc "Color picker (C-c r)"
      "i c" #'helm-colors)

; tabs
(map! :leader
      :desc "tabs"
      "v")
(map! :leader
      :desc "previous tab"
      "v h" #'tab-previous)
(map! :leader
      :desc "next tab"
      "v l" #'tab-next)
(map! :leader
      :desc "tab switcher"
      "v s" #'tab-switcher)
(map! :leader
      :desc "new tab"
      "v n" #'tab-new)
(map! :leader
      :desc "kill tab"
      "v k" #'tab-close)

;toggle
(map! :leader
      :desc "tab bar"
      "t t" #'tab-bar-mode)

;snippet alterantive
(defun translate-umlaut ()
  "translate german umlaut Snippets, credits: chat.openai.com (idk. I'm impressed)"
  (interactive)
  (let ((pos (point)))
    (cond
     ((looking-back "ue")
      (delete-char -2)
      (insert "ü"))
     ((looking-back "ae")
      (delete-char -2)
      (insert "ä"))
     ((looking-back "oe")
      (delete-char -2)
      (insert "ö"))
     ((looking-back "ss")
      (delete-char -2)
      (insert "ß"))
      (t (indent-for-tab-command)))
    ))

(global-set-key (kbd "<tab>") 'translate-umlaut)

;; config
; activate beacon
(beacon-mode 1)
(semantic-mode)
(global-semantic-stickyfunc-mode)

;; HOOKS
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'latex-mode-hook (lambda () (latex-preview-pane-mode 1)))

; ORG MODE
(after! org
        (setq org-agenda-files '("~/Documents/lists/"))
        (setq org-log-done 'time)
        (require 'org-bullets)
        )
