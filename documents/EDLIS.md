# Edlis
Edlis is a simple editor for ISLisp. Edlis is subset Edwin.

![Edlis](screen6.png)

## Note
Edlis supports Unicode from ver2.57.

## Invocation
`(edit filename)` in the REPL.

## Commands

| Key           | Command                 |
| ------------- | ------------------------|
| CTRL+X CTRL+S | Save file               |
| CTRL+X CTRL+C | Quit editor with save   |
| CTRL+X CTRL+I | Insert file             |
| CTRL+X CTRL+Z | Quit editor without save|

## Editing
The key bindings are a hybrid of Emacs and nano.

| Key       | Binding                         |
| --------- | ------------------------------- |
| Enter     | Automatically indent for Lisp   |
| Insert    | Switch between insert/overwrite |
| Tab       | Insert tab for Lisp             |
| BackSpace | Delete previous char            |
| Delete    | Delete next char                |
| CTRL+F    | Move right                      |
| CTRL+B    | Move left                       |
| CTRL+P    | Move up                         |
| CTRL+N    | Move down                       |
| CTRL+J    | End of line                     |
| CTRL+D    | Delete                          |
| CTRL+H    | Backspace                       |
| CTRL+A    | Beginning of line               |
| CTRL+E    | End of line                     |
| CTRL+V    | Page down                       |
| ESC V     | Page up                         |
| CTRL+K    | Cut selection                   |
| CTRL+U    | Uncut selection                 |
| CTRL+L    | Go to line                      |
| CTRL+S    | Search for word foward          |
| CTRL+R    | Search for word backward        |
| CTRL+T    | Replace word                    |
| ESC TAB   | Complete builtin function or syntax |
| ESC <     | Goto top page                   |
| ESC >     | Goto end page                   |
| ESC CTRL+F| Move right in S-exp units       |
| ESC CTRL+B| Move left in S-exp units        |
| ESC CTRL+N| Move right in list units        |
| ESC CTRL+P| Move left in list units         |
| ESC CTRL+U| Move up in list structure       |
| ESC CTRL+D| Move down in list structure     |
| ESC ^     | Mark (or unmark) row for selection. "ESC ^" marks the current row, then cursor up or down selects rows. "ESC ^" again unmarks.|
| ←　→　↑　↓　| Usual cursor movement          |
| Home      | Display top page                |
| End       | Display end page                |
| PageUp    | Page up                         |
| PageDown  | Page down                       |


# Spec 

- main buffer  row-size  5000, col-size 256 (defined in edlis.h)
- sub buffer  row-size 1000, col-size 256 (defined in edlis.h)

