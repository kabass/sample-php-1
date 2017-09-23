#!/bin/bash


git checkout -b 1.0 origin/1.0

# geting current version
IN=$(jq .version composer.json)
set -- "$IN"
IFS="."; declare -a Array=($*)
IN="${Array[2]}"
set -- "$IN"
IFS="-";
declare -a Array=($*)
declare -a  NVERSION=${Array[0]}
NPLUSVERSION=$((${NVERSION}+1))

#taging versio
git tag -a "1.0.${NVERSION}" -m "taging version"
git push --tags


jq .version="\"1.0.${NPLUSVERSION}-dev\"" composer.json | sponge composer.json
git add .
git commit -m "jenkins : adding version"
git push origin 1.0
git checkout master
git rebase origin/master
