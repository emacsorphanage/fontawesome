# fontawesome

Emacs [fontawesome](http://fortawesome.github.io/Font-Awesome/) utility.

## Requirements

- fontawesome font

## Function

#### `(fontawesome font-name)`

Return code point of `font-name`.
This function is interactive function, so you can call it by `M-x fontawesome`.

## Sample

```lisp
(insert (propertize (fontawesome "github")
        'face '(:family "FontAwesome")))

(defun insert-fontawesome ()
  (interactive)
  (insert (call-interactively 'fontawesome)))
```
