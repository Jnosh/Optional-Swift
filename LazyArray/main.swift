//
//  main.swift
//  LazyArrayPerf
//
//  Created by Janosch Hildebrand on 22/04/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//


/*
Swift 2.0b6

============ 10 ============
Baseline:            71.06ns
Reverse:             70.60ns
Array(reverse):      285.3ns
Lazy Reverse:        70.65ns
============================

=========== 100 ============
Baseline:            131.1ns
Reverse:             130.4ns
Array(reverse):      729.6ns
Lazy Reverse:        339.8ns
============================

=========== 1000 ===========
Baseline:            1434.ns
Reverse:             1069.ns
Array(reverse):      2839.ns
Lazy Reverse:        746.4ns
============================

========== 10000 ===========
Baseline:            7.032us
Reverse:             6.754us
Array(reverse):      17.94us
Lazy Reverse:        6.747us
============================

========== 100000 ==========
Baseline:            66.98us
Reverse:             69.17us
Array(reverse):      175.9us
Lazy Reverse:        72.26us
============================

========= 1000000 ==========
Baseline:            672.9us
Reverse:             686.5us
Array(reverse):      5853.us
Lazy Reverse:        670.1us
============================
*/



let inputs: [Int] = [10, 100, 1_000, 10_000, 100_000, 1_000_000]
let testcases = [baseline, reverseIterate, arrayReverseIterate, lazyReverseIterate]
let names = ["Baseline", "Reverse", "Array(reverse)", "Lazy Reverse"]
let iterations = 1000


for input in inputs {
    var results = [TestcaseResult]()
    let array = Array<Int>(count: input, repeatedValue: 0)
    
    for (name, testcase) in zip(names, testcases) {
        let duration = Stopwatch.meanTime(iterations: iterations) {
            testcase(array)
        }
        
        results.append(TestcaseResult(name: name, time: duration))
    }
    
    let resultGroup = TestcaseGroupResult(input: input, results: results)
    print(resultGroup)
}

