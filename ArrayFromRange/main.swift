//
//  main.swift
//  ArrayFromRange
//
//  Created by Janosch Hildebrand on 12/02/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//


/* Swift 2.1b2

======== 10 ========
C:           124.6ns
Ptr:         103.3ns
Append:      289.6ns
Map:         844.2ns
Range:       217.2ns
====================

======= 100 ========
C:           210.8ns
Ptr:         290.5ns
Append:      509.6ns
Map:         4220.ns
Range:       337.0ns
====================

======= 1000 =======
C:           302.1ns
Ptr:         1109.ns
Append:      1650.ns
Map:     3.800e+04ns
Range:       574.7ns
====================

======= 1000 =======
C:           311.6ns
Ptr:         1132.ns
Append:      1777.ns
Map:     3.814e+04ns
Range:       589.0ns
====================

====== 10000 =======
C:           5.078us
Ptr:         10.70us
Append:      16.92us
Map:         383.6us
Range:       5.514us
====================

====== 100000 ======
C:           46.52us
Ptr:         103.3us
Append:      151.8us
Map:         3846.us
Range:       59.90us
====================

====== 1000000 ======
C:            3.150ms
Ptr:          3.196ms
Append:       3.471ms
Map:          39.32ms
Range:        3.232ms
=====================
*/

import Chronos

let testcases = [mallocTest, ptrTest, appendTest, mapTest, rangeTest]
let names = ["C", "Ptr", "Append", "Map", "Range"]
let inputs = [10, 100, 1000, 1000, 10000, 100000, 1000000]
let iterations = 1000


for input in inputs {
    var results = [TestcaseResult]()

    for (name, testcase) in zip(names, testcases) {
        let duration = Stopwatch.meanTime(iterations: iterations) {
            testcase(input)
        }
        
        results.append(TestcaseResult(name: name, time: duration))
    }
    
    let resultGroup = TestcaseGroupResult(input: input, results: results)
    print(resultGroup.description)
}


