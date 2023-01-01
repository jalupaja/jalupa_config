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

;dired
; add default vim keybindings
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file)

(evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
(evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)

(map! :leader
      (:prefix ("d" . "dired"))
      (:after dired
              (:map dired-mode-map
               :desc "Show hidden files" "d h" #'dired-omit-mode
               :desc "Peep-dired image previews" "d p" #'peep-dired
               :desc "Dired view file" "d v" #'dired-view-file)))

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
     ((er/looking-back-exact "ue")
      (delete-char -2)
      (insert "ü"))
     ((er/looking-back-exact "ae")
      (delete-char -2)
      (insert "ä"))
     ((er/looking-back-exact "oe")
      (delete-char -2)
      (insert "ö"))
     ((er/looking-back-exact "Ue")
      (delete-char -2)
      (insert "Ü"))
     ((er/looking-back-exact "Ae")
      (delete-char -2)
      (insert "Ä"))
     ((er/looking-back-exact "Oe")
      (delete-char -2)
      (insert "Ö"))
     ((er/looking-back-exact "ss")
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

;; DIRED
(setq dired-omit-files "^\\\..*$")

; ORG MODE
(after! org
        (setq org-agenda-files '("~/Documents/lists/"))
        (setq org-log-done 'time)
        (require 'org-bullets)
        )

;; LANGUAGE PACK
; https://200ok.ch/posts/2020-08-22_setting_up_spell_checking_with_multiple_dictionaries.html
; apt install hunspell \
;    hunspell-de-de \
;    hunspell-en-gb \
;    hunspell-en-us \
;    hunspell-de-ch-frami
(with-eval-after-load "ispell"
  ;; Configure `LANG`, otherwise ispell.el cannot find a 'default
  ;; dictionary' even though multiple dictionaries will be configured
  ;; in next line.
  (setenv "LANG" "en_US.UTF-8")
  (setq ispell-program-name "hunspell")
  ;; Configure German, Swiss German, and two variants of English.
  (setq ispell-dictionary "de_DE,de_CH,en_GB,en_US")
  ;; ispell-set-spellchecker-params has to be called
  ;; before ispell-hunspell-add-multi-dic will work
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "de_DE,de_CH,en_GB,en_US")
  ;; For saving words to the personal dictionary, don't infer it from
  ;; the locale, otherwise it would save to ~/.hunspell_de_DE.
  (setq ispell-personal-dictionary "~/.hunspell_personal"))

;; The personal dictionary file has to exist, otherwise hunspell will
;; silently not use it.
(unless (file-exists-p ispell-personal-dictionary)
  (write-region "" nil ispell-personal-dictionary nil 0))
