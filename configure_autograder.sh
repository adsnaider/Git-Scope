#!/bin/sh

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 Github Address" >&2
  echo "Example: $0 git@github.com/foo/bar.git" >&2
  exit 1
fi

cd autograder/

rm -f deploy_key deploy_key.pub
ssh-keygen -f deploy_key -q -N ""

echo "============================= Deploy Key (pub) ==================================="
cat deploy_key.pub
echo "=========================== End Deploy Key (pub) ================================="
echo "Please copy the above key to the deploy keys section in your github repo."

echo "$1" > repo
echo "Setting repo address as \"$1\""

zip ../autograder.zip ./* > /dev/null
cd ../
