#!/bin/sh

if ! [ -f autograder/repo ]; then
  echo 'There does not appear to be a configured autograder here.'
  echo 'Have you run `./configure_autograder.sh` yet?'
  exit 1
fi

sed "s;/root/.ssh/deploy_key;$(realpath autograder/deploy_key);" autograder/ssh_config > local_ssh_config

if GIT_SSH_COMMAND="ssh -F local_ssh_config" git ls-remote -q --refs "$(cat autograder/repo)" HEAD; then
  echo 'The repo responded successfully. Good to go!'
  rm local_ssh_config
  exit 0
else
  echo 'There was a problem connecting. Is the deploy key setup on GitHub?'
  echo 'To re-test, run `./test.sh`'
  rm local_ssh_config
  exit 1
fi