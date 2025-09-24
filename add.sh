#!/bin/bash

# utils or hoisted functions

function err {
  echo "error: $1" 1>&2
}

function help {
  echo 'usage: ./add.sh <chapter-number>'
  echo '       ./add.sh help'
  echo '       ./add.sh init'
}

# routing

if [ "$1" = 'help' ]; then
  help
  exit 0
elif [ "$1" = 'init' ]; then
  if [ -f ".env" ]; then
    err ".env file already exists."
    exit 0
  fi
  cp .env.example .env
  echo "The .env file has been created."
  exit 0
fi

# configurations

if [ -f './.env' ]; then
  . ./.env
fi

author="$AUTHOR"
if [ -z "$author" ]; then
  err 'Environment variable 'AUTHOR' must not be empty'
  exit 1
fi

git_author="$GIT_AUTHOR"
if [ -z "$git_author" ]; then
  git_author="$author"
fi

editor="$EDITOR"
if [ -z "$editor" ]; then
  editor=`git config get core.editor`
fi

textbook="$TEXTBOOK"
if [ -z $textbook ]; then
  err 'Environment variable 'TEXTBOOK' must not be empty' 
  exit 1
fi

chapter="$1"
if [ -z "$chapter" ]; then
  err 'chapter-number must not be empty' 
  help
  exit 1
fi

# consts

textbook_readmd="$textbook/README.md"
path="$textbook/$chapter"
filename="$path/$author.md"
readme="$path/README.md"

# run...

if [ ! -d "$path" ]; then
  echo "Directory '$path' not found. Creating now..."
  mkdir -p "$path"
fi

if [ ! -f "$readme" ]; then
  echo "No README found for $chapter. Opening an editor to create a new one."
  echo "(Set the EDITOR environment variable to change the editor.)"
  echo "# $chapter " > "$readme"
  $editor "$readme" || exit 1
  git add "$readme"
  echo "done"

  echo "update $textbook_readmd"
  sed -i -E "s|- ($chapter .+)|- [\1]($chapter/README.md)|" "$textbook_readmd"
  git add "$textbook_readmd"
fi

another_files=`git diff --staged --name-only | grep -v -e "$textbook_readmd" -e "$readme"`
updated_files=`git diff --staged --name-only | grep -e "$textbook_readmd" -e "$readme"`

if [ ! -z "$updated_files" ]; then
  if [ -z "$another_files" ]; then
    commit_message="chore: mkdir $chapter/ and update the relevants"
    echo "Committing with message: '$commit_message'"
    while true; do
      read -n 1 -p "Would you like to commit now? (Y/n): " choice
      case "$choice" in
        [Nn]* ) break;;
        * ) git commit -m "$commit_message"; break;;
      esac
    done
  else
    err "The staging area is not clean."
    git diff --staged --name-only 1>&2
    exit 1
  fi
fi

echo "Hello, $author. You are currently located at '$path'"

echo "Opening editor for summary creation..."
$editor $filename || exit 1
echo "done"

echo "Staging the summary..."
git add $filename
git diff --staged

updated_files=`git diff --staged --name-only`

if [ -z "$updated_files" ]; then
  echo "No changes."
  exit 0
fi

if [ ! "$updated_files" = "$filename" ]; then
  err "The staging area is not clean."
  git diff --staged --name-only 1>&2
  exit 1
fi

echo "Fetching..."
git fetch

amendable_hash=`git branch -vv | grep '*' | grep -v '\[origin/main\]' | grep -E "learn: .+ $chapter" | awk '{print $3}'`
prev_commit_hash=`git log --author $git_author --grep "learn: .* $chapter" --pretty=format:%h`
commit_message="learn: add the summary of $chapter"

if [ ! -z "$amendable_hash" ]; then
  echo "Committing with message: '$commit_message'"
  # amendable
  while true; do
    read -n 1 -p "Would you like to amend the commit now? (Y/n): " choice
    case "$choice" in
      [Nn]* ) break;;
      * ) git commit --amend -m "$commit_message"; break;;
    esac
  done
else
  # not amendable
  if [ -z "$prev_commit_hash" ]; then
    echo "Committing with message: '$commit_message'"
    while true; do
      read -n 1 -p "Would you like to commit now? (Y/n): " choice
      case "$choice" in
        [Nn]* ) break;;
        * ) git commit -m "$commit_message"; break;;
      esac
    done
  else
    err "An earlier commit exists. Please update it manually."
    git show -s --abbrev-commit $prev_commit_hash
  fi
fi

