;;; fontawesome.el --- fontawesome utility

;; Copyright (C) 2015 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL: https://github.com/syohex/emacs-fontawesome
;; Version: 0.02
;; Package-Requires: ((helm "1.7.2") (cl-lib "0.5"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; fontawesome.el provides fontawesome(https://fortawesome.github.io/Font-Awesome/) utilities.

;;; Code:

(require 'cl-lib)
(require 'fontawesome-data)

(declare-function helm "helm")

(defsubst fontawesome--font-names ()
  (cl-loop for (name . _code) in fontawesome-alist
           collect name))

(defun fontawesome--completing-read ()
  (let ((comp-func (if ido-mode 'ido-completing-read 'completing-read)))
    (funcall comp-func "Font name: " (fontawesome--font-names) nil t)))

;;;###autoload
(defun fontawesome (font-name)
  "Return fontawesome code point"
  (interactive
   (list (fontawesome--completing-read)))
  (assoc-default font-name fontawesome-alist))

(defun fontawesome--propertize (glyph)
  (propertize glyph
              'face '(:family "FontAwesome" :height 1.5)))

(defun fontawesome---source (fontawesome-alist)
  "return a source for helm selection"
  `((name . "Select FontAwesome Icon: ")
    (candidates . ,(mapcar (lambda (fontawesome)
                             (cons (concat (car fontawesome)
                                           " -> "
                                           (fontawesome--propertize
                                            (cdr fontawesome)))
                                   (cdr fontawesome)))
                           fontawesome-alist))
    (action . (lambda (candidate)
                (insert (fontawesome--propertize
                         candidate))))))

;;;###autoload
(defun helm-fontawesome ()
  (interactive)
  (helm :sources (fontawesome---source fontawesome-alist)))

(provide 'fontawesome)

;;; fontawesome.el ends here
