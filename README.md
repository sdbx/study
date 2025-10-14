# sdbx/study

## Introduction

This repository is built in order to store the memos written as a result of learning git from reading [_Pro Git (2nd edition)_](https://git-scm.com/book/en/v2).

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

Use `sc` to run project helper commands from any directory. It switches to the project root, identifies the appropriate subcommand, and executes it with your arguments.

### Quick Start

Run `./sc init` to create a .env file at the project root. Then edit it to customize the environment variables.

```bash
$ ./sc init
# Then edit .env manually
```

### Add a Summary File

Run `./sc add` with a subdirectory name to create a summary file, stage it, and commit it. It also creates or updates any related files or directories if necessary.

```bash
./sc add 5.3
```

This opens the editor to modify the summary file or the README file.

### Fix the Summary File

If the summary file contains errors or needs updates, run `./sc fix` with a subdirectory name to open your editor, edit the summary, and commit with a sensible default message or a custom one.

```bash
./sc fix 5.3
```

### Print Progress

To print progress indicating how many sections each participant has read, run `./sc tracker`.

```bash
./sc tracker    # Prints overall progress.
./sc tracker 5  # Prints progress for chapter 5.
```
