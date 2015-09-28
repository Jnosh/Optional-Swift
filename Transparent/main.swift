//
//  main.swift
//  Transparent
//
//  Created by Janosch Hildebrand on 30/08/15.
//
//


// TODO: need more experiments

// Datastructures like BinaryTree
// Subscript of sth
// ...


/*
@transparent can bring huge improvements to stuff linked from frameworks

However: Will !always! inline, even in debug builds (which can make debugging harder)
and its ise seems to be discouraged

Reasons for perf boosts differ by case but generally:

* Obviously save a function call
* Compiler can reason about surrounding code & optimize
* Can also take static knowledge into account depending on situation
* Can specialize generics (odd test is a good example)
* Odd baseline has to use function used for all IntegerTypes, others are specialized



Ideally we would probably want generic specialization and inlining (at compiler's discretion)
for linked frameworks but only in when optimizing, not neccessarily always and
automatically without marking functions...


Current results (2.0b6):

Rotate baseline:    33.50ms
Rotate transparent: 11.42ms
Rotate local:       11.40ms
Odd baseline:    508.06ms
Odd transparent: 334.33µs
Odd local:       334.22µs
Division dynamic baseline:        874.76ms
Division semi-static baseline:    864.77ms
Division static baseline:         877.23ms
Division dynamic transparent:     131.41ms
Division semi-static transparent: 42.88ms
Division static transparent:      9.54µs
Division dynamic local:           132.35ms
Division semi-static local:       42.87ms
Division static local:            9.53µs
*/

import TransparentFramework
import Chronos

// Clear console


let iterations = 10_000_000
let dynamicVal = Int(Process.argc)
let staticVal = 12
var value = 0


value = 0
let rotate1 = Stopwatch.time(iterations: iterations) {
    value = value.rotate(staticVal)
}

value = 0
let rotate2 = Stopwatch.time(iterations: iterations) {
    value = value.rotateTransparent(staticVal)
}

value = 0
let rotate3 = Stopwatch.time(iterations: iterations) {
    value = value.rotateLocal(staticVal)
}

print("Rotate baseline:    \(rotate1.description)")
print("Rotate transparent: \(rotate2.description)")
print("Rotate local:       \(rotate3.description)")


value = 0
let odd1 = Stopwatch.time(iterations: iterations) {
    value = dynamicVal.odd ? 0 : 1
}

value = 0
let odd2 = Stopwatch.time(iterations: iterations) {
    value = dynamicVal.oddTransparent ? 0 : 1
}

value = 0
let odd3 = Stopwatch.time(iterations: iterations) {
    value = dynamicVal.oddLocal ? 0 : 1
}

print("Odd baseline:    \(odd1.description)")
print("Odd transparent: \(odd2.description)")
print("Odd local:       \(odd3.description)")



value = 0
let division1 = Stopwatch.time(iterations: iterations) {
    value = roundUpDivision(value, divisor: dynamicVal)
}

value = 0
let division2 = Stopwatch.time(iterations: iterations) {
    value = roundUpDivision(value, divisor: staticVal)
}

value = 0
let division3 = Stopwatch.time(iterations: iterations) {
    value = roundUpDivision(staticVal, divisor: staticVal)
}

value = 0
let division4 = Stopwatch.time(iterations: iterations) {
    value = roundUpDivisionTransparent(value, divisor: dynamicVal)
}

value = 0
let division5 = Stopwatch.time(iterations: iterations) {
    value = roundUpDivisionTransparent(value, divisor: staticVal)
}

value = 0
let division6 = Stopwatch.time(iterations: iterations) {
    value = roundUpDivisionTransparent(staticVal, divisor: staticVal)
}

value = 0
let division7 = Stopwatch.time(iterations: iterations) {
    value = roundUpDivisionLocal(value, divisor: dynamicVal)
}

value = 0
let division8 = Stopwatch.time(iterations: iterations) {
    value = roundUpDivisionLocal(value, divisor: staticVal)
}

value = 0
let division9 = Stopwatch.time(iterations: iterations) {
    value = roundUpDivisionLocal(staticVal, divisor: staticVal)
}


print("Division dynamic baseline:        \(division1.description)")
print("Division semi-static baseline:    \(division2.description)")
print("Division static baseline:         \(division3.description)")
print("Division dynamic transparent:     \(division4.description)")
print("Division semi-static transparent: \(division5.description)")
print("Division static transparent:      \(division6.description)")
print("Division dynamic local:           \(division7.description)")
print("Division semi-static local:       \(division8.description)")
print("Division static local:            \(division9.description)")



