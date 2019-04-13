#!/bin/bash

# Ensure _deploy doesn't already exist
rm -rf _deploy

echo -e "\033[0;32mCloning the publish site...\033[0m"
#git clone git@github.com:rakallay/rakallay.github.io.git _deploy

mkdir _deploy
git worktree prune
rm -rf .git/worktrees/_deploy/

git worktree add -B master _deploy origin/master
#git submodule add -b master git@github.com:rakallay/rakallay.github.io.git _depl
echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
hugo

cd _deploy
git branch

git add .

# Commit changes.
msg="Rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
git push origin master

# Clean-up
cd ..
rm -rf _deploy
'