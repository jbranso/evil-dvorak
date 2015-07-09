;;; evil-dvorak.el  ---  allows you to use evil with appropriate dvorak bindings

;; Copyright (C) 2015 Joshua Branson
;; Author: Joshua Branson
;; Package-Requires: ((evil  "1.0.8") (ace-jump-mode "2.0") (anzu "0") (helm "0") (helm-swoop "0") (evil-surround "0") (wind-move "0"))
;; Created: January 30 2015
;; Keywords:  dvorak evil vim
;; Version: 0.1

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Evil dvorak mode allows the user to use the dvorak keyboard with evil-mode.

;; How it install
;; ===
;; Put this in your emacs initialation file (~.emacs.d/init.el)
;; This turns on evil-dvorak for every file.
;; (require 'evil-dvorak)
;; (global-evil-dvorak-mode 1)

;;; Code:

(require 'evil)

(define-minor-mode evil-dvorak-mode
  "Evil dvorak mode allows you to use evil using the dvorak keyboard layout.  Contributions are welcome."
  :lighter " ED"
  :keymap (make-sparse-keymap))

(defun turn-on-evil-dvorak-mode ()
  "Enable evil-dvorak-mode in the current buffer."
  (evil-dvorak-mode 1))

(defun turn-off-evil-dvorak-mode ()
  "Disable evil-dvorak-mode in this buffer."
  (evil-dvorak-mode -1))

(define-globalized-minor-mode global-evil-dvorak-mode
  evil-dvorak-mode turn-on-evil-dvorak-mode
  "Global minor mode to emulate surround.vim.")

(defun endless/comment-line (n)
  "Comment or uncomment current line and leave point after it.
With positive prefix, apply to N lines including current one.
With negative prefix, apply to -N lines above."
  (interactive "p")
  ;;if we are in web-mode, use comment-or-uncomment
  (if (eq major-mode 'web-mode)
      (web-mode-comment-or-uncomment)
    (comment-or-uncomment-region)
    (line-beginning-position)
    (goto-char (line-end-position n))
    (forward-line 1)
    (back-to-indentation)))

(evil-define-key 'visual evil-dvorak-mode-map
  "s" 'evil-forward-char
  "n" 'evil-backward-char
  "t" 'evil-previous-line
  "h" 'evil-next-line
  ";" 'endless/comment-line
  ;;I what to be able to use vaw (visual around word) and viw (visual inner word)
  ;; that's why in visual mode, u and a are not defined.
  ;;(evil-define-key 'visual "u" 'evil-end-of-line)
  ;;(evil-define-key 'visual "a" 'evil-first-non-blank
  "o" 'evil-backward-word-begin
  "e" 'evil-forward-word-begin
  "O" 'evil-backward-WORD-end
  "E" 'evil-forward-WORD-end
  (kbd "<backspace>") 'ace-jump-char-mode
  ;;(kbd ";") 'comment-dwim
  )

;; I don't like the normal keys that vim users use for up and down, so
;; I'm if dvorak-funky-h-and-t == 1, then I'll swap h and t.
(defvar evil-dvorak-funky-h-and-t)
(defvar evil-dvorak-use-for-web-mode)
(if (equal evil-dvorak-funky-h-and-t 1)
    (evil-define-key 'normal evil-dvorak-mode-map
      "t" 'evil-previous-line
      "h" 'evil-next-line)
  (evil-define-key 'normal evil-dvorak-mode-map
    "t" 'evil-previous-line
    "h" 'evil-next-line))

(evil-define-key 'normal evil-dvorak-mode-map

  (kbd "TAB") #'indent-for-tab-command
  (kbd "s-z") #'evil-emacs-state
  (kbd "s-l") #'org-link
  (kbd "s-z") #'evil-normal-state
  (kbd "C-w h") #'windmove-down
  (kbd "C-w t") #'windmove-up
  (kbd "b") #'(lambda ()
                "Switch to the previous buffer"
                (interactive)
                (switch-to-buffer nil))
  "B" #'(lambda ()
          "display all possible buffers and pick the one you want"
          (interactive)
          (list-buffers))
  ;;(define-key evil-normal-state-map (kbd "Q") 'anzu-query-replace-regexp)
  ;; This for when I use visual line mode mode. Now visual line mode should work for basic
  ;; key movements
  ;; This is not working.
  (kbd "h") #'next-line
  (kbd "t") #'previous-line
  (kbd "n") #'backward-char
  (kbd "l") #'forward-char
  "k" 'kill-line
  "K" #'(lambda () (interactive)
          "kill from point to the beginning of the line"
          (kill-line 0))
  "I" 'evil-append
  "$" 'ispell-word
  ";" 'endless/comment-line
  (kbd "C-s") 'evil-substitute
  "s" 'evil-forward-char
  "n" 'evil-backward-char
  (kbd "C-l") 'recenter-top-bottom
  "l" 'recenter-top-bottom
  "o" 'evil-backward-word-begin
  "e" 'evil-forward-word-begin
  "O" 'evil-backward-WORD-end
  "E" 'evil-forward-WORD-end
  "J" 'join-line
  "j" #'(lambda () (interactive)
          "join this line at the end of the line below"
          (join-line 1))
  (kbd "C-h") 'evil-open-below
  (kbd "C-t") 'evil-open-above
  (kbd "C-c r") 'evil-record-macro
  ;; (kbd "C-w h") 'windmove-down
  ;; (kbd "C-w t") 'windmove-up
  ;; (kbd "C-w n") 'windmove-left
  ;; (kbd "C-w s") 'windmove-right
  "," 'undo-tree-undo
  "/" 'helm-swoop
  "'" 'evil-goto-mark
  "Q" 'anzu-query-replace-regexp
  (kbd "q") '(lambda ()
               "q saves the current buffer, then kills it.  I should add a checking mechanism... If the buffer name starts and ends with *, then do not save the buffer"
               (interactive)
               (save-buffer)
               (let (kill-buffer-query-functions) (kill-buffer)))
  (kbd "<backspace>") 'ace-jump-char-mode
  (kbd "l") 'recenter-top-bottom
  ;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
  ;;at least so the documentation claimed
  (kbd "<return>") 'newline-and-indent
  (kbd "SPC") 'viper-space
  (kbd "a") 'evil-first-non-blank
  (kbd "A") 'evil-insert-line
  (kbd "u") 'evil-end-of-line
  (kbd "U") 'evil-append-line
  (kbd "C-d") 'delete-char
  (kbd "<") 'beginning-of-buffer
  (kbd ">") 'end-of-buffer
  (kbd "l") 'recenter-top-bottom
  ;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
  (kbd "<return>") 'newline-and-indent
  (kbd "SPC") 'viper-space
  (kbd "C-a") 'mark-whole-buffer)


(evil-define-key 'insert evil-dvorak-mode-map (kbd "C-i") 'info-display-manual
  ;; this should prevent making the escape key moving the cursor backwards but...
  ;; (evil-define-key viper-insert-global-user-map
  ;;   (kbd "ESC") '(lambda()
  ;;               (viper-intercept-ESC-key)
  ;;               (forward-char)))
  (kbd "C-z") 'evil-normal-state
  (kbd "ESC") 'evil-normal-state
  (kbd "C-d") 'delete-char
  (kbd "<backspace>") 'delete-backward-char
  (kbd "<return>") 'newline-and-indent
  (kbd "C-h") 'next-line
  (kbd "C-t") 'previous-line
  (kbd "C-n") 'backward-char
  (kbd "C-s") 'forward-char
  (kbd "C-i") 'info-display-manual
  (kbd "C-c r") 'evil-record-macro)

;; I would like to use these, but they do not work well with golden-ratio-mode
;;(evil-define-key 'emacs (kbd "C-w h") 'evil-window-down)
;;(evil-define-key 'emacs (kbd "C-w t") 'evil-window-up)
;;(evil-define-key 'emacs (kbd "C-w n") 'evil-window-left)
(define-key evil-emacs-state-map (kbd "C-w h") 'windmove-down)
(define-key evil-emacs-state-map (kbd "C-w t") 'windmove-up)
(define-key evil-emacs-state-map (kbd "C-w n") 'windmove-left)
(define-key evil-emacs-state-map (kbd "C-w s") 'windmove-right)

(defun evil-dvorak-turn-off-web-mode-key ()
  "This turns off the evil-dvorak web-mod keyboard shortcuts."
  (interactive)
  (remove-hook 'web-mode-hook 'evil-dvorak-turn-on-web-mode-keys)
  (define-key evil-normal-state-map "H" 'evil-window-top))

(defun evil-dvorak-turn-on-web-mode-keys ()
  "This turns on the evil-dvorak web-mode keyboard shortcuts."
  (interactive)
  (define-key evil-normal-state-map (kbd "Hta") 'web-mode-tag-attributes-sort)
  (define-key evil-normal-state-map (kbd "Htb") 'web-mode-tag-beginning)
  (define-key evil-normal-state-map (kbd "Hte") 'web-mode-tag-end)
  (define-key evil-normal-state-map (kbd "Htm") 'web-mode-tag-match)
  (define-key evil-normal-state-map (kbd "Htn") 'web-mode-tag-next)
  (define-key evil-normal-state-map (kbd "Htp") 'web-mode-tag-previous)
  (define-key evil-normal-state-map (kbd "Hts") 'web-mode-tag-select)
  (define-key evil-normal-state-map (kbd "Hek") 'web-mode-element-kill)
  (define-key evil-normal-state-map (kbd "Hev") 'web-mode-element-vanish)
  (define-key evil-normal-state-map (kbd "Hea") 'web-mode-element-content-select)
  (define-key evil-normal-state-map (kbd "Hec") 'web-mode-element-clone)
  (define-key evil-normal-state-map (kbd "Heb") 'web-mode-element-beginning)
  (define-key evil-normal-state-map (kbd "Hed") 'web-mode-element-child)
  (define-key evil-normal-state-map (kbd "Hee") 'web-mode-element-end)
  (define-key evil-normal-state-map (kbd "Hef") 'web-mode-element-children-fold-or-unfold)
  (define-key evil-normal-state-map (kbd "Hei") 'web-mode-element-insert)
  (define-key evil-normal-state-map (kbd "Hem") 'web-mode-element-mute-blanks)
  (define-key evil-normal-state-map (kbd "Hen") 'web-mode-element-next)
  (define-key evil-normal-state-map (kbd "Hep") 'web-mode-element-previous)
  (define-key evil-normal-state-map (kbd "Her") 'web-mode-element-rename)
  (define-key evil-normal-state-map (kbd "Hes") 'web-mode-element-select)
  (define-key evil-normal-state-map (kbd "Het") 'web-mode-element-transpose)
  (define-key evil-normal-state-map (kbd "Heu") 'web-mode-element-parent)
  (define-key evil-normal-state-map (kbd "Hew") 'web-mode-element-wrap)
  (define-key evil-normal-state-map (kbd "Hab") 'web-mode-attribute-beginning)
  (define-key evil-normal-state-map (kbd "Hae") 'web-mode-attribute-end)
  (define-key evil-normal-state-map (kbd "Hai") 'web-mode-attribute-insert)
  (define-key evil-normal-state-map (kbd "Hak") 'web-mode-attribute-kill)
  (define-key evil-normal-state-map (kbd "Han") 'web-mode-attribute-next)
  (define-key evil-normal-state-map (kbd "Has") 'web-mode-attribute-select)
  (define-key evil-normal-state-map (kbd "Hat") 'web-mode-attribute-transpose))

(if (equal evil-dvorak-use-for-web-mode 1)
    (add-hook 'web-mode-hook 'evil-dvorak-turn-on-web-mode-keys)
  (remove-hook 'web-mode-hook 'evil-dvorak-turn-on-web-mode-keys))

;; I should not set the initial state for various modes, because some evil
;; users might want dired to be loaded in evil-normal-state.
;; Set the default state for various buffers
;; (evil-set-initial-state 'dired-mode 'emacs)

(provide 'evil-dvorak)

;;; evil-dvorak.el ends here
