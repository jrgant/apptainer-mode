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


;;;; Define faces

(defface apptainer-header-keyword-face
  '((t :inherit font-lock-keyword-face :weight bold))
  "Face for Apptainer headers."
  :group 'apptainer-faces)

(defface apptainer-section-face
  '((t :inherit font-lock-constant-face :weight bold))
  "Face for Apptainer sections."
  :group 'apptainer-faces)

  '((t :inherit default :box t))
  "Face for URLs."
  :group 'apptainer-faces)

(defface apptainer-retriever-face
  '((t :inherit font-lock-builtin-face :slant italic))
  "Face for `$` indicating environmental variable retrieval."
  :group 'apptainer-faces)


;;;; Define font-lock keywords

(defconst apptainer-mode-font-lock-keywords
  '(("^[[:alnum:]]+:" . 'apptainer-header-keyword-face)
    ("^%[[:alnum:]]+" . 'apptainer-section-face)
    ("\\(\\(https\\|http\\)://\\S-+\\)\\|\\(\\S-+\\@\\S-+\\.[[:alpha:]]+\\)" . apptainer-link-face)
    ("\\(\\$\\)" . 'apptainer-retriever-face)))


;;;; Define mode

;;;###autoload
(define-derived-mode apptainer-mode sh-mode "Apptainer"
  "Major mode for editing Apptainer definition files."
  (font-lock-add-keywords 'apptainer-mode apptainer-mode-font-lock-keywords))

(provide 'apptainer-mode)
;;; apptainer-mode.el ends here
