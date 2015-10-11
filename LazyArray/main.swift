//
//  main.swift
//  LazyArrayPerf
//
//  Created by Janosch Hildebrand on 22/04/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

import Chronos


let inputs: [Int] = [10, 100, 1_000, 10_000, 100_000, 1_000_000]
let iterations = 1000

let testcases = [baseline, reverseIterate, arrayReverseIterate, lazyReverseIterate]
let names = ["Baseline", "Reverse", "Array(reverse)", "Lazy Reverse"]


for input in inputs {
    var results = [TestcaseResult]()
    let array = Array<Int>(count: input, repeatedValue: 0)
    
    for (name, testcase) in zip(names, testcases) {
        let durations = Stopwatch.time(iterations: iterations) {
            testcase(array)
        }
        
        results.append(TestcaseResult(name: name, runtimes: durations))
    }
    
    let resultGroup = TestcaseGroupResult(input: input, results: results)
    print(resultGroup)
}

