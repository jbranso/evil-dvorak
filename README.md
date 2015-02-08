With evil-dvorak you can use emacs's evil mode with bindings, that are friendly to the dvorak keyboard.  (If your keyboard in the top
left reads "qwerty", then you are using the qwerty keyboard). Why would you want to use the dvorak keyboard instead of qwerty?
Because the qwerty layout is an outdated keyboard layout.  It was designed for typewriters.  In those days, if you pressed two keys
together too soon, the keys would very likely stick together.  To decrease the chance of keys getting stuck while typing, the qwerty
keyboard layout was designed.  It's design goal is to spead out keys that are likely to be pressed often.  This means that when you
type, your fingers move a good distance between key presses.

The dvorak keyboard has a different goal in mind.  It puts keys, that are ofter used, side by side.  Do some research for yourself and
see if you want to make the switch.

You can install evil-dvorak from melpa.

```
M-x package-install RET evil-dvorak
```

Then add this to your emacs config file (init.el).

```
(require 'evil-dvorak)
(global-evil-dvorak-mode 1)
```

### Configuration

I like evil-next-line and evil-previous-line to be bound to h and t respectively, which is NOT how vim does it.  If you wish to try my
alternative to vim's layout, write this in your config.

```
(setq evil-dvorak-funky-h-and-t 1)
(require 'evil-dvorak)
(global-evil-dvorak-mode 1)
```

Evil-dvorak also provide you with a way to use web-mode keys with the prefix key: "H".  So "Hak" kills the current attribute and "Hev"
vanishes the current html element.  If you would like to use this, set up evil-dvorak like this:

```
(setq evil-dvorak-use-for-web-mode 1)
(require 'evil-dvorak)
(global-evil-dvorak-mode 1)
```

### Keymap

#### In normal mode

Keybinding         | Description
-------------------|------------------------------------------------------------
<kbd> h </kbd>   | move the cursor one line up
<kbd> t </kbd>     | move the cursor one line down
<kbd> n </kbd>     | move the cursor one character to the left
<kbd> s </kbd>   | move the cursor one character to the right
<kbd> o </kbd>     | move backward one word
<kbd> O </kbd>     | move backward one WORD
<kbd> e </kbd>   | move forward one word
<kbd> E </kbd>   | move forward one WORD
<kbd> a </kbd>   | move to the beginning of the line
<kbd> A </kbd>   | move to the beginning of the line and enter insert mode
<kbd> u </kbd> | move to the end of the line
<kbd> U </kbd> | move to the end of the line and enter insert mode
<kbd> backspace </kbd> | ace-jump-mode
<kbd> i </kbd>     | insert to the left of point
<kbd> I </kbd>   | insert to the right of point
<kbd> , </kbd> | undo last command
<kbd> . </kbd>     | redo last command
<kbd> $ </kbd> | check the spelling of the current word
<kbd> l </kbd>     | recenter the buffer (the same as C-l in emacs state)
<kbd> j </kbd>     | join the lower line to the end of this line
<kbd> J </kbd>   | join the current line the end of the previous line
<kbd> m KEY </kbd>     | mark the current spot in the buffer with KEY
<kbd> ' KEY </kbd> | go to the marked KEY in the buffer
<kbd> ; </kbd>     | comment-dwin. This is an emacs command that either adds a comment to the current line, or if the line is highlighted, then it comments out the line
<kbd> q </kbd>     | save and quit the current buffer. This is the same as (save-buffer) (kill-buffer)
<kbd> C-w [h \| t \| n \| s] </kbd>     |  move to the up, down, left, or right window.  The syntax [ h \| t \| n \| s ] means that you have to pick either h, t, n, s.  So the only valid commands are C-w h, C-w t, C-w n, C-w s
<kbd> C-c r </kbd> |  This begins to define an evil macro.  In emacs state the binding for this in C-x (
<kbd> C-h </kbd>   |  insert a new line below point and switch to insert state
<kbd> C-t </kbd>   | insert a new line above point and switch to insert state.  The reader should not that this conflicts with the emacs binding of (transpose-chars), which I have rebound to (global-set-key (kbd "C-c t") 'transpose-chars)
<kbd> spacebar  </kbd> |  inserts a space.
<kbd> \>  </kbd>  | move point to the beginning of the buffer
<kbd> \<  </kbd>  | move point to the end of the buffer
