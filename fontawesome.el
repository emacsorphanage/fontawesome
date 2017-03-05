;;; fontawesome.el --- fontawesome utility

;; Copyright (C) 2017 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL: https://github.com/syohex/emacs-fontawesome
;; Version: 0.04
;; Package-Requires: ((emacs "24.4"))

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
(declare-function helm-build-sync-source "helm")
(declare-function ivy-read "ivy")

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

(defun fontawesome--construct-candidates ()
  (mapcar (lambda (fontawesome)
            (cons (concat (car fontawesome)
                          " -> "
                          (fontawesome--propertize
                           (cdr fontawesome)))
                  (cdr fontawesome)))
          fontawesome-alist))

(defun fontawesome---source (fontawesome-alist)
  (helm-build-sync-source "Select FontAwesome Icon: "
    :candidates (fontawesome--construct-candidates)
    :action (lambda (candidate)
              (insert (fontawesome--propertize candidate)))
    :candidate-number-limit 9999))

;;;###autoload
(defun helm-fontawesome ()
  (interactive)
  (require 'helm)
  (helm :sources (fontawesome---source fontawesome-alist)))

;;;###autoload
(defun counsel-fontawesome ()
  (interactive)
  (require 'ivy)
  (ivy-read "Font awesome> " (fontawesome--construct-candidates)
            :action (lambda (font)
                      (insert (cdr font)))))

(provide 'fontawesome)

;;; fontawesome.el ends here
