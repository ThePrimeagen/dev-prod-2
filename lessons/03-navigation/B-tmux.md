---
title: "Navigation"
description: "tmux is a great way to navigate around the terminal"
---

## The Terminal Experience
I have a list of things i want in my terminal to make it useful and it all is
centered around navigation.

* to gimp! *

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## What I Want
1. sessions that last even when i close my terminal
1. multiple running sessions, and these sessions are based on directory
1. "tabs" within a session
1. navigate to any session by directory name "instantly"
1. navigate to any session by directory with fuzzy find
1. run scripts or whatever programs i want when navigating to a directory

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## I Choose Tmux
I personally use tmux + ghostty, though i hear wezterm, the terminal emulator,
you can emulate pretty much every way I use tmux.  I have not used wezterm so i
cannot speak much about it. (Zellij has similar experience)

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Quick Notes
* About 3 years ago I did the first version of Dev productivity and some things
  about my setup has changed, and parts have remained the same.  After 3 years,
  this is still my most useful script I have ever created.  But i have added
  some significant improvements to the script

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Installing TMUX
| Platform                    | Install Command         |
|-----------------------------|-------------------------|
| Arch Linux                  | `pacman -S tmux`        |
| Debian or Ubuntu            | `apt install tmux`      |
| Fedora                      | `dnf install tmux`      |
| RHEL or CentOS              | `yum install tmux`      |
| macOS (using Homebrew)      | `brew install tmux`     |
| macOS (using MacPorts)      | `port install tmux`     |
| openSUSE                    | `zypper install tmux`   |

## Config
Here is the basic config that will make life easier.  This will ensure that you
have a similar experience to me

```bash
set -g default-terminal "tmux-256color"
set -s escape-time 0
set -g base-index 1
# <WHERE YOUR TMUX CONF GOES> = XDG_CONFIG_HOME/tmux/tmux.conf
# <WHERE YOUR TMUX CONF GOES> = ~/.tmux.conf
bind r source-file <WHERE YOUR TMUX CONF GOES> \; display-message "tmux.conf reloaded"
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

## Lets navigate tmux
Lets go through some basic commands about tmux so you can see how they work
with just usage.  I will show you the ones I use and some that I don't use

TODO: learn to do splits better

* what is prefix key
* show the tmux basics
* tmux is controlled by a config
  * show off a bit of that
  * TODO: make sure i know what everything means :)

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Based on my previous 5 points, only two have been met.
> 1. sessions that last even when i close my terminal
> 3. "tabs" within a session

<br>
<br>

It turns out that `tmux` is also scriptable!  And its quite fantastic

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## The Session API

A `target` is a tuple of `<session_name>[:<widx>|<wname>[.<pane_idx>]]`

```bash
tmux new-session -s <sname> -n <initial wname> -d[etach]
tmux list-sessions
tmux attach-session -t <target> # show some of the goofiness of this
tmux has-session -t <target>    # show the danger
                                # lets develop has_session
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

## The Window API

```bash
tmux new-window -n <name> [-t session:window_index]
tmux list-windows [-t session]
tmux select-window -t session:[window_idx | window_name].[pane_idx]
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

## Other fun apis

```bash
tmux send-keys -t <target> "text" [ctrl keys,...]
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

## Lets start with our first script

* opens and creates the configuration you want for a project
* link it to a remap key in our tmux conf

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Opener script

```bash
#!/usr/bin/env bash

if [ ! -z .tmux-ready ]; then
    return
fi

./.tmux-ready
```

```bash
# in tmux.conf
...
bind S tmux-ready
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

## Thats pretty cool?
That was pretty awesome that we can create all the windows / splits we want
with a simple flick of the wrist

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Progress
We have checked off another component of what I consider a great terminal
experience

> 6. run scripts or whatever programs i want when navigating to a directory

But we still have a couple left

> 4. navigate to any session by directory name "instantly"
> 5. navigate to any session by directory with fuzzy find

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Detour time
FZF is an incredible tool for fuzzy finding.  Its not just for finding
directories.  You can fuzzy find on anything you pass in and is often used
within text editors.

### I will add fzf to my scripts

`dev-env/runs/libs`
```bash
# ... other libs i install ...

git clone git@github.com:junegunn/fzf.git $HOME/personal/fzf
$HOME/personal/fzf/install
```

`dev-env/env/.zsh_profile`
```bash
## All that sweet sweet fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
```

### Execute
Make sure i only run my libs script
`run --dry libs`

Run my lib script
`run libs`

Copy all of my files over
`dev-env`

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Test run
try pressing `C-r` (Control + r) and it should bring up a beautiful fuzzy find
comparatively to your standard `C-r` from the terminal

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Playing with FZF

input
```bash
➜  dev-prod-2 git:(main) ✗ echo "1\n2\n3" | fzf
```

output
```bash
  3
  2
▌ 1
  3/3 ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
>
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

## Lets solve the last problems
> 4. navigate to any session by directory name "instantly"
> 5. navigate to any session by directory with fuzzy find

### Some notes
* We don't want to search _every_ directory on the file system, we want to have
some sort of subset.

* We want to navigate based on the results of FZF

### CODE TIME!!
lets write this MF script (MF = Mother FZF) where we get a selected directory from fzf.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
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

selected=$(find ~/personal -mindepth 1 -maxdepth 1 -type d | fzf)
echo "selected!! $selected"
```

### Ok, lets do some great things
Lets create tmux sessions based on our newly found tmux knowledge plus our fzf
results!

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
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

selected=$(find ~/personal -mindepth 1 -maxdepth 1 -type d | fzf)

if [[ -z "$selected" ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

switch_to() {
    if [[ -z $TMUX ]]; then
        tmux attach-session -t=$1
    else
        tmux switch-client -t=$1
    fi
}

# no tmux currently running, or tmux running, just not in this terminal
if [[ -z "$TMUX" ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

switch_to $selected_name
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

## Combine our two scripts
It would be nice if we could combine our two scripts...

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Next Expected Script
```bash
#!/usr/bin/env bash

selected=$(find ~/personal -mindepth 1 -maxdepth 1 -type d | fzf)

if [[ -z "$selected" ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

switch_to() {
    if [[ -z $TMUX ]]; then
        tmux attach-session -t=$1
    else
        tmux switch-client -t=$1
    fi
}

hydrate() {
    if [ -z $selected/.tmux-ready ]; then
        return
    fi

    tmux send-keys -t $selected_name "./.tmux-ready" c-M
}

# no tmux currently running, or tmux running, just not in this terminal
if [[ -z "$TMUX" ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

switch_to $selected_name
hydrate
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

