With evil-dvorak you can use emacs's evil mode with bindings, that are friendly to the dvorak keyboard.  (If your keyboard in the top
left reads "qwerty", then you are using the qwerty keyboard). Why would you want to use the dvorak keyboard instead of qwerty?
Because the qwerty layout is an outdated keyboard layout.  It was designed for typewriters.  In those days, if you pressed two keys
together too soon, the keys would very likely stick together.  To decrease the chance of keys getting stuck while typing, the qwerty
keyboard layout was designed.  It's design goal is to spead out keys that are likely to be pressed often.  This means that when you
type, your fingers move a good distance between key presses.

The dvorak keyboard has a different goal in mind.  It puts keys, that are ofter used, side by side.  Do some research for yourself and
see if you want to make the switch.

To install:

```

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
<kbd></kbd>     | Join two lines into one(`prelude-top-join-line`).
<kbd></kbd>   | Start `proced` (manage processes from Emacs; works only in Linux).
<kbd></kbd>   | Start `eshell`.
<kbd></kbd> | Start your default shell.
<kbd></kbd> | Alias for `M-x`.
<kbd></kbd>     | Like `M-x` but limited to commands that are relevant to the active major mode.
<kbd></kbd>   | Run `apropos` (search in all Emacs symbols).
<kbd></kbd> | Display key bindings of current major mode and descriptions of every binding.
<kbd></kbd>     | Run `hippie-expand` (a replacement for the default `dabbrev-expand`).
<kbd></kbd> | Open `ibuffer` (a replacement for the default `buffer-list`).
<kbd></kbd>     | Make the window full screen.
<kbd></kbd>     | Toggle the Emacs menu bar.
<kbd></kbd>   | Open Magit's status buffer.
<kbd></kbd>     | Zap up to char.
<kbd></kbd> or <kbd>Super-></kbd>   | Switch between buffers with [`ace-jump-buffer`](https://github.com/waymondo/ace-jump-buffer)
<kbd></kbd>     | Run `expand-region` (incremental text selection).
<kbd></kbd>     | Run `prelude-move-beginning-of-line`. Read [this](http://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/) for details.
