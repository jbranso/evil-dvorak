;;; evil-dvorak.el --- allows you to use evil with appropriate dvorak bindings

;; Copyright (C) 2015 Joshua Branson
;; Author: Joshua Branson
;; Package-Requires: ((evil  "1.0.8"))
;; Created: January 30 2015
;; Keywords:  dvorak evil vim
;; Version: 0.2

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
  "Global mode to let you use evil with dvorak friendly keybindings.")

(evil-define-key 'visual evil-dvorak-mode-map
  "t" 'evil-next-line
  "h" 'evil-previous-line
  "n" 'evil-backward-char
  "s" 'evil-forward-char
  ;;I what to be able to use vaw (visual around word) and viw (visual inner word)
  ;; that's why in visual mode, u and a are not defined.
  ;; BUT it would be cool to say cie and mean change forward to word-end
  ;; and cio to mean change backward word-end
  ;;(evil-define-key 'visual "u" 'evil-end-of-line)
  ;;(evil-define-key 'visual "a" 'evil-first-non-blank
  ;;(evil-define-key 'visual "u" 'evil-end-of-line)
  )

(evil-define-key 'normal evil-dvorak-mode-map
  ;; Miscellancus
  (kbd "t") #'evil-next-line
  (kbd "h") #'previous-line
  (kbd "n") #'backward-char
  (kbd "s") #'forward-char
  "k" 'kill-line
  "K" #'(lambda () (interactive)
          "kill from point to the beginning of the line"
          (kill-line 0))

  ;;move the cursor around
  (kbd "C-l") 'recenter-top-bottom

  ;;line manipulation
  "J" 'join-line
  "j" #'(lambda () (interactive)
          "join this line at the end of the line below"
          (join-line 1))
  (kbd "C-h") 'evil-open-below
  (kbd "C-t") 'evil-open-above
  "'" 'evil-goto-mark
  ;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
  (kbd "<return>") 'newline-and-indent)

(evil-define-key 'insert evil-dvorak-mode-map
  (kbd "C-z") 'evil-normal-state
  (kbd "ESC") 'evil-normal-state
  (kbd "C-d") 'delete-char
  (kbd "<backspace>") 'delete-backward-char
  (kbd "<return>") 'newline-and-indent
  (kbd "C-h") 'evil-next-line
  (kbd "C-t") 'evil-previous-line
  (kbd "C-n") 'backward-char
  (kbd "C-s") 'forward-char)

(provide 'evil-dvorak)

;;; evil-dvorak.el ends here
