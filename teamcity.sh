#!/usr/bin/env bash
set -ex

GIT_BRANCH=$(git symbolic-ref --short HEAD)
if [ "$GIT_BRANCH" = "master" ]; then
    docker pull richfitz/drat.builder
    docker run --rm \
           -e GIT_AUTHOR_EMAIL="$(git config --get user.email)" \
           -e GIT_AUTHOR_NAME="$(git config --get user.name)" \
           -v ${PWD}:/src \
           richfitz/drat.builder
    # NOTE: teamcity will have a https remote so override this with a
    # ssh one so we can push without problems:
    git push git@github.com:vimc/drat.git master
fi
