;;; apptainer-mode.el --- Major mode for Apptainer definition files -*- lexical-binding: t; -*-

;; Copyright (c) 2024 Jason Gantenberg
;; Author: Jason Gantenberg <jason.gantenberg@gmail.com>
;; Package-Requires: ((emacs "29.3"))
;; Homepage: https://github.com/jrgant/apptainer-mode
;; Version: 0.1
;; Keywords: apptainer languages processes tools

;; This file is not part of GNU Emacs.

;;; License:

;; APPTAINER-MODE is licensed under the GNU General Public License version 3,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; See <https://www.gnu.org/licenses/> and or the package repository's
;; <https://github.com/jrgant/apptainer-mode/blob/main/LICENSE> for more information.

;;; Commentary:

;; This package provides a major mode for editing Apptainer definition files.

;;; Code:

(require 'rx)

(defgroup apptainer nil
  "Major mode for editing Apptainer definition files."
  :prefix "apptainer-"
  :group 'languages)

(defgroup apptainer-faces nil
  "Faces used in Apptainer mode."
  :group 'apptainer
  :group 'faces)


;;;; Define variables

(defvar apptainer-bold-headers nil
  "Bold header keywords in Apptainer definitino files? Defaults to nil.")

(defvar apptainer-italic-headers nil
  "Italicize header keywords in Apptainer definitino files? Defaults to nil.")

(defvar apptainer-boxed-headers nil
  "Draw a box around header keywords in Apptainer definition files?
Defaults to nil.")

(defvar apptainer-filled-headers nil
  "Fill header keywords in Apptainer definition files? Defaults to nil.")

(defvar apptainer-bold-sections nil
  "Bold section headers in Apptainer definition files? Defaults to nil.")

(defvar apptainer-italic-sections nil
  "Italicize section headers in Apptainer definition files? Defaults to nil.")

(defvar apptainer-boxed-sections nil
  "Draw a box around section headers in Apptainer definition files?
Defaults to nil.")

(defvar apptainer-filled-sections nil
  "Fill section headers in Apptainer definition files? Default to nil.")

(defvar apptainer-boxed-links nil
  "Draw a box around URLs in Apptainer files? Defaults to nil.")

(defvar apptainer-italic-retriever nil
  "Italicize `$`. Typically used for retrieving environmental variables.
Defaults to nil.")


;;;; Define faces

(defface apptainer-header-keyword-face
  '((t :inherit font-lock-keyword-face))
  "Face for Apptainer headers."
  :group 'apptainer-faces)

(defface apptainer-section-face
  '((t :inherit font-lock-constant-face))
  "Face for Apptainer section headings."
  :group 'apptainer-faces)

(defface apptainer-link-face
  '((t :inherit link))
  "Face for URLs. Underlined."
  :group 'apptainer-faces)

(defface apptainer-retriever-face
  '((t :inherit font-lock-builtin-face))
  "Face for `$` indicating environmental variable retrieval."
  :group 'apptainer-faces)


;;;; Set face options

(if apptainer-bold-headers
        (set-face-attribute 'apptainer-header-keyword-face nil :bold t))

(if apptainer-italic-headers
        (set-face-attribute 'apptainer-header-keyword-face nil :italic t))

(if apptainer-boxed-headers
        (set-face-attribute 'apptainer-header-keyword-face nil :box t))

(if apptainer-filled-headers
        (set-face-attribute 'apptainer-header-keyword-face nil :inverse-video t))

(if apptainer-bold-sections
        (set-face-attribute 'apptainer-section-face nil :bold t))

(if apptainer-italic-sections
        (set-face-attribute 'apptainer-section-face nil :italic t))

(if apptainer-boxed-sections
        (set-face-attribute 'apptainer-section-face nil :box t))

(if apptainer-filled-sections
        (set-face-attribute 'apptainer-section-face nil :inverse-video t))

(if apptainer-boxed-links
        (set-face-attribute 'apptainer-link-face nil :box t))

(if apptainer-italic-retriever
        (set-face-attribute 'apptainer-retriever-face nil :italic t))


;;;; Define font-lock keywords

(defconst apptainer-mode-font-lock-keywords
  '(("^[[:alnum:]]+:" . 'apptainer-header-keyword-face)
    ("^%[[:alnum:]]+" . 'apptainer-section-face)
    ("\\(\\(https\\|http\\)://\\S-+\\)\\|\\(\\S-+\\@\\S-+\\.[[:alpha:]]+\\)" . 'apptainer-link-face)
    ("\\(\\$\\)" . 'apptainer-retriever-face)))

;;;; Define mode

;;;###autoload
(define-derived-mode apptainer-mode sh-mode "Apptainer"
  "Major mode for editing Apptainer definition files."
  (font-lock-add-keywords 'apptainer-mode apptainer-mode-font-lock-keywords))

(provide 'apptainer-mode)
;;; apptainer-mode.el ends here
