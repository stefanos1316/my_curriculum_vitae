#!/bin/bash

PASSWORD=$1

make
cd web

git init
git config user.name stefanos1316
git config user.email stefanos1316@gmail.com
git add .
git commit -m "New site fixes - $(date)"

REPO=https://stefanos1316:${PASSWORD}@github.com/stefanos1316/my_cirriculum_vitae.git
git push --force $REPO master:gh-pages

rm -rf .git
cd ..
rm -rf web
