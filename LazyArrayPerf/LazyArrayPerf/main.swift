//
//  main.swift
//  LazyArrayPerf
//
//  Created by Janosch Hildebrand on 22/04/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

import Foundation


func iterate(array: Array<Int>) {
    for _ in array { }
}

func reverseIterate(array: Array<Int>) {
    for _ in array.reverse() { }
}

func arrayReverseIterate(array: Array<Int>) {
    for _ in Array(array.reverse()) { }
}

func lazyReverseIterate(array: Array<Int>) {
    for _ in array.lazy.reverse() { }
}



func runTests() {
    let tests = [iterate, reverseIterate, arrayReverseIterate, lazyReverseIterate]
    let names = paddedNames(["Baseline", "reverse()", "Array.reverse()", "lazyReverse()"])
    let iterations: Int = 1000


    for var count = 10; count <= 1_000_000; count *= 10 {
        var results: [NSTimeInterval] = []
        let array = Array<Int>(count: count, repeatedValue: 0)

        for testFun in tests {
            let start = NSDate()
            for _ in 0..<iterations {
                testFun(array)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }

        print("-----------------------------")
        print("n = \(count)")
        for (result, name) in zip(results, names) {
            let format = "%.2f"
            print("\(name):  \(NSString(format: format, result * 1_000_000))us")
        }
        print("-----------------------------")
    }
}


runTests()

