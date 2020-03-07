# Git-Scope

## Goals

  * To provide a minimal setup to automatically pull autograding code from GitHub
  for Gradescope.
  * To provide a Gradescope autograder configuration that is flexible with any
    autograder setup one might need.

## Future goals
  * To provide some security when running unsafe code (i.e. students' code).
  * To provide some options to automatically pull a set of dependencies.


## Non Goals

  * Not a testing framework.
  * Not a a way to generate Gradescope's `results.json`. There's other libraries
    for that particular reason.

## Motivation

Creating autograded assignments in Gradescope requires a lot of boiler plate
code already. Even more, maintaing them is even harder as any change to the
autograder code means having to rebuild the Gradescope docker instance with the
new autograder code. A better way to handle this, is to have a non-changing
setup whose job is to clone and pull the assignment-specific autograding code
from Github. This means that an autograder change can be propagated
automatically by pulling the code from the repo. This is much faster and easier
than having to rebuild the autograder every time the code changes.

## Usage

To use this piece of software, a few things must happen.

1. Create a Github repo with the autograder code.

  1. The repo should *optionally* contain a `setup.sh` file in the top level
  directory. The `setup.sh` is used to install any extra dependencies needed for
  the particular autograder. It can also be used to setup any extra configurations
  needed. This will be run once during the setup of the autograder.

  2. The repo *must* contain a `run_autograder` file in the top level directory.
  This file will be run every time there is a new submission. This file should
  output the `results.json` into `/autograder/results/results.json` as specified
  by the [Gradescope Documentation](https://gradescope-autograders.readthedocs.io/en/latest/specs/).
  The submission files will get populated into the directory `submission/` which
  will live at the top level of the repository.

2. Once that's created, you will need to download this repo. You will have to
   generate a public-private key pairs that should get stored in the two
   `deploy_key` and `deploy_key.pub` files. You should add the public key as a
   read-only deploy key in your github repo.

3. Lastly, copy the ssh address of you repo and put it in the `repo` file.

Once that's done, you can zip all the files and submit them into
Gradescope's assignment's autograder configuration. If successful, the autograder
will be pulled from your Github repository every time a student submits their
code.
