---
title: "Wait A Second"
description: "what about all the dot files?"
---

## We only have talked about getting the software up
What about dotfiles?

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

One thing I did very intenionally was the `find` command in our previous
script.  It only finds `executables` within the first directory.  Nothing else.
This is good because that means if we have subdirectories they will not be
searched in

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

* create a directory called `env` within the directory
* within this directory put all of your environement

```bash
#!/usr/bin/env bash
dry_run="0"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

if [[ $1 == "--dry" ]]; then
    dry_run="1"
fi

log() {
    if [[ $dry_run == "1" ]]; then
        echo "[DRY_RUN]: $1"
    else
        echo "$1"
    fi
}

log "env: $script_dir"

update_files() {
    log "copying over files from: $1"
    pushd $1 &> /dev/null
    (
        configs=`find . -mindepth 1 -maxdepth 1 -type d`
        for c in $configs; do
            directory=${2%/}/${c#./}
            log "    removing: rm -rf $directory"

            if [[ $dry_run == "0" ]]; then
                rm -rf $directory
            fi

            log "    copying env: cp $c $2"
            if [[ $dry_run == "0" ]]; then
                cp -r ./$c $2
            fi
        done

    )
    popd &> /dev/null
}

pushd $script_dir &> /dev/null
update_files env/.config $XDG_CONFIG_HOME
popd &> /dev/null
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
Lets test to make sure its working the way i expect it to!

Always dry-run first btw (or else you would be sad)

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

