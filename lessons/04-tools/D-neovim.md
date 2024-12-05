---
title: "Tools"
description: "your most used tool is the editor"
---

## Lets start with your editor
Now i am going to show you around neovim, not because you are going to use
neovim, or that i am trying to convince you to use neovim.  You should use
neovim because you want to explore other ways of editing. Also, its good
understand just how hackable it is and perhaps you will be willing to try it

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Creating your own neovim experience
I'll just give you a brief look at neovim and what you can do.  This isn't
really a "follow" along section, but if you already have neovim setup, you
could.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## One more note about vim
If you are getting a bit vim curious, seeing people fly around, its totally
normal.  But i do want to warn you about 2 things.

1. you live in a world where you have really different mentality.  This isn't
   the era that vi or vim was created.  So many modern luxuries that its hard
   to connect at first with Vim.  So the best thing you can do at first is to
   learn vim motions.  Once you are sufficiently amazing at vim motions, then move
   on to using vim.  And of course, i recommend neovim

2. When you first use vim, there is no filetree on the left, menu at the top,
   just text on the screen.  This will make it hard to even read code because
   of how unfamiliar and hostile the environment seems.  Don't worry, that
   feeling will go away.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Lets go over some of the motions
Perhaps to give you a taste, lets go over some of the motions and why its
amazing.

We can also go over some of the awesome remaps that i have dev'd / been given
over the last few years.

* motions
* qfix
* harpoon
* navigation
* macros
* commands
* help
* your first init script

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## But why neovim?
We get the best of both worlds, a modern IDE and vim motions.  Why would I ever
use neovim?

* defense for neovim
* the bonus of using neovim that isn't quite the same with other editors

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Lets play with the neovim api

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
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
```lua
local function read_file_with_system(filename)
  local pipe = vim.system({"cat", filename})
  local content = pipe:wait().stdout
  local lines = vim.split(content, "\n", { trimempty = true })
  return lines
end

local api = vim.api
local buf = api.nvim_create_buf(false, true)
local win = api.nvim_open_win(buf, false, {
    relative="editor",
    width=80,
    height=24,
    row=0,
    col=0,
})
api.nvim_buf_set_lines(buf, 0, -1, false, read_file_with_system("./package.json"))

vim.defer_fn(function()
    api.nvim_win_close(win, true)
end, 5000)
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

## There is so much more
that was just a taste and there is so much more.  I highly recommend playing
around with the apis and making anything that you want.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## A quick note about AI
One really nice thing about neovim is that the api is so well documented and
the surface area so well defined that you can often one shot exactly what you
need with neovim and chatgpt.

this isn't always the case, it still makes up stuff ~5% of the time, but its
close.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## VimBeGood

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

