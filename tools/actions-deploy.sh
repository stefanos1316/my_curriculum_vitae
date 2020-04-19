#!/bin/bash

make
cd web

git init
git config user.name stefanos1316
git config user.email stefanos1316@gmail.com
git add .
git commit -m "New site fixes - $(date)"

REPO=https://stefanos1316@github.com/stefanos1316.github.io.git
git push --forece #REPO master:gh-pages

rm -rf .git
cd ..
rm -rf web
