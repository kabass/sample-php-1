#!/bin/bash
GIT_REPOSITORY_PATH=`git rev-parse --show-toplevel` # Get the repository path
GIT_REPOSITORY_NAME=`basename $GIT_REPOSITORY_PATH` # Extract the repository name

# Get all branches from current repository
git branch -r  | grep -v "origin/HEAD"  | sed "s/^[ \t]*//;s/[ \t]*$//" | sed "s/^origin\///"  | grep -v "^$" > branches 

# For each branch
while read -r line # Loop through all the lines in the branches file
do
BRANCH=$line
JOB_NAME=$GIT_REPOSITORY_NAME-$BRANCH # Create a job name for this branch

# Curl the Job URL to see if it exists
SHOULD_BE_404_IF_NEW_JOB=$(java -jar ~/logiciel/jenkins/jenkins-cli.jar -s http://localhost:8080  -auth admin:admin  get-job feature-$JOB_NAME)
echo $SHOULD_BE_404_IF_NEW_JOB
# Only create a job if it doesn"t already exist. No point doing it twice
if [ -z "$SHOULD_BE_404_IF_NEW_JOB" ]; then

java -jar ~/logiciel/jenkins/jenkins-cli.jar -s http://localhost:8080 -auth admin:admin  build php-jenkins-sample-generator -p BRANCH_NAME=$JOB_NAME

fi

done < branches
