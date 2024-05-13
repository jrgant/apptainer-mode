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

(defconst apptainer-header-keyword-face 'apptainer-header-keyword-face)
(defface apptainer-header-keyword-face
  '((t :inherit font-lock-keyword-face :weight bold))
  "Face for Apptainer headers."
  :group 'apptainer-faces)

(defconst apptainer-section-face 'apptainer-section-face)
(defface apptainer-section-face
  '((t :inherit font-lock-constant-face :weight bold))
  "Face for Apptainer sections."
  :group 'apptainer-faces)

(defconst apptainer-link-face 'apptainer-link-face)
(defface apptainer-link-face
  '((t :foreground "PowderBlue" :underline t))
  "Face for URLs."
  :group 'apptainer-faces)

(defconst apptainer-retriever-face 'apptainer-retriever-face)
(defface apptainer-retriever-face
  '((t :inherit font-lock-builtin-face :slant italic))
  "Face for `$` indicating environmental variable retrieval."
  :group 'apptainer-faces)

(defconst apptainer-linebreak-face 'apptainer-linebreak-face)
(defface apptainer-linebreak-face
  '((t :inherit apptainer-header-keyword-face :weight normal))
  "Face for linebreaks."
  :group 'apptainer-faces)

(defconst apptainer-envvar-face 'apptainer-envvar-face)
(defface apptainer-envvar-face
  '((t :inherit font-lock-variable-name-face))
  "Face for APPTAINER environmental variables."
  :group 'apptainer-faces)


;;;; Define regexes and font-locking

(defconst apptainer--font-lock-defaults
  `((("^[[:alnum:]]+:" 0 apptainer-header-keyword-face)
     ("^%[[:alnum:]]+" 0 apptainer-section-face)
     ("#.*" 0 font-lock-comment-face)
     ("\\(https\\|http\\)://\\S-+" 0 apptainer-link-face)
     ("\\(\\$\\)" 0 apptainer-retriever-face)
     ("\\\\$" 0 apptainer-linebreak-face)
     ("APPTAINER_[[:alpha:]]+" 0 apptainer-envvar-face))))


;;;###autoload
(define-derived-mode apptainer-mode sh-mode "Apptainer"
  "Major mode for editing Apptainer definition files."
  (setq font-lock-defaults apptainer--font-lock-defaults))

(provide 'apptainer-mode)

;;; apptainer-mode.el ends here
