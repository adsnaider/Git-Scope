#!/bin/sh

if ! [ -f autograder/repo ]; then
  echo 'There does not appear to be a configured autograder here.'
  echo 'Have you run `./configure_autograder.sh` yet?'
  exit 1
fi

if GIT_SSH_COMMAND="ssh -i autograder/deploy_key -F /dev/null" git ls-remote -q --refs "$(cat autograder/repo)" HEAD; then
  echo 'The repo responded successfully. Good to go!'
  exit 0
else
  echo 'There was a problem connecting. Is the deploy key setup on GitHub?'
  echo 'To re-test, run `./test.sh`'
  exit 1
fi