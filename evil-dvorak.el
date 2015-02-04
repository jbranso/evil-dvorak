;;; evil-dvorak.el  ---  allows you to use evil with appropriate dvorak bindings

;; Copyright (C) 2015 Joshua Branson
;; Author: Joshua Branson
;; Package-Requires: ((evil  "1.0.8"))
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

;; (evil-define-key 'motion evil-dvorak-mode-map "n" 'evil-backward-char
;;   "s" 'evil-forward-char
;;   "s" 'evil-forward-char
;;   "t" 'evil-previous-line
;;   "h" 'evil-next-line
;;   "u" 'evil-end-of-line
;;   "a" 'evil-first-non-blank
;;   "o" 'evil-backward-word-begin
;;   "e" 'evil-forward-word-begin)

;; (evil-define-key 'operator evil-dvorak-mode-map "s" 'evil-forward-char
;;   "n" 'evil-backward-char
;;   "t" 'evil-previous-line
;;   "h" 'evil-next-line
;;   ;;(evil-define-key 'operator "u" 'evil-end-of-line)
;;   ;;(evil-define-key 'operator "a" 'evil-first-non-blank)
;;   "o" 'evil-backward-word-begin
;;   "e" 'evil-forward-word-begin
;;   "O" 'evil-backward-WORD-end
;;   "E" 'evil-forward-WORD-end
;;   (kbd "<backspace>") 'ace-jump-char-mode)

(evil-define-key 'visual evil-dvorak-mode-map "s" 'evil-forward-char
  "n" 'evil-backward-char
  "t" 'evil-previous-line
  "h" 'evil-next-line
  ;;I what to be able to use vaw (visual around word)
  ;;(evil-define-key 'visual "u" 'evil-end-of-line)
  ;;(evil-define-key 'visual "a" 'evil-first-non-blank
  "o" 'evil-backward-word-begin
  "e" 'evil-forward-word-begin
  "O" 'evil-backward-WORD-end
  "E" 'evil-forward-WORD-end
  (kbd "<backspace>") 'ace-jump-char-mode
  (kbd ";") 'comment-dwim)

;; I don't know how to make use of this map.
;; (evil-define-key 'replace evil-dvorak-mode-map

(evil-define-key 'normal evil-dvorak-mode-map
  "k" 'kill-line
  "K" #'(lambda () (interactive)
          "kill from point to the beginning of the line"
          (kill-line 0))
  (kbd "I") 'evil-append
  "$" 'ispell-word
  (kbd "C-s") 'evil-substitute
  "s" 'evil-forward-char
  "n" 'evil-backward-char
  "t" 'evil-previous-line
  "h" 'evil-next-line
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
  (kbd ";") 'comment-dwim
  (kbd "C-c r") 'evil-record-macro
  (kbd "C-w h") 'windmove-down
  (kbd "C-w t") 'windmove-up
  (kbd "C-w n") 'windmove-left
  (kbd "C-w s") 'windmove-right
  "," 'undo-tree-undo
  "/" 'helm-swoop
  "'" 'evil-goto-mark
  "Q" 'query-replace
  (kbd "q") '(lambda ()
               "q saves the current buffer, then kills it.  I should add a checking mechanism... If the buffer name starts and ends with *, then do not save the buffer"
               (interactive)
               (save-buffer)
               (let (kill-buffer-query-functions) (kill-buffer)))
  (kbd "<backspace>") 'ace-jump-char-mode
  (kbd "l") 'recenter-top-bottom
  ;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
  (kbd "<return>") 'newline
  (kbd "SPC") 'viper-space
  (kbd "C-a") 'mark-whole-buffer
  (kbd "a") 'evil-first-non-blank
  (kbd "A") 'evil-insert-line
  (kbd "u") 'evil-end-of-line
  (kbd "U") 'evil-append-line
  (kbd "C-d") 'delete-char
  (kbd "<") 'beginning-of-buffer
  (kbd ">") 'end-of-buffer
  (kbd "l") 'recenter-top-bottom
  ;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
  (kbd "<return>") 'newline
  (kbd "SPC") 'viper-space
  (kbd "C-a") 'mark-whole-buffer
  (kbd "C-d") 'delete-char)


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
  (kbd "C-z") 'evil-normal-state
  (kbd "C-c r") 'evil-record-macro)

;; I would like to use these, but they do not work well with golden-ratio-mode
;;(evil-define-key 'emacs (kbd "C-w h") 'evil-window-down)
;;(evil-define-key 'emacs (kbd "C-w t") 'evil-window-up)
;;(evil-define-key 'emacs (kbd "C-w n") 'evil-window-left)
(define-key evil-emacs-state-map (kbd "C-w h") 'windmove-down)
(define-key evil-emacs-state-map (kbd "C-w t") 'windmove-up)
(define-key evil-emacs-state-map (kbd "C-w n") 'windmove-left)
(define-key evil-emacs-state-map (kbd "C-w s") 'windmove-right)

;; Set the default state for various buffers
(evil-set-initial-state 'dired-mode 'emacs)
(evil-set-initial-state 'snake-mode 'emacs)
(evil-set-initial-state 'eshell-mode 'emacs)
(evil-set-initial-state 'term-mode 'emacs)
;;This next one is working or not?
(evil-set-initial-state 'git-mode 'emacs)

(provide 'evil-dvorak)

;;; evil-dvorak.el ends here
