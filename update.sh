#! /bin/bash

# update all submodules
git submodule foreach git pull origin master

# make sure we don't commit anything else
git reset HEAD .

# commit all changes
git add bundle
git commit -m "submodule update"
