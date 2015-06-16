# fontawesome [![melpa badge][melpa-badge]][melpa-link] [![melpa stable badge][melpa-stable-badge]][melpa-stable-link]

Emacs [fontawesome](http://fortawesome.github.io/Font-Awesome/) utility.

## Requirements

- fontawesome font

## Function

#### `(fontawesome font-name)`

Return code point of `font-name`.
This function is interactive function, so you can call it by `M-x fontawesome`.

#### `M-x helm-fontawesome`

Insert fontawesome font with helm interface


## Sample

```lisp
(insert (propertize (fontawesome "github")
        'face '(:family "FontAwesome")))

(defun insert-fontawesome ()
  (interactive)
  (insert (call-interactively 'fontawesome)))
```

[melpa-link]: http://melpa.org/#/fontawesome
[melpa-stable-link]: http://stable.melpa.org/#/fontawesome
[melpa-badge]: http://melpa.org/packages/fontawesome-badge.svg
[melpa-stable-badge]: http://stable.melpa.org/packages/fontawesome-badge.svg
