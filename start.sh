#!/bin/sh
set -e

INPUT_BRANCH=${INPUT_BRANCH:-master}
INPUT_FORCE=${INPUT_FORCE:-false}
INPUT_TAGS=${INPUT_TAGS:-false}
INPUT_DIRECTORY=${INPUT_DIRECTORY:-'.'}
_FORCE_OPTION=''
REPOSITORY=${INPUT_REPOSITORY:-$GITHUB_REPOSITORY}

function sanitize {

  mv certificates/* web/
  mv degress/* web/
  mv github_activity_overview web/
  mv proofs/* web/
  mv publications/* web/
  
  rm -rf tools
  rm -rf styles
  rm Makefile
  rm -rf markdown
  rm -rf README.md
  rm -rf resume.tuc
  
  shopt -s extglob
  rm -rf !(web)
  mv web/* ./ && rm -rf web/
}

echo "Push to branch $INPUT_BRANCH";
[ -z "${INPUT_GITHUB_TOKEN}" ] && {
    echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".';
    exit 1;
};

if ${INPUT_FORCE}; then
    _FORCE_OPTION='--force'
fi

if ${TAGS}; then
    _TAGS='--tags'
fi

cd ${INPUT_DIRECTORY}

remote_repo="https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${REPOSITORY}.git"
git config user.name stefanos1316
git config user.email stefanos1316@gmail.com
git add web/*
git commit -m "New site fixes - $(date)"
git push ${remote_repo} --delete gh-pages || echo Branch not found
git push "${remote_repo}" HEAD:${INPUT_BRANCH} --follow-tags $_FORCE_OPTION $_TAGS;
git checkout -b gh-pages
git pull ${remote_repo} gh-pages

sanitize

git add .
git commit -m "New deploy - $(date)"
git push "${remote_repo}" HEAD:${INPUT_BRANCH} --follow-tags $_FORCE_OPTION $_TAGS;

echo "$GITHUB_ACTOR $GITHUB_EMAIL"

curl https://stefanos1316.github.io/my_curriculum_vitae/ || echo Failed to load
curl https://stefanos1316.github.io/my_curriculum_vitae/index.html || echo Failed to load
