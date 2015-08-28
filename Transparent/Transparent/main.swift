//
//  main.swift
//  Transparent
//
//  Created by Janosch Hildebrand on 28/08/15.
//  Copyright © 2015 Janosch Hildebrand. All rights reserved.
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


    Current results (2.0b7):

Rotate baseline:    33.431137
Rotate transparent: 11.186808
Rotate local:       11.136758
Odd baseline:    504.865656
Odd transparent: 0.360646
Odd local:       0.350036
Division dynamic baseline:        853.739951
Division semi-static baseline:    855.789357
Division static baseline:         872.423342
Division dynamic transparent:     129.93641
Division semi-static transparent: 42.970146
Division static transparent:      2.5e-05
Division dynamic local:           132.297063
Division semi-static local:       42.80881
Division static local:            2.5e-05
*/


import TransparentFramework

let iterations = 10000000
let samples = 5

let dynamicVal = Int(Process.argc)
let staticVal = 12
var value = 0


value = 0
let rotate1 = measureGrossTime(iterations) {
    value = value.rotate(staticVal)
}

value = 0
let rotate2 = measureGrossTime(iterations) {
    value = value.rotateTransparent(staticVal)
}

value = 0
let rotate3 = measureGrossTime(iterations) {
    value = value.rotateLocal(staticVal)
}

print("Rotate baseline:    \(rotate1.milliseconds)")
print("Rotate transparent: \(rotate2.milliseconds)")
print("Rotate local:       \(rotate3.milliseconds)")


value = 0
let odd1 = measureGrossTime(iterations) {
    value = dynamicVal.odd ? 0 : 1
}

value = 0
let odd2 = measureGrossTime(iterations) {
    value = dynamicVal.oddTransparent ? 0 : 1
}

value = 0
let odd3 = measureGrossTime(iterations) {
    value = dynamicVal.oddLocal ? 0 : 1
}

print("Odd baseline:    \(odd1.milliseconds)")
print("Odd transparent: \(odd2.milliseconds)")
print("Odd local:       \(odd3.milliseconds)")



value = 0
let division1 = measureGrossTime(iterations) {
    value = roundUpDivision(value, divisor: dynamicVal)
}

value = 0
let division2 = measureGrossTime(iterations) {
    value = roundUpDivision(value, divisor: staticVal)
}

value = 0
let division3 = measureGrossTime(iterations) {
    value = roundUpDivision(staticVal, divisor: staticVal)
}

value = 0
let division4 = measureGrossTime(iterations) {
    value = roundUpDivisionTransparent(value, divisor: dynamicVal)
}

value = 0
let division5 = measureGrossTime(iterations) {
    value = roundUpDivisionTransparent(value, divisor: staticVal)
}

value = 0
let division6 = measureGrossTime(iterations) {
    value = roundUpDivisionTransparent(staticVal, divisor: staticVal)
}

value = 0
let division7 = measureGrossTime(iterations) {
    value = roundUpDivisionLocal(value, divisor: dynamicVal)
}

value = 0
let division8 = measureGrossTime(iterations) {
    value = roundUpDivisionLocal(value, divisor: staticVal)
}

value = 0
let division9 = measureGrossTime(iterations) {
    value = roundUpDivisionLocal(staticVal, divisor: staticVal)
}


print("Division dynamic baseline:        \(division1.milliseconds)")
print("Division semi-static baseline:    \(division2.milliseconds)")
print("Division static baseline:         \(division3.milliseconds)")
print("Division dynamic transparent:     \(division4.milliseconds)")
print("Division semi-static transparent: \(division5.milliseconds)")
print("Division static transparent:      \(division6.milliseconds)")
print("Division dynamic local:           \(division7.milliseconds)")
print("Division semi-static local:       \(division8.milliseconds)")
print("Division static local:            \(division9.milliseconds)")








