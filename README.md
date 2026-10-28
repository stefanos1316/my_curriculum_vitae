[![Build Status](https://travis-ci.org/stefanos1316/my_curriculum_vitae.svg?branch=master)](https://travis-ci.org/stefanos1316/my_curriculum_vitae)

About the online CV
===================

This is a work replicated from this [link](https://github.com/mszep/pandoc_resume), but modified to my own needs.
In adddion, it automates the build process by creating a new branch on travis and backing it back the Github repository after a success compilation.
To set-up auto-push from Travis (creates a new branch) consider reading this [tutorial](https://aueb-balab.github.io/courses/tools/travis_ci_cv_template-p.html#/) (Section: Auto-deploying gh-pages with Travis (Linux distros)). 


Original source of:
* [Markdown CV](https://github.com/mszep/pandoc_resume.git)
* [GitHub's Activity Overview](https://github.com/IonicaBizau/github-calendar.git)

Building locally
================

Run `make` to generate HTML, PDF, DOCX, and RTF files in `web/`.
Pandoc is required for all formats; PDF generation also requires ConTeXt
(`context`) because the PDF template uses ConTeXt rather than LaTeX.
Run `make html` to build only the website without ConTeXt.

On macOS, install Pandoc with `brew install pandoc` and install a TeX
distribution that includes ConTeXt, such as the full
[MacTeX distribution](https://www.tug.org/mactex/).
Ensure Homebrew's binary directory and `/Library/TeX/texbin` are on your
shell's `PATH`. For example, after configuring Homebrew, add this to
`~/.zprofile` and open a new terminal:

```sh
export PATH="/Library/TeX/texbin:$PATH"
```

Verify the tools with `pandoc --version` and `context --version` before
running `make`. If ConTeXt reports an unknown `mtx-context.lua` script,
run `mtxrun --generate` to refresh its file database, then check again.

On Debian/Ubuntu, install the build dependencies with:

```sh
sudo apt-get update
sudo apt-get install pandoc context
```

An exit code of 127 with `context: command not found` means ConTeXt is
missing or not on `PATH`. Other ConTeXt failures are printed during the
build and saved in `web/context_<name>.log`. The PDF build stops at the
first failed conversion.


Illustrate Page
===============

[View online CV](https://stefanos1316.github.io/my_curriculum_vitae/index.html)	


Contact
=======

sgeorgiou(at)aueb.gr, sgeorgiou(at).singularlogic.eu, and stefanos1316(at)gmail.com
