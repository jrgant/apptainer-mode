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

``` bash
git clone https://github.com/jrgant/apptainer-mode </path/to/destination>
```

In either case, add `apptainer-mode` using one of the following:

``` emacs-lisp
(load-file "/path/to/apptainer-mode.el")

;; OR, if you use `use-package`
(use-package
  :load-path "/path/to/apptainer-mode/")
```


## Options

The user can set a handful of variables to tweak font-locking in `.def` files. These variables primarily consist of flags that allow users to box or fill header keywords and section headers. `apptainer-mode` will do some rudimentary checking for conflicting face specifications.

All of the variables listed below default to `nil`.

|                             |                                                                          |
|:----------------------------|:-------------------------------------------------------------------------|
| `apptainer-boxed-headers`   | Non-nil draws a box around header keywords                               |
| `apptainer-filled-headers`  | Non-nil sets a background fill on header keywords                        |
| `apptainer-boxed-sections`  | Non-nil draws a box around section headers                               |
| `apptainer-filled-sections` | Non-nil sets a background fill on section headers                        |
| `apptainer-boxed-faces`     | Non-nil boxes both header keywords and section headers                   |
| `apptainer-filled-faces`    | Non-nil sets background fill on both header keywords and section headers |
| `apptainer-boxed-links`     | Non-nil draws a box around URLs and email addresses                      |


