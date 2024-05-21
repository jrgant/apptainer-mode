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

(defvar apptainer-boxed-headers nil
  "Whether to draw a box around header keywords in Apptainer files.")

(defvar apptainer-filled-headers nil
  "Whether to fill header keywords in Apptainer files.")

(defvar apptainer-boxed-links nil
   "Whether to draw a box around URLs in Apptainer files.
Defaults to non-nil. If nil, URLs will be underlined.")

(defvar apptainer-boxed-sections nil
  "Whether to draw a box around section headers in Apptainer files.")

(defvar apptainer-filled-sections nil
  "Whether to fill section headers in Apptainer files.")


;;;; Define faces

(defface apptainer-header-keyword-face
  '((t :inherit font-lock-keyword-face :weight bold))
  "Face for Apptainer headers."
  :group 'apptainer-faces)

(defface apptainer-boxed-header-keyword-face
  '((t :inherit apptainer-header-keyword-face :box t))
  "Face for boxed Apptainer headers."
  :group 'apptainer-faces)

(defface apptainer-filled-header-keyword-face
  '((t :inherit font-lock-keyword-face :inverse-video t))
  "Face for Apptainer headers."
  :group 'apptainer-faces)

(defface apptainer-section-face
  '((t :inherit font-lock-constant-face :weight bold))
  "Face for Apptainer section headings."
  :group 'apptainer-faces)

(defface apptainer-boxed-section-face
  '((t :inherit apptainer-section-face :box t))
  "Face for boxed Apptainer section headings."
  :group 'apptainer-faces)

(defface apptainer-filled-section-face
  '((t :inherit apptainer-section-face :inverse-video t))
  "Face for filled Apptainer section headings."
  :group 'apptainer-faces)

(defface apptainer-boxed-link-face
  '((t :inherit default :box t))
  "Face for URLs. Boxed."
  :group 'apptainer-faces)

(defface apptainer-underline-link-face
  '((t :inherit link :underline t))
  "Face for URLs. Underlined."
  :group 'apptainer-faces)

(defface apptainer-retriever-face
  '((t :inherit font-lock-builtin-face :slant italic))
  "Face for `$` indicating environmental variable retrieval."
  :group 'apptainer-faces)


;;;; Define font-lock keywords and set face options

(defconst apptainer-header-keyword-face
  (if (and apptainer-boxed-headers apptainer-filled-headers)
      (error "Can have only one of apptainer-boxed-headers or apptainer-filled-headers set")
    (if apptainer-boxed-headers 'apptainer-boxed-header-keyword-face
      (if apptainer-filled-headers 'apptainer-filled-header-keyword-face
        'apptainer-header-keyword-face))))

(defconst apptainer-link-face
  (if apptainer-boxed-links 'apptainer-boxed-link-face 'apptainer-underline-link-face))

(defconst apptainer-section-face
  (if (and apptainer-boxed-sections apptainer-filled-sections)
      (error "Can have only one of apptainer-boxed-sections or apptainer-filled-sections set")
    (if apptainer-boxed-sections 'apptainer-boxed-section-face
      (if apptainer-filled-sections 'apptainer-filled-section-face 'apptainer-section-face))))

(defconst apptainer-mode-font-lock-keywords
  '(("^[[:alnum:]]+:" . apptainer-header-keyword-face)
    ("^%[[:alnum:]]+" . apptainer-section-face)
    ("\\(\\(https\\|http\\)://\\S-+\\)\\|\\(\\S-+\\@\\S-+\\.[[:alpha:]]+\\)" . apptainer-link-face)
    ("\\(\\$\\)" . 'apptainer-retriever-face)))


;;;; Define mode

;;;###autoload
(define-derived-mode apptainer-mode sh-mode "Apptainer"
  "Major mode for editing Apptainer definition files."
  (font-lock-add-keywords 'apptainer-mode apptainer-mode-font-lock-keywords))

(provide 'apptainer-mode)
;;; apptainer-mode.el ends here
