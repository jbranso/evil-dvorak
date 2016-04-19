With evil-dvorak you can use emacs's evil mode with bindings, that are friendly to the dvorak keyboard.  (If your keyboard in the top
left reads "qwerty", then you are using the qwerty keyboard). Why would you want to use the dvorak keyboard instead of qwerty?
Because the qwerty layout is an outdated keyboard layout.  It was designed for typewriters.  In those days, if you pressed two keys
together too soon, the keys would very likely stick together.  To decrease the chance of keys getting stuck whilst typing, the qwerty
keyboard layout was designed.  It's design goal is to spead out keys that are likely to be pressed often.  This means that when you
type, your fingers move a good distance between key presses.

The dvorak keyboard has a different goal in mind.  It puts keys, that are often used, side by side.  Do some research for yourself
and see if you want to make the switch.

Also, you might ask, why would someone want to have a vim experience inside emacs?  Because vim's modal editing experience is pretty
awesome!  You can learn more about how to efficiently learn vim here: http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html

I have recently reworked much of evil-dvorak to require only evil.  The only keys that I have changed the default keybindings are
 "h", "t", "n", "s", "k", "K", "j", "J", which you can find more details below.


### Installation

You can install evil-dvorak from melpa.

```
M-x package-install RET evil-dvorak
```

Then add this to your emacs config file (init.el).

```
(require 'evil-dvorak)
(global-evil-dvorak-mode 1)
```

Or if you prefer use-package, like me, then you can install evil-dvorak like so
```
(use-package evil
  :ensure t
  ;;If you diminish undo-tree mode, then you diminish evil-mode
  ;; I see the evil thing in the mode line on an org buffer, BUT not in an emacs lisp buffer
  :diminish undo-tree-mode
  :config (evil-mode 1))

(use-package evil-dvorak
  :ensure t
  :config (global-evil-dvorak-mode 1)
  :diminish evil-dvorak-mode)
```

### Configuration

One can easily rebind keys in evil dvorak.  Suppose you wish to bind "l" in normal state to (recenter-top-bottom) and "Q" to
(anzu-query-replace-regexp).  In insert state you wish to bind "C-d" to (delete-char), and "C-z" to (evil-normal-state). In visual
state you wish to bind "o" (evil-backward-word-begin) and "e" to (evil-forward-word-begin).  You should just modify evil-dvorak's mode map like so:

```
(defun my-evil-dvorak-customizations ()
  "My helpful evil-dvorak customizations"
  (interactive)
  ;;normal mode customizations
  (evil-define-key 'normal evil-dvorak-mode-map
    (kbd "l") 'recenter-top-bottom
    (kbd "Q") 'anzu-query-replace-regexp)

  ;;insert mode customizations
  (evil-define-key 'insert evil-dvorak-mode-map
    (kbd "C-d") 'delete-char
    (kbd "C-z") 'evil-normal-state)

  (evil-define-key 'visual evil-dvorak-mode-map
    (kbd "o") 'evil-backward-word-begin
    (kbd "e") 'evil-forward-word-begin))


(use-package evil-dvorak
  :ensure t
  :config
  (global-evil-dvorak-mode 1)
  (my-evil-dvorak-customizations))

```


### Keymap

#### In normal mode

Keybinding             | Description
-----------------------|------------------------------------------------------------
<kbd> h </kbd>         | move the cursor one line up
<kbd> t </kbd>         | move the cursor one line down
<kbd> n </kbd>         | move the cursor one character to the left
<kbd> s </kbd>         | move the cursor one character to the right
<kbd> k </kbd>         | kill from point to the end of the line
<kbd> K </kbd>         | kill from point to the beginning of the line
<kbd> j </kbd>         | join the lower line to the end of this line
<kbd> J </kbd>         | join the current line the end of the previous line
<kbd> C-h </kbd>       |  insert a new line below point and switch to insert state
<kbd> C-t </kbd>       | insert a new line above point and switch to insert state.  The reader should not that this conflicts with the emacs binding of (transpose-chars), which I have personally rebound to (global-set-key (kbd "C-c t") 'transpose-chars)
