# Swift?

A collection of Swift microbenchmarks & experiments.



This project collects Swift microbenchmarks & related experiments.
Every now and then I try to test the (performance) behaviour of some
aspect of the Swift compiler. If I manage to reduce it to a small
testcase & remember to keep it around I'll try to add it here.

**All the usual caveats for microbenchmarks apply.**

* You probably are not measuring what you think you are measuring.
* Your interpretation of the results is likely tp be wrong.
* The tests generally degenerate into testing something completely unrelated.
* Don't expect results to have any impact in real world code.
* The compiler is your friend.
* The compiler is your enemy.


## Test Results

I try to collect some results with previous versions of the compiler.
These are mostly for my personal reference so I can see if there were
any major changes in a new compiler version or if one of the tests
broke because the compiler figured out that the tests are essentially
busywork that it can eliminate completely (which in itself is useful
knowledge).

My current test machines are an iMac12,1 and a MacPro3,1. Your results
will differ.

## The Tests

TODO: Briefly describe the individual tests.


## LICENSE

```
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org>
```