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
  "Draw a box around header keywords in Apptainer definition files?
Defaults to nil.")

(defvar apptainer-filled-headers nil
  "Fill header keywords in Apptainer definition files? Defaults to nil.")

(defvar apptainer-boxed-sections nil
  "Draw a box around section headers in Apptainer definition files?
Defaults to nil.")

(defvar apptainer-filled-sections nil
  "Fill section headers in Apptainer definition files? Default to nil.")

(defvar apptainer-boxed-faces nil
  "Draw a box around both section headers and header keywords in Apptainer files?
Defaults to nil.")

(defvar apptainer-filled-faces nil
  "Fill both section headers and header keywords in Apptainer definition files?
Defaults to nil.")

(defvar apptainer-boxed-links nil
   "Draw a box around URLs in Apptainer files? Defaults to nil.")



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


;;;; Define functions

(defun apptainer--check-face-conflicts ()
  "Check for conflicting Apptainer face settings."
  (if (or (and apptainer-boxed-headers (or apptainer-filled-headers apptainer-filled-faces)))
      (error "If \"apptainer-boxed-headers\" is non-nil, both \"apptainer-filled-headers\" and \"apptainer-filled-faces\" must be nil")
    nil)
  (if (or (and apptainer-boxed-sections (or apptainer-filled-sections apptainer-filled-faces)))
      (error "If \"apptainer-boxed-sections\" is non-nil, both \"apptainer-filled-sections\" and \"apptainer-filled-faces\" must be nil")
    nil)
  (if (or (and apptainer-filled-headers (or apptainer-boxed-headers apptainer-boxed-faces)))
      (error "If \"apptainer-filled-headers\" is non-nil, both \"apptainer-boxed-headers\" and \"apptainer-boxed-faces\" must be nil")
    nil)
  (if (or (and apptainer-filled-sections (or apptainer-boxed-sections apptainer-boxed-faces)))
      (error "If \"apptainer-filled-sections\" is non-nil, both \"apptainer-boxed-sections\" and \"apptainer-boxed-faces\" must be nil")
    nil)
  (if (and apptainer-boxed-faces apptainer-filled-faces)
      (error "If \"apptainer-boxed-faces\" is non-nil, \"apptainer-filled-faces\" must be nil, or vice versa")
    nil))


;;;; Define font-lock keywords and set face options

(apptainer--check-face-conflicts)

(defconst apptainer-header-keyword-face
  (if (or apptainer-boxed-headers apptainer-boxed-faces)
      'apptainer-boxed-header-keyword-face
    (or apptainer-filled-headers apptainer-filled-faces)
        'apptainer-filled-header-keyword-face
        'apptainer-header-keyword-face))

(defconst apptainer-section-face
  (if (or apptainer-boxed-sections apptainer-boxed-faces)
      'apptainer-boxed-section-face
    (or apptainer-filled-sections apptainer-filled-faces)
        'apptainer-filled-section-face
        'apptainer-section-face))

(defconst apptainer-link-face
  (if apptainer-boxed-links 'apptainer-boxed-link-face 'apptainer-underline-link-face))

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
