//
//  main.swift
//  ArrayFromRange
//
//  Created by Janosch Hildebrand on 12/02/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//


/* Swift 2.0b6
======== 10 ========
C:           111.3ns
Ptr:         109.5ns
Append:      314.1ns
Map:         212.9ns
Range:       223.3ns
====================

======= 100 ========
C:           207.9ns
Ptr:         284.7ns
Append:      734.3ns
Map:         368.4ns
Range:       333.4ns
====================

======= 1000 =======
C:           313.8ns
Ptr:         1108.ns
Append:      3688.ns
Map:         887.6ns
Range:       583.0ns
====================

======= 1000 =======
C:           300.1ns
Ptr:         1108.ns
Append:      3688.ns
Map:         883.0ns
Range:       571.9ns
====================

====== 10000 =======
C:           4.721us
Ptr:         10.31us
Append:      35.91us
Map:         7.709us
Range:       6.358us
====================

====== 100000 ======
C:           44.61us
Ptr:         101.9us
Append:      350.9us
Map:         78.37us
Range:       55.54us
====================

====== 1000000 ======
C:            3.024ms
Ptr:          2.923ms
Append:       4.149ms
Map:          2.808ms
Range:        2.844ms
=====================
*/



let testcases = [testC, ptrTest, appendTest, mapTest, rangeTest]
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
    print(resultGroup)
}


