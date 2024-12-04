---
title: "Unix Tools!"
description: "unix tools"
---

## Unix Tools
The unix set is super useful to know and we can do quite a bit of useful
transformation with them.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## lets transform out! (the json file)
`sed` is a fun tool

* lets replace `foo` with `bar`
* lets replace `foo` or `bar` with `foo,foo` or `bar,bar`

```bash
➜  dev-prod-2 git:(main) cat out | sed 's/: "\(.*\)",/: "\1,\1",/'
```

### Expected
```bash
{"type": "foo,foo", "values": [1, 2, 3, 4, 5]}
{"type": "foo,foo", "values": [69, 420, 42, 69420]}
{"type": "bar,bar", "values": {"a": 42, "b": 69}}
{"type": "bar,bar", "values": {"a": 1337, "b": 420}}
{"type": "bar,bar", "values": {"a": 111, "b": 222}}
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

## find
list out files and do stuff

```bash
➜  dev-prod-2 git:(main) ✗ find . -maxdepth 1 -mindepth 1 -type f -exec grep -Hn "foo" {} \;
./out:1:{"type": "foo", "values": [1, 2, 3, 4, 5]}
./out:2:{"type": "foo", "values": [69, 420, 42, 69420]}
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

## xargs
a great tool

```bash
➜  dev-prod-2 git:(main) ✗ echo "1\n2\n3" | xargs -I {} curl https://{}.com
curl: (6) Could not resolve host: 1.com
curl: (6) Could not resolve host: 2.com
curl: (6) Could not resolve host: 3.com
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

## parallel
such a great tool

lets write a file with the entries of 1 through 9, per line
```
1
2
3
4
5
6
7
8
9
```

now lets use parallel to control how fast it requests

```bash
➜  dev-prod-2 git:(main) ✗ cat count | parallel -j 5 "curl https://{}.com"
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

## Just a touch of awk
I don't know a lot of awk and you can do quite a bit, but the little i do know is really good

```bash
➜  dev-prod-2 git:(main) ✗ ps aux | grep vim | awk '{ sum += $2 } END { print sum }'
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

