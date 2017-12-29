(setq inhibit-startup-message t)
(setq
 org-default-notes-file "~/Dropbox/personal/my_projects.org"
 initial-buffer-choice org-default-notes-file)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(org-babel-load-file (expand-file-name "~/.emacs.d/configuration.org"))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files nil)
 '(org-hide-emphasis-markers t)
 '(package-selected-packages
   (quote
    (ein cdlatex powerline moe-theme which-key websocket use-package try smartparens skewer-mode shut-up request pomidor package-build f epl elpy deferred cl-generic auto-complete auctex)))
 '(safe-local-variable-values (quote ((TeX-master . "basic_research_cirrito")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
