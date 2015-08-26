//
//  main.swift
//  Perf test
//
//  Created by Janosch Hildebrand on 12/02/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

import Foundation

func testPtr(n: Int) {
    let base = UnsafeMutablePointer<Int>.alloc(n)
    for i in 0..<n {
        base[i] = i
    }
    base.destroy(n)
    base.dealloc(n)
}

func testAppend(n: Int) {
    var array = Array<Int>()
    array.reserveCapacity(n)
    for i in 0..<n {
        array.append(i)
    }
}

func testMap(n: Int) {
    let range = 0..<n
    let _ = range.map { $0 }
}

func testRange(n: Int) {
    let _ = Array(0..<n)
}

func runTests() {
    let tests = [testC, testPtr, testAppend, testMap, testRange]
    let names = paddedNames(["C", "Ptr", "Append", "Map", "Range"])

    let iterations: Int = 1000

    var n = 1
    while n <= 1000000 {
        n *= 10

        var results: [NSTimeInterval] = []

        for testFun in tests {
            let start = NSDate()
            for _ in 0..<iterations {
                testFun(n)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }

        print("-----------------------------")
        print("n = \(n)")
        for (result, name) in zip(results, names) {
            let format = "%.2f"
            print("\(name):  \(NSString(format: format, result * 1_000_000))us")
        }
        print("-----------------------------")
    }
}

runTests()


