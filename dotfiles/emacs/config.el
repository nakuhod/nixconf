;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package — Nix manages installation; we just initialise the repos
;; so `use-package` can find packages at load time.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Basic UI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t
      ring-bell-function #'ignore
      use-dialog-box nil
      display-line-numbers-type 'relative
      calendar-week-start-day 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(column-number-mode 1)
(electric-pair-mode 1)
(electric-indent-mode 1)
(show-paren-mode 1)
(recentf-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-splash-screen t) ; disable startup screen
(global-visual-line-mode t)    ; disable visual line mode
(auto-save-mode nil)           ; don't auto save files by default
(setq initial-buffer-choice (lambda() (get-buffer "*dashboard*"))) ; so that the Emacsclient window opens up with Dashboard each time 
(setq use-short-answers t)     ; so that yes/no questions in the minibuffer can be answered using y/n
(setq-default tab-width 4)     ; make default tab spacing 4
(setq browse-url-generic-program "xdg-open") ; open URLs in the default web browser (not EWW) using XDG's util
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups/" user-emacs-directory))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Turkish deasciifier
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package turkish
  :ensure t
  :config
  (turkish-mode 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package doom-themes
  :config
  (load-theme 'doom-one t))

(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "◆" "▶"))
  (org-superstar-remove-leading-stars t)
  (org-superstar-leading-bullet ?\s)
  (org-hide-leading-stars t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Faces(Emacs default font) and icons
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-face-attribute 'default nil
     :family "JetBrainsMono Nerd Font"
     :height 90
     :weight 'normal
     :width 'normal)

(set-face-attribute 'variable-pitch nil
     :family "JetBrainsMono Nerd Font"
     :height 90
     :weight 'normal
     :width 'normal)

(set-face-attribute 'fixed-pitch nil
     :family "JetBrainsMono Nerd Font"
     :height 90
     :weight 'normal
     :width 'normal)

(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-10"))

(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-function-name-face nil :slant 'italic)
(set-face-attribute 'font-lock-variable-name-face nil :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)

(use-package all-the-icons :ensure t)
(use-package all-the-icons-completion
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode) :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Status-line(like vim)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :ensure t
  :config
  (setq doom-modeline-icon t
  doom-modeline-major-mode-icon t
  doom-modeline-major-mode-color-icon t
  doom-modeline-enable-word-count t
  doom-modeline-buffer-encoding t
  doom-modeline-persp-icon t
  doom-modeline-modal-modern-icon nil
  doom-modeline-persp-name t
  doom-modeline-height 25))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my/org-dwim-at-point ()
  (interactive)
  (cond
   ;; links
   ((org-in-regexp org-link-any-re)
    (org-open-at-point))

   ;; checkbox
   ((org-at-item-checkbox-p)
    (org-toggle-checkbox))

   ;; TODO / headline
   ((org-at-heading-p)
    (org-todo))

   ;; table
   ((org-at-table-p)
    (org-table-recalculate 'all))

   ;; timestamp
   ((org-at-timestamp-p)
    (org-follow-timestamp-link))

   ;; fallback
   (t
    (org-open-at-point))))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)

  ;; Common typos
  (evil-ex-define-cmd "W" "w")
  (evil-ex-define-cmd "Q" "q")
  (evil-ex-define-cmd "WQ" "wq")
  (evil-ex-define-cmd "Wq" "wq")
  (setq org-startup-folded 'content)   ; Collapse to top-level headings only 
  (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)
  (evil-define-key 'normal org-mode-map (kbd "RET") #'my/org-dwim-at-point))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package general
  :init
  (general-evil-setup t))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

(defun my/vsplit-and-follow ()
  "Split window vertically and follow."
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1))

(defun my/edit-config ()
  "Open Emacs init.el."
  (interactive)
  (find-file (expand-file-name "init.el" user-emacs-directory)))

(general-define-key
 :states '(normal visual insert emacs)
 :keymaps 'override
 :prefix "SPC"
 :non-normal-prefix "C-SPC"

 ;; window
 "s v" '(my/vsplit-and-follow    :which-key "vertical split")
 "s s" '(delete-window           :which-key "close window")
 "s f" '(find-file               :which-key "find file")
 "s r" '(recentf     :which-key "recent files")

 ;; doom-emacs specific org keybindings
 "m c i" '(org-clock-in          :which-key "org clock in")
 "m c o" '(org-clock-out          :which-key "org clock out")
 "m c c" '(org-clock-cancel          :which-key "org clock cancel")

 ;; other
 "f P" '(my/edit-config          :which-key "edit config"))

;; window navigation — normal mode only, no prefix
(general-define-key
 :states 'normal
 "C-h" 'evil-window-left
 "C-j" 'evil-window-down
 "C-k" 'evil-window-up
 "C-l" 'evil-window-right
 )

;; org — global, works in all modes
(general-define-key
 "C-c c" 'org-capture
 "C-c a" 'org-agenda
 "C-c t" 'org-todo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dashboard
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package dashboard
    :config
        (dashboard-setup-startup-hook)
    :custom
        (dashboard-banner-logo-title nil)
        (dashboard-center-content t)
        (dashboard-display-icons-p t)
        (dashboard-set-heading-icons t)
        (dashboard-icon-type 'nerd-icons)
        (dashboard-set-file-icons t)
        (dashboard-items '((recents . 5))))
(require 'dashboard-widgets)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HL Todo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package hl-todo
  :hook ((prog-mode text-mode) . hl-todo-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Completion(fuzzy-finding when M-x)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package vertico
  :ensure t
  :config (vertico-mode 1))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)))

(use-package marginalia
  :ensure t
  :config (marginalia-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org
             :ensure nil                      ; built-in, Nix supplies it via emacs itself
             :mode ("\\.org\\'" . org-mode)
             :custom
             (org-hide-emphasis-markers t)
             (org-startup-indented t)
             (org-ellipsis " ▾")

             :custom-face
             (org-level-1 ((t (:height 1.3 :weight bold))))
             (org-level-2 ((t (:height 1.2 :weight bold))))
             (org-level-3 ((t (:height 1.1 :weight bold))))
             (org-level-4 ((t (:weight semi-bold))))
             :config
             (setq org-file-apps
             (append '(("\\.pdf\\'" . "firefox %s")) org-file-apps))
             (setq org-directory "~/org")
             (setq org-agenda-files (directory-files-recursively org-directory "\\.org$"))
             (setq org-log-done 'time)
             (require 'org-habit)
             (add-to-list 'org-modules 'org-habit)
             (setq org-habit-graph-column 60)
             ;; Enable syntax highlighting for Org source blocks
             (setq org-src-fontify-natively t)
             ;; Ensure Org knows rust -> rust-mode
             (add-to-list 'org-src-lang-modes '("rust" . rust))
             (setq org-todo-keywords
                   '((sequence "PROJ(p)" "LOOP(l)" "BACK(b)" "TODO(t)"
                               "STRT(s)" "HOLD(h)" "WAIT(w)" "IDEA(i)"
                               "|"
                               "DONE(d)" "KILL(k)")))
             (setq org-todo-keyword-faces
                   '(("TODO" . (:foreground "OrangeRed"      :weight bold))
                     ("PROJ" . (:foreground "MediumPurple"   :weight bold))
                     ("LOOP" . (:foreground "MediumOrchid"   :weight bold))
                     ("STRT" . (:foreground "chartreuse"     :weight bold))
                     ("WAIT" . (:foreground "goldenrod"      :weight bold))
                     ("HOLD" . (:foreground "SteelBlue"      :weight bold))
                     ("IDEA" . (:foreground "CadetBlue"      :weight normal))
                     ("BACK" . (:foreground "SlateGray"     :weight normal))
                     ("DONE" . (:foreground "DimGray"        :weight bold))
                     ("KILL" . (:foreground "gray30"         :weight bold :strike-through t))))

             (custom-set-faces
               '(org-level-1 ((t (:foreground "floral white" :weight bold ))))
               '(org-level-2 ((t (:foreground "GhostyWhite" :weight bold ))))
               '(org-level-3 ((t (:foreground "Silver" ))))
               '(org-level-4 ((t (:foreground "Ivory" ))))
               '(org-level-5 ((t (:foreground "Ivory" ))))
               '(org-level-6 ((t (:foreground "Ivory" ))))
               '(org-level-7 ((t (:foreground "Ivory" ))))
               '(org-level-8 ((t (:foreground "Ivory" )))))

             ;; Misc
             (turkish-mode 1)
             ;; Org keybinds
             (global-set-key (kbd "C-c c") #'org-capture)
             (global-set-key (kbd "C-c a") #'org-agenda)
             (global-set-key (kbd "C-c t") #'org-todo)
             (global-set-key (kbd "C-c w") #'turkish-toggle-last-word)
             (global-set-key (kbd "C-c x") #'turkish-toggle-accent)


             ;; Org Capure Templates
             (setq org-capture-templates
                   '(
                     ("j" "journal")
                     ("jd" "daily" entry
                      (file+olp (lambda () (concat org-directory "/home.org")) "Ajanda")
                      "* %<%Y-%m-%d %A> (Week %<%V> | %<%B>)\n** Retrospektif\n***  %?\n** Yapılacaklar\n***  ")

                     ("jw" "weekly" entry
                      (file+olp (lambda () (concat org-directory "/journal.org")) "Haftalık Retrospektif")
                      "* Week %<%V> | %<%B> %<%Y>\n** Retrospektif\n***  %?\n** Yapılacaklar :REFILE:\n***  \n** Günler :REFILE:")

                     ("jm" "monthly" entry
                      (file+olp (lambda () (concat org-directory "/journal.org")) "Aylık Retrospektif")
                      "* %<%B> | %<%Y>\n** Retrospektif\n***  %?\n** Yapılacaklar :REFILE:\n***  \n** Haftalar :REFILE:")

                     ("jy" "yearly" entry
                      (file+olp (lambda () (concat org-directory "/journal.org")) "Yıllık Retrospektif")
                      "* %<%Y>\n** Retrospektif\n***  %?\n** Yapılacaklar\n***  \n** Aylar :REFILE:")
                     ))

            (setq org-refile-targets
                  (mapcar (lambda (file)
                            (cons file '(:tag . "REFILE")))
                          (directory-files-recursively
                           (expand-file-name org-directory)
                           "\\.org$")))

            (setq org-refile-use-outline-path 'file)
            (setq org-outline-path-complete-in-steps nil)

            ;; Org Agenda Views
            (setq org-agenda-block-separator ?~)
            (setq org-agenda-time-grid
                  (quote
                    ((daily today remove-match)
                     (600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1800 2000 2200)
                     "......" "----------------")))

             (setq org-agenda-custom-commands
                   '(
                     ("v" "More comprehensive agenda view"
                      ((tags "PRIORITY=\"A\"+TODO=\"TODO\""
                             ((org-agenda-overriding-header "High-priority unfinished tasks:")))
                       (agenda "")
                       (tags "TODO=\"TODO\""
                             ((org-agenda-overriding-header "All unfinished tasks:")))
                       ))
                     ("k" "Kanban view"
                      ((tags "TODO=\"BACK\""
                             ((org-agenda-overriding-header "BACK (unscheduled)")))
                       (tags "TODO=\"TODO\""
                             ((org-agenda-overriding-header "TODO (scheduled, awaiting)")))
                       (tags "TODO=\"STRT\""
                             ((org-agenda-overriding-header "STRT (started, in progress)")))
                       (tags "TODO=\"WAIT\""
                             ((org-agenda-overriding-header "WAIT (waiting on external factor)")))
                       (tags "TODO=\"HOLD\""
                             ((org-agenda-overriding-header "HOLD (paused, stopped working on it for a temporary time)")))
                       (tags "TODO=\"DONE\""
                             ((org-agenda-overriding-header "DONE (finished)")))
                       (tags "TODO=\"KILL\""
                             ((org-agenda-overriding-header "KILL (canceled, abandoned)")))
                       )

                      )
                     )
                   )


             )
(use-package org-roam
             :ensure t
             :custom
             (org-roam-directory "~/org/roam")
             (org-roam-completion-everywhere t)
             :bind (("C-c n l" . org-roam-buffer-toggle)
                    ("C-c n f" . org-roam-node-find)
                    ("C-c n i" . org-roam-node-insert)
                    :map org-mode-map
                    ("C-M-i " . completion-at-point)
                    )
             :config
             (org-roam-setup)
             )

(with-eval-after-load 'ox-latex
     (add-to-list 'org-latex-classes
                  '("moderncv"
                    "\\documentclass{moderncv}"
                    ("\\section{%s}" . "\\section*{%s}")
                    ("\\subsection{%s}" . "\\subsection*{%s}"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dired
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :config
  (setq dired-listing-switches "-alh"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Undo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq undo-limit (* 8 1024 1024))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
