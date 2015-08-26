//
//  main.swift
//  CopyArrayData
//
//  Created by Janosch Hildebrand on 22/04/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

import Foundation

func testBaseline(n: Int, iterations: Int) -> NSTimeInterval {
    let source = UnsafeMutablePointer<Int>.alloc(n)
    source.initializeFrom(Repeat(count: n, repeatedValue: 0))
    let target = UnsafeMutablePointer<Int>.alloc(n)
    target.initializeFrom(Repeat(count: n, repeatedValue: 0))

    let start = NSDate()
    for _ in 0..<iterations {
        target.assignFrom(source, count: n)
        // memcpy(target, source, strideof(Int) * n)
    }
    let end = NSDate()

    source.destroy(n)
    source.dealloc(n)
    target.destroy(n)
    target.dealloc(n)

    return end.timeIntervalSinceDate(start) / Double(iterations)
}

func paddedNames(names: [String]) -> [String] {
    let lengths = names.map { return $0.characters.count }
    let maxLength = lengths.maxElement()!

    return zip(names, lengths).map { (name: String, length: Int) -> String in
        let padding = Repeat<Character>(count: maxLength - length, repeatedValue: " ")
        return name + String(padding)
    }
}


func runTests() {
    let names = paddedNames(["Baseline"] + testNames)
    let iterations: Int = 100

    for var count = 10; count <= 1_000_000; count *= 10 {
        var results: [NSTimeInterval] = [testBaseline(count, iterations: iterations)]
        let source = Array<Int>(count: count, repeatedValue: 0)
        var target = Array<Int>(count: count, repeatedValue: 0)
/*
        for testFun in tests {
            let start = NSDate()
            for _ in 0..<iterations {
                testFun(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
*/
        
        
        
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                memcopy(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                assignFrom(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                arrayAppend(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                arrayExtend(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                arrayReplace(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }

        do {
            let start = NSDate()
            for _ in 0..<iterations {
                sliceAppend(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                sliceExtend(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                sliceReplace(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                arrayTypeAppend(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                arrayTypeExtend(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                arrayTypeReplace(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }

        do {
            let start = NSDate()
            for _ in 0..<iterations {
                arrayTypeReplaceArray(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                arrayTypeReplaceNativeBuffer(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                arrayTypeReplaceBuffer(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                arrayTypeReplaceBufferPtr(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                arrayTypeReplaceBaseAddress(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }

        do {
            let start = NSDate()
            for _ in 0..<iterations {
                collectionAppend(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                collectionExtend(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                collectionReplace(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                collectionReplaceArray(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                sequenceAppend(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                sequenceExtend(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                sequenceReplaceArray(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                anySequenceAppend(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                anySequenceExtend(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        do {
            let start = NSDate()
            for _ in 0..<iterations {
                anySequenceReplaceArray(&target, source: source)
            }
            let end = NSDate()
            let dt = end.timeIntervalSinceDate(start) / Double(iterations)
            results.append(dt)
        }
        
        
        
        
        
        
        
        
        
        
        
        print("---------------------------------------")
        print("n = \(count)")
        for (result, name) in zip(results, names) {
            let format = "%.2f"
            print("\(name):  \(NSString(format: format, result * 1_000_000))us")
        }
        print("---------------------------------------")
    }
}


runTests()




