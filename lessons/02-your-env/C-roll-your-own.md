---
title: "Reinvent the wheel"
description: "its one of the best past times"
---

## Reinvent the wheel
I love reinventing the wheel.  There are many reasons why i like doing it too!
* its great for learning
* sometimes what you want doesn't really fit any solution

<br>
<br>

That is ok.  Its ok that you have to recreate something that exists in some
form.  Its ok because you will understand it much better and you may end up
creating something that is way more useful to you

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
* I want to be able to bootstrap any machine i will purchase in the future that is ubuntu based.
  * i am not going to be clever and try to do a multiOS style, though this isn't hard its just tedious
* I want to be able to install all my favorite libraries
* I want the repos that i actively maintained brought down
* I want to be able to build neovim from source

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
of all time... bash...

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
version, Dotbot to name one of them.  I want to emphasize that I think the more
you own of your system the better it will be because its exactly the way you
want it.  You have the power to fashion it the way you want!

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

## Argument parsing and script setup
Lets setup the basic of the script for this:

*Perhaps a bit of white boarding could be useful here...*

* create a project directory anywhere you deem fit
* create a script called `run` within the directory you just created and make it executable (chmod +x run) within
* open up your favorite text editor neovim (maybe something else...)

<br>
<br>

### Start simple
* code up something that allows us to know the current directory and take in 1 argument for filtering of tasks

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

grep="$1"

echo "Run: dir $script_dir -- grep \"$grep\""
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

pushd @script_dir 2> /dev/null
scripts=`find runs2 -maxdepth 1 -mindepth 1 -executable`
popd 2> /dev/null

for s in $scripts; do
    if echo $s | grep -vq "$grep"; then
        echo "filtering: $s"
        continue
    fi

    ./$scripts_dir/$s
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

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "$script_dir"

grep=""
dry="0"

while [[ $# > 0 ]]; do
    if [[ $1 == "--dry" ]]; then
        dry="1"
    else
        grep=$1
    fi
    shift
done

log() {
    if [[ $dry == "1" ]]; then
        echo "[DRY_RUN]: $1"
    else
        echo $1
    fi
}

log "run \$grep \"$grep\""

pushd @script_dir 2> /dev/null
scripts=`find runs2 -maxdepth 1 -mindepth 1 -executable`
popd 2> /dev/null

for s in $scripts; do
    if echo $s | grep -vq "$grep"; then
        log "filtering: $s"
        continue
    fi

    log "executing: $scripts_dir/$s"
    if [[ $dry == "0" ]]; then
        ./$scripts_dir/$s
    fi
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

## Lets create neovim installation
Lets do what we did in ansible but for the neovim script

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
This is for `runs/neovim`

```bash
version="v0.10.2"
if [ ! -z $NVIM_VERSION ]; then
    version="$NVIM_VERSION"
fi

echo "version: \"$version\""

# neovim btw
if [ ! -d $HOME/neovim ]; then
    git clone https://github.com/neovim/neovim.git $HOME/neovim
    sudo apt -y install cmake gettext lua5.1 liblua5.1-0-dev
fi

git -C ~/neovim fetch --all
git -C ~/neovim checkout $version

make -C ~/neovim clean
make -C ~/neovim CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make -C ~/neovim install
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
* Making it OS independent is a bit of a pain in the ass
  * i would argue equally painful as ansible

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

I just find that amount of logic though nice can also be a huge pain

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

