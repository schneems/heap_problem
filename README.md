## Heap Problem

I've seen an issue where sometimes an object will not be retained, however calling `GC.start` will not clear it out of the heap. This repo shows that issue.

##

Run via

```
$ ruby run.rb
```

This will run both the "fail" case that demonstrates the problem and a "pass" case that uses `puts` and `10.times { GC.start }` to fix the issue.

```
$ ruby run.rb
== Calling `puts` and `10.times { GC.start }
  Address of string is: 0x7fa94c091468

  PASS expected: 0 actual: 0

== Calling only `GC.start`
  Address of string is: 0x7f897d04d400
  Found in heap dump:
    {"address":"0x7f897d04d400", "type":"STRING", "class":"0x7f897d04d298", "embedded":true, "bytesize":15, "value":"i am a string 2", "encoding":"UTF-8", "file":"fail.rb", "line":12, "method":"run", "generation":8, "memsize":40, "flags":{"wb_protected":true, "old":true, "uncollectible":true, "marked":true}}

  FAIL expected: 0 actual: 1
```

You can call individual files if you want

```
$ ruby fail.rb
$ ruby pass.rb
```

The only difference between the two files is this:

```
$ diff fail.rb pass.rb
28c28,29
< GC.start
---
> @stringio.puts "=="
> 10.times { GC.start }
```


Tested with Ruby `2.3.3p222` and `2.4.0preview3`.
