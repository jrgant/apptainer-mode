# apptainer-mode

![Release](https://img.shields.io/badge/Release-v0.1-green)
![Status](https://img.shields.io/badge/Status-Developing-orange)
![Dev](https://img.shields.io/badge/Dev-main-blue)

A simple major mode for [Apptainer definition files](https://apptainer.org/docs/user/main/definition_files.html).

Derived from `sh-mode`, `apptainer-mode` implements basic font-locking for definition (`.def`) file headers and section labels.

<br />
<p align="center">
  <img src="example.png" width="60%" />
</p>


## Installation

To download the **release** version, download it from the Releases section and unpack the archive.

To download the **development** version, run the following snippet, filling in the desired destination path:

``` emacs-lisp
git clone https://github.com/jrgant/apptainer-mode </path/to/destination>
```

In either case, add `apptainer-mode` using one of the following:

``` emacs-lisp
(load-file "/path/to/apptainer-mode.el")

;; OR
(use-package
  :load-path "/path/to/apptainer-mode/")
```
