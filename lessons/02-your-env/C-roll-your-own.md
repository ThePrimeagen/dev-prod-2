---
title: "Reinvent the wheel"
description: "its one of the best past times"
---

## Reinvent the wheel
I love reinventing the wheel.  There are many reasons why i like doing it too!

<br>
<br>

### You will gain
* a new appreciation of what it takes to create software
* learn a bunch about the topic along the way
* become a better engineer yourself, meaning you will now be able to guage
  problems more accurately

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

## My Current Bash Setup
This is obviously subject to change.  About once a year to every two years I
try to rethink through everything I have done and see if its something i like
or hate.  That way I can continue to improve my system but I don't end up
becoming a meme of the continually pursuit of perfection.

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

## Lets set some goals
* I want to be able to bootstrap any machine i will purchase in the future that
  is ubuntu based.
  * i am not going to be clever and try to do a multiOS style, though this
    isn't hard its just tedious
  * if i need a mac install script i am sure i can create a mac version
* I want to be able to install all my favorite libraries
* I want the repos that i actively maintained brought down
* I want to be able to build neovim from source
* I want all the tools i use available
* I want to copy all my dotfiles over to my env.  i like them separated.

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

## I just want it all
I really just want to automate my system with the greatest automation language
of all time...

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

bash

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

## Rolling out own
There are other versions of this exact same project that is someone elses
version.  I want to emphasize that I think the more you own of your system the
better it will be because its exactly the way you want it.  You have the power
to fashion it the way you want!

<br>
<br>

But i am not foolish, this is also a double edge sword where you have to
maintain and improve your own system to make continue to make it great.

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

## The idea
Create a script called `run` that will, based on some arguments passed in,
will run 0 or more scripts.  I want to make sure that scripts are easily
organized so the scripts will be located in a subdirectory called `runs`

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

## My version
If you want to check out my final version of this product, check out my repo
named [dev](https://github.com/theprimeagen/dev)

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

## Argument parsing and script setup
Now we need to write the ackshual run script.  Lets start with first creating
the dev environment.  Meaning getting the libraries, projects, editor, etc etc
that we want on our machine.

*Perhaps a bit of white boarding could be useful here...*

* create a project directory anywhere you deem fit
* create a script called `run` within the directory you just created and make it executable (chmod +x run) within
* open up your favorite text editor neovim (maybe something else...)

<br>
<br>

### Start simple
* code up something that allows us to know the current directory and take in 1
argument for filtering of tasks

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

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "$script_dir"

filter="$1"

echo "Run: dir $script_dir -- filter \"$filter\""
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

## But how do we run scripts?
* we need to use our current script location to figure out all the available
  scripts and run them one by one and if we have a mask/filter/grep then use
  that to prevent any extra execution

* coding time...

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
# ... previous section ...
script_dir="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
filter="$1"

cd $script_dir
scripts=$(find runs -maxdepth 1 -mindepth 1 -executable -type f)

for script in $scripts; do
    if echo "$script" | grep -qv "$filter"; then
        echo "filtered: $filter -- $script"
        continue
    fi
    ./$script
done
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

## Quick Note
why single bracket comparison ?

```bash
if [ ! -z "$myvar" ]; then ...
```
why double bracket comparison ?

```bash
if [[ $myvar == "" ]]; then ...
```

why no bracket comparison ?

```bash
if echo $myvar | grep -q "hello world"; then ...
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

## Back to the program
We officially have our files being ran and we have filtering, and this is great.

But what if we need to debug this bash script?  We don't really have a way
other than add a bunch of print statements and potentially run some side
effects we were not expecting

We need a `dry_run`, so lets write it now!

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
Here is the full code up to this point

```bash
#!/usr/bin/env bash

script_dir="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
filter=""
dry="0"

cd $script_dir
scripts=$(find runs -maxdepth 1 -mindepth 1 -executable -type f)

while [[ $# > 0 ]]; do
    if [[ "$1" == "--dry" ]]; then
        dry="1"
    else
        filter="$1"
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

log "run: filter=$filter"

for script in $scripts; do
    if echo "$script" | grep -qv "$filter"; then
        log "filtered: $filter -- $script"
        continue
    fi
    log "running script: $script"
    execute ./$script
done
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

## Boom!
We now have a script that is easily extensible for setting up our environment

* You can add as many scripts as you would like
* You can filter which scripts get ran
* You can easily edit those scripts to be exactly what you want

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

## Some cons
* Bash sort of sucks..
* Keeping things up date is easy to forget
  * this is also why i always copy my environment.  i never edit the env files
  directly.  A good habit for me
* Making it OS independent is a bit of a pain in the ass
  * i would argue its easier and up to as hard as ansible

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

## Other thoughts on dry runs
You `export DRY_RUN` during the dry run checks and then run every script and
let your scripts be the ones that tell you what it would be doing instead of
doing it.

I just find that amount of logic is nice on paper but a huge pain in practice

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

