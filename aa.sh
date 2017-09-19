#!/bin/bash
OUTPUT=$(java -jar ~/logiciel/jenkins/jenkins-cli.jar -s http://localhost:8080 -auth admin:admin  get-job 'watch-for-new-branch' | tr "\n$" "\ ")
echo $OUTPUT
