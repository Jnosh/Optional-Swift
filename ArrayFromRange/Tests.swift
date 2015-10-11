//
//  Tests.swift
//  SwiftPerf
//
//  Created by Janosch Hildebrand on 31/08/15.
//
//

import Foundation
import Chronos

// Replacement for C-code test. Performs essentially identical.
// For example both Swift & Clang get this down to a no-op without the consumeValue() call.
// Currently none of the other tests get optimized away without it.
func mallocTest(n: Int) {
    let array = UnsafeMutablePointer<Int>(malloc(n * sizeof(Int)))
    for i in 0..<n {
        array[i] = i
    }

    consumeValue(array)
    free(array)
}

func ptrTest(n: Int) {
    let base = UnsafeMutablePointer<Int>.alloc(n)
    for i in 0..<n {
        base[i] = i
    }

    consumeValue(base)
    base.destroy(n)
    base.dealloc(n)
}

func appendTest(n: Int) {
    var array = Array<Int>()
    array.reserveCapacity(n)
    for i in 0..<n {
        array.append(i)
    }

    consumeValue(array)
}

func mapTest(n: Int) {
    let range = 0..<n
    let array = range.map { $0 }

    consumeValue(array)
}

func rangeTest(n: Int) {
    let array = Array(0..<n)

    consumeValue(array)
}
