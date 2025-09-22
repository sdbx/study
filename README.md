# sdbx/study

## Introduction

This repository is built in order to store the memos written as a result of learning git from reading [_Pro git (2nd edition)_](https://git-scm.com/book/en/v2).

## Participants

- @tnraro
- @logic-finder

## Directory Structure

```
pro-git
└ README.md   # contains the table of contents
└ <chapter-number>.<section-number>
  └ README.md   # contains the link to the corresponding webpage
  └ <participant>.md   # contains the participant's summary on that section
```

## Helper Scripts

### add.sh

For example, if one would like to add a directory named `1.1`, one can execute the command `./add.sh 1.1`. That is, `add.sh` is a shell scripts which automates this task.

Meanwhile, it is required to run `./add.sh init` first if one has never executed this script before.

### tracker.sh

This shell script prints the progess which indicates how much sections each participant has read.

```
./tracker.sh     # prints the overall progress.
./tracker sh 1   # prints the progress on the chapter one.
```
