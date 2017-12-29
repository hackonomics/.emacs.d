
(use-package which-key
        :ensure t
        :config
        (which-key-mode))

(load-file "~/.emacs.d/sensible-defaults.el")
(sensible-defaults/use-all-settings)
(sensible-defaults/use-all-keybindings)

(ac-config-default)

(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-x c") 'split-window-right)
(global-set-key (kbd "C-x d") 'split-window-below)
(global-set-key (kbd "C-x <up>") 'other-window)
(global-set-key (kbd "C-x z") 'delete-window)

(require 'ido)
(ido-mode t)

(require 'smartparens-config)
(smartparens-global-mode t)
;; some additional pairings
(sp-pair "$" "$")
(sp-local-pair 'org-mode "/" "/")

(use-package yasnippet
  :ensure t
  :init
    (yas-global-mode 1))

(setq org-capture-templates
 '(("p" "python" entry (file+headline "~/myprojects/my_projects.org"
   "python")
 "* %?\n")
("e" "emacs" entry (file+headline "~/myprojects/my_projects.org"
   "emacs")
 "* %?\n")
("j" "Journal" entry (file+datetree "~/Dropbox/personal/journal.org.gpg" "JOURNAL" )
        "* %?" )
))

(org-babel-do-load-languages
'org-babel-load-languages
'(
(python . t)
(latex . t)
(lisp . t)))

(defun my-org-confirm-babel-evaluate (lang body)
  "Do not confirm evaluation for these languages."
  (not (or (string= lang "C")
           (string= lang "latex")
           (string= lang "java")
           (string= lang "python")
           (string= lang "emacs-lisp")
           (string= lang "sqlite"))))
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

(use-package cdlatex
       :ensure t)

(eval-after-load 'org
'(setq org-highlight-latex-and-related '(latex script entities)))

(defun org-mode-reftex-setup()
(load-library "reftex")
(and (buffer-file-name) (file-exists-p (buffer-file-name))
(progn
;enable auto-revert-mode to update reftex when bibtex changes
(global-auto-revert-mode t)
(reftex-parse-all)
)
))
(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(setq org-latex-to-pdf-process (list "latexmk -pdf %f"))

;;bibliography file
(setq reftex-default-bibliography
'("/home/gismonti/Dropbox/thesis/Final_product/bibliogaphy_phd_thesis_fin.bib"))

(setq org-src-fontify-natively t
      org-src-window-setup 'current-window
      org-src-strip-leading-and-trailing-blank-lines t
      org-src-preserve-indentation t
      org-src-tab-acts-natively t)

;; disable docview (code from stackexchange)
(defun ensc/mailcap-mime-data-filter (filter)
  ""
  (mapcar (lambda(major)
        (append (list (car major))
            (remove nil
                (mapcar (lambda(minor)
                      (when (funcall filter (car major) (car minor) (cdr minor))
                    minor))
                    (cdr major)))))
      mailcap-mime-data))

(defun ensc/no-pdf-doc-view-filter (major minor spec)
  (if (and (string= major "application")
       (string= minor "pdf")
       (member '(viewer . doc-view-mode) spec))
      nil
    t))

(eval-after-load 'mailcap
  '(progn
     (setq mailcap-mime-data
       (ensc/mailcap-mime-data-filter 'ensc/no-pdf-doc-view-filter))))

(use-package ein
  :ensure t)

(use-package elpy
  :ensure t
  :disabled
  :init
  (with-eval-after-load 'python
    (elpy-enable)
    (elpy-use-ipython)
    (delete 'elpy-module-highlight-indentation elpy-modules)))

; Set up auctex for Latex in Emacs
; Point auctex to my central .bib file
(use-package tex
  :ensure auctex
  :config
  (setq Tex-auto-save t)
  (setq Tex-parse-self t)
  (setq TeX-save-query nil)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t)
  (setq reftex-default-bibliography '("/home/gismonti/Dropbox/thesis/Final_product/bibliography_phd_thesis_fin.bib")))

(require 'powerline)
(require 'moe-theme)
(moe-light)
(powerline-default-theme)
