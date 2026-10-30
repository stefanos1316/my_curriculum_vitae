[![Build Status](https://travis-ci.org/stefanos1316/my_curriculum_vitae.svg?branch=master)](https://travis-ci.org/stefanos1316/my_curriculum_vitae)

About the online CV
===================

This is a work replicated from this [link](https://github.com/mszep/pandoc_resume), but modified to my own needs.
GitHub Actions builds the CV and deploys the generated `web/` directory to
GitHub Pages on pushes to `master`. Pull requests build without deploying.

In **Settings → Pages**, select **GitHub Actions** as the build source.
The deployment can also enable Pages automatically using the existing
`TOKEN` Actions secret: this must be a personal access token with the
`repo` scope (classic) or Pages write permission (fine-grained).
The `github-pages` environment must allow deployments from `master`.
Publishing no longer pushes generated files to the `gh-pages` branch.
If deployment returns `404 Not Found`, verify that Pages is enabled for
this repository and that `TOKEN` has the required access.


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
