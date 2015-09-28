//
//  main.swift
//  LazyArrayPerf
//
//  Created by Janosch Hildebrand on 22/04/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//


/*
Swift 2.1b2

============ 10 ============
Baseline:            110.5ns
Reverse:             109.0ns
Array(reverse):      313.9ns
Lazy Reverse:        99.68ns
============================

=========== 100 ============
Baseline:            399.7ns
Reverse:             426.9ns
Array(reverse):      803.4ns
Lazy Reverse:        428.4ns
============================

=========== 1000 ===========
Baseline:            3.420us
Reverse:             3.739us
Array(reverse):      5.496us
Lazy Reverse:        3.842us
============================

========== 10000 ===========
Baseline:            33.93us
Reverse:             36.90us
Array(reverse):      50.17us
Lazy Reverse:        37.66us
============================

========== 100000 ==========
Baseline:            342.4us
Reverse:             373.1us
Array(reverse):      487.2us
Lazy Reverse:        372.6us
============================

========= 1000000 ==========
Baseline:            3.950ms
Reverse:             4.159ms
Array(reverse):      10.19ms
Lazy Reverse:        4.155ms
============================
*/

import Chronos


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
    print(resultGroup.description)
}

