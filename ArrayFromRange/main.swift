//
//  main.swift
//  ArrayFromRange
//
//  Created by Janosch Hildebrand on 12/02/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

import Chronos

let testcases = [mallocTest, ptrTest, appendTest, mapTest, rangeTest]
let names = ["Malloc", "Ptr", "Append", "Map", "Range"]
let inputs = [10, 100, 1000, 1000, 10000, 100000, 1000000]
let iterations = 1000

for input in inputs {
    let resultGroup = runTestcaseGroup(testcases: testcases, names: names, input: input, iterations: iterations)
    print(resultGroup)
}

