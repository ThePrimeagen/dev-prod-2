---
title: "Ansible"
description: "ansible"
---

## Ansible
Now a long running way i have been using to manage my dotfiles have been
exclusively through ansible.  There are several pluses to managing through
ansible and there are some negatives

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Pros
* there is tons of online documentation
* its used more than just managing dotfiles
* ansible vault allows for plain storage of ssh keys!  which is really cool

## Cons
* it can be terribly slow
* it can be hard to make it work for certain tasks, such as installing neovim
  plugins
* tags can be great and super annoying
* its not obvious how to reverse operations

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Basic Ansible
lets create a simple ansible script to clone neovim from source and build it
from a specific tagged version

everything in this section can be found
[here](git@github.com:ThePrimeagen/ansible-neovim-example.git)

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## What is ansible?
From their github <br>
> Ansible is a radically simple IT automation system. It handles configuration management, application deployment, cloud provisioning, ad-hoc task execution, network automation, and multi-node orchestration. Ansible makes complex changes like zero-downtime rolling updates with load balancers easy. More information on the Ansible website.

You are probably thinking... wait... aren't we talking about dotfiles and environments?

<br>
<br>

Why yes we are!

<br>
<br>

This is a tool designed for "servers" and if you squint your eyes you will
realize that you are just working on a "server."

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Install ansible
as all adventures start...

```
pip3 install ansible
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

## The heart of ansible
Typically when you are working with ansible you are using an inventory, which
is a list of all servers you have proper access to, and a series of playbooks.
The playbooks are where we specify the tasks we wish to perform on one or more
nodes (machines).  The playbook is the heart of ansible

<br>
<br>

Since we are operating on our own machine we wont need the inventory part

<br>
<br>

Lets just jump right into the playbook side of ansible which is where all the
work is done

<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Your First Playbook
Lets start off by creating a playbook that will use git to download the
contents of neovim to a directory in a directory of our choosing

* create a new directory, lets call it `mfansible`
* create a file called `neovim.yml`
* input the following

```
- name: My first play
  hosts: localhost
  tasks:
```

with this alone we can now execute ansible and see the effects

```
ansible-playbook neovim.yml
```

and you should see output that is similar to

```
➜  ansible-neovim-example git:(master) ✗ ansible-playbook neovim.yml
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

PLAY [The Great Neovim editor] *****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************
ok: [localhost]

PLAY RECAP *************************************************************************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
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

## Congrats!
you have ran your first ansible script!

Lets do some git

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Lets clone down neovim!
When it comes to using ansible, one of my favorite features is the docs and how
they are organized.  it just makes it so simple to google and get the exact
answer out you need.  ChatGPT is nice to use, but can sometimes lead you into
too much usage of odd features like scripting

* Google ansible git clone
* scroll the documentation and copy the one they suggest
* perhaps combine a few to make this most efficient!

<br>
<br>

But where do we put the code we find?  Well... remember that empty `tasks` key?

### expected task output


```yaml
  - name: Clone a repo with separate git directory
    ansible.builtin.git:
      repo: "https://github.com/neovim/neovim.git"
      dest: "{{dest_dir}}/neovim"
      single_branch: yes
      version: v0.10.2
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

## Become familiar with the build first
there will be several libs that you may require to get this working so to do
this correctly you will first want to build neovim by hand and keep track of
the libraries that you need.  There is likely a list of requirements in the
[BUILD.md](https://github.com/neovim/neovim/blob/master/BUILD.md)

### To make neovim
The command to run to make neovim is the following:

```
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
```

Now this will likely error with some missing library such as gettext or lua

<br>
<br>

Here are the packages i needed to install from apt to get neovim

```
sudo apt install cmake gettext lua5.1 liblua5.1-0-dev
```

once i have those packages i was able to install neovim fully from source.  Now
yours will be different than mine because you may be on a mac or a different
flavor of linux.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Translation time
Lets translate what i installed into an ansible command

* google how to ansible apt
* copy the proper command
* show them how to use vars inside a task!

### Expected task

```yaml
  - name: "Install neovim deps"
    become: true
    apt:
      name: "{{ packages }}"
      state: present
    vars:
      packages:
      - cmake
      - gettext
      - lua5.1
      - liblua5.1-0-dev
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

## Now build!
Now all we have to build neovim and then sudo make install!  We do the same
process

* google make
* copy the relevant instructions
* implement the new tasks
* ...
* neovim (which is profit)!

<br>
<br>

### Expected output
```yaml
  - name: make neovim
    make:
      chdir: "{{dest_dir}}/neovim"
      params:
        CMAKE_BUILD_TYPE: RelWithDebInfo

  - name: make install neovim
    become: yes
    make:
      chdir: "{{dest_dir}}/neovim"
      target: install

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

## OH NO! Crash!
If you are using apt and have to use sudo you should see the following error.

```
<127.0.0.1> ESTABLISH LOCAL CONNECTION FOR USER: theprimeagen
<127.0.0.1> EXEC /bin/sh -c 'echo ~theprimeagen && sleep 0'
<127.0.0.1> EXEC /bin/sh -c '( umask 77 && mkdir -p "` echo /home/theprimeagen/.ansible/tmp `"&& mkdir "` echo /home/theprimeagen/.ansible/tmp/ansible-tmp-1729644436.258113-1776352-80352927742333 `" && echo ansible-tmp-1729644436.258113-1776352-80352927742333="` echo /home/theprimeagen/.ansible/tmp/ansible-tmp-1729644436.258113-1776352-80352927742333 `" ) && sleep 0'
Using module file /usr/lib/python3/dist-packages/ansible/modules/apt.py
<127.0.0.1> PUT /home/theprimeagen/.ansible/tmp/ansible-local-1776140pp0cn_gm/tmp33hhis1k TO /home/theprimeagen/.ansible/tmp/ansible-tmp-1729644436.258113-1776352-80352927742333/AnsiballZ_apt.py
<127.0.0.1> EXEC /bin/sh -c 'chmod u+x /home/theprimeagen/.ansible/tmp/ansible-tmp-1729644436.258113-1776352-80352927742333/ /home/theprimeagen/.ansible/tmp/ansible-tmp-1729644436.258113-1776352-80352927742333/AnsiballZ_apt.py && sleep 0'
<127.0.0.1> EXEC /bin/sh -c 'sudo -H -S -n  -u root /bin/sh -c '"'"'echo BECOME-SUCCESS-rgqphadrxzwvmzhucbtnjvxefbemoqpt ; /usr/bin/python3 /home/theprimeagen/.ansible/tmp/ansible-tmp-1729644436.258113-1776352-80352927742333/AnsiballZ_apt.py'"'"' && sleep 0'
<127.0.0.1> EXEC /bin/sh -c 'rm -f -r /home/theprimeagen/.ansible/tmp/ansible-tmp-1729644436.258113-1776352-80352927742333/ > /dev/null 2>&1 && sleep 0'
fatal: [localhost]: FAILED! => {
    "changed": false,
    "module_stderr": "sudo: a password is required\n",
    "module_stdout": "",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 1
}
```

Well ansible does have the ability to become the sudo but it needs the creds to
do it, you can type in those creds before installing by using the -K flag

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Putting it all together

The complete script looks like:

```yaml
- name: The Great Neovim editor
  hosts: localhost
  vars:
    dest_dir: "{{ lookup('pipe', 'pwd') }}"

  tasks:
  - name: Clone a repo with separate git directory
    ansible.builtin.git:
      repo: "https://github.com/neovim/neovim.git"
      dest: "{{dest_dir}}/neovim"
      single_branch: yes
      version: v0.10.2

  - name: "Install neovim deps"
    become: true
    apt:
      name: "{{ packages }}"
      state: present
    vars:
      packages:
      - cmake
      - gettext
      - lua5.1
      - liblua5.1-0-dev

  - name: make neovim
    make:
      chdir: "{{dest_dir}}/neovim"
      params:
        CMAKE_BUILD_TYPE: RelWithDebInfo

  - name: make install neovim
    become: yes
    make:
      chdir: "{{dest_dir}}/neovim"
      target: install

```

that is what it takes to create neovim ansible.

<br>
<br>

### Why would i use this over a bash script
A bash script is great when you can execute it on a machine, but ansible allows
you to execute all these operations on a bunch of host machines at once.  It
also allows for some custom logic based on operating system so you could
interchange out the fetching mechanism to make it machine independent

<br>
<br>

There are most certainly I just have come to the conclusion that its not what I
like

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

