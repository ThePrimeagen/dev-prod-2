---
title: "Wait A Second"
description: "what about all the dot files?"
---

## We only have talked about getting the software up
What about dotfiles...
What about configuration...
WHAT ABOUT MY CUSTOMIZATIONS

<br>
<br>

For those unfamiliar with the term dotfiles, it simple means a script that is
ran at the start of your program.  A `.bashrc` / `.zshrc` / `.vimrc` are all
examples of dotfiles that run before the program startup is complete.  It is
the place for you to register your custom functionality or to alter program
behavior

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Well we already have everything we need
We have everything we need to get started, we have our reliable environmental
script to run, we just need one script that sets up our environment!

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## The Env Idea
* make a script that installs all the environment files.
* make one or more directories to where you like to install files to

<br>
<br>

### Lets do this!
* whiteboard time!
* code time!
* lets start by getting the basics of the script ready
  * dry run

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Expected Code
```bash
#!/usr/bin/env bash

script_dir="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
dry="0"

while [[ $# > 0 ]]; do
    if [[ "$1" == "--dry" ]]; then
        dry="1"
    fi
    shift
done

log() {
    if [[ $dry == "1" ]]; then
        echo "[DRY_RUN]: $@"
    else
        echo "$@"
    fi
}

execute() {
    log "execute: $@"
    if [[ $dry == "1" ]]; then
        return
    fi

    "$@"
}

log "--------- dev-env ---------"
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Copy time
Lets create the copy function that will bring over every source directory to
the target directory

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Expected code
```bash
cd $script_dir
copy_dir() {
    pushd $1
    to=$2
    dirs=$(find . -maxdepth 1 -mindepth 1 -type d)
    for dir in $dirs; do
        execute rm -rf $to/$dir
        execute cp -r $dir $to/$dir
    done
    popd
}

copy_dir .config $XDG_CONFIG_HOME
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## And just like that
We have ourselves a way to copy over directories for all of our programs... but
what about one off scripts?

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Expected Code
```bash
copy_file() {
    file=$1
    to=$2
    execute rm $to/$file
    execute cp $file $to
}

copy_file .specialrc ~/
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## We make things bigger than they are
this will solve about 99% of all dotfile management issues.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

