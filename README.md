# Git-Scope

<!-- vim-markdown-toc GFM -->

- [Goals](#goals)
- [Future goals](#future-goals)
- [Non-Goals](#non-goals)
- [Motivation](#motivation)
- [Usage](#usage)

<!-- vim-markdown-toc -->

## Goals

- Provide a minimal setup to automatically pull autograding code from GitHub for
  Gradescope.
- Provide a Gradescope autograder configuration that is flexible with any
  autograder setup one might need.

## Future goals

- Provide some options to automatically pull a set of dependencies.

## Non-Goals

- Not a testing framework.
- Not a a way to generate Gradescope's `results.json`. There's other libraries
  ([StarGrade](https://github.com/adsnaider/StarGrade)) for that particular
  reason.

## Motivation

Creating autograded assignments in Gradescope requires a lot of boiler plate
code already. Maintaing them is even harder as any change to the autograder code
means having to rebuild the Gradescope docker instance with the new autograder
code. A better way to handle this, is to have a non-changing setup whose job is
to clone and pull the assignment-specific autograding code from Github. This
means that an autograder change can be propagated automatically by pulling the
code from the repo. This is much faster and easier than having to rebuild the
autograder every time the code changes.

## Usage

To use this piece of software, a few things must happen.

1. Create a Github repo with the autograder code.

1. The repo should _optionally_ contain a `setup.sh` file in the top level
   directory. The `setup.sh` is used to install any extra dependencies needed
   for the particular autograder. It can also be used to setup any extra
   configurations needed. This will be run once during the setup of the
   autograder. Note that the setup will only get run once during the docker
   configuration phase in Gradescope. This limitation is due to Gradescope's
   design choices.

1. The repo _must_ contain a `run_autograder` file in the top level directory.
   This file will be run every time there is a new submission. After this file
   is run, a `results.json` should be generated into
   `/autograder/[repo]/results/results.json`. The submission files will get
   populated into the directory `/autograder/[repo]/submission/`. Note that both
   of these files live in the same directory with the repo. This helps abstract
   away Gradescope's system from your autograder repo. It means that the code
   can be tested locally and still generate results even when the code isn't
   being run from within Gradescope.

1. Once that's created, you will need to download/clone Git-Scope (this repo).
   You can run `./configure_autograder.sh [autograder repo SSH URL]` to generate
   the autograder zip file that will be uploaded to Gradescope.

1. The script we run previously will spit out an ssh key. You must go to your
   autograder repo and add that key into the deploy keys section so that
   Gradescope has access to pull the repo into the server. See more information
   on
   [adding deploy keys in Github here](https://developer.github.com/v3/guides/managing-deploy-keys/#deploy-keys)

Once that's done, you may submit the zip file into Gradescope's assignment. If
successful, the autograder will be pulled from your Github repository every time
a student submits their code.
