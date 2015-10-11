//
//  main.swift
//  Transparent
//
//  Created by Janosch Hildebrand on 30/08/15.
//
//

import TransparentFramework
import Chronos

// TODO: need more experiments
//  * Effect on struct methods
//  * subscript
//  * can we use it & test parts of BinaryTree tests?

// TODO: cleanup
//  * Factor this into individual tests
//  * ideally while retaining ability to test optimization behaviour with static/dynamic inputs

let iterations = 10_000_000
let dynamicVal = Int(Process.argc)
let staticVal = 12
var value = 0


value = 0
let rotate1 = Stopwatch.totalTime(iterations: iterations) {
    value = value.rotate(staticVal)
}

value = 0
let rotate2 = Stopwatch.totalTime(iterations: iterations) {
    value = value.rotateTransparent(staticVal)
}

value = 0
let rotate3 = Stopwatch.totalTime(iterations: iterations) {
    value = value.rotateLocal(staticVal)
}

print("Rotate baseline:    \(rotate1)")
print("Rotate transparent: \(rotate2)")
print("Rotate local:       \(rotate3)")


value = 0
let odd1 = Stopwatch.totalTime(iterations: iterations) {
    value = dynamicVal.odd ? 0 : 1
}

value = 0
let odd2 = Stopwatch.totalTime(iterations: iterations) {
    value = dynamicVal.oddTransparent ? 0 : 1
}

value = 0
let odd3 = Stopwatch.totalTime(iterations: iterations) {
    value = dynamicVal.oddLocal ? 0 : 1
}

print("Odd baseline:    \(odd1)")
print("Odd transparent: \(odd2)")
print("Odd local:       \(odd3)")



value = 0
let division1 = Stopwatch.totalTime(iterations: iterations) {
    value = roundUpDivision(value, divisor: dynamicVal)
}

value = 0
let division2 = Stopwatch.totalTime(iterations: iterations) {
    value = roundUpDivision(value, divisor: staticVal)
}

value = 0
let division3 = Stopwatch.totalTime(iterations: iterations) {
    value = roundUpDivision(staticVal, divisor: staticVal)
}

value = 0
let division4 = Stopwatch.totalTime(iterations: iterations) {
    value = roundUpDivisionTransparent(value, divisor: dynamicVal)
}

value = 0
let division5 = Stopwatch.totalTime(iterations: iterations) {
    value = roundUpDivisionTransparent(value, divisor: staticVal)
}

value = 0
let division6 = Stopwatch.totalTime(iterations: iterations) {
    value = roundUpDivisionTransparent(staticVal, divisor: staticVal)
}

value = 0
let division7 = Stopwatch.totalTime(iterations: iterations) {
    value = roundUpDivisionLocal(value, divisor: dynamicVal)
}

value = 0
let division8 = Stopwatch.totalTime(iterations: iterations) {
    value = roundUpDivisionLocal(value, divisor: staticVal)
}

value = 0
let division9 = Stopwatch.totalTime(iterations: iterations) {
    value = roundUpDivisionLocal(staticVal, divisor: staticVal)
}


print("Division dynamic baseline:        \(division1)")
print("Division semi-static baseline:    \(division2)")
print("Division static baseline:         \(division3)")
print("Division dynamic transparent:     \(division4)")
print("Division semi-static transparent: \(division5)")
print("Division static transparent:      \(division6)")
print("Division dynamic local:           \(division7)")
print("Division semi-static local:       \(division8)")
print("Division static local:            \(division9)")



