//
//  main.swift
//  SwiftPerf
//
//  Created by Janosch Hildebrand on 30/08/15.
//
//

import Chronos


let testcases = [createTest, removeLoop, removeDirect, removeFirst, firstRemove]
let names = ["Create Set", "RemoveLoop", "RemoveDirect", "RemoveFirst", "FirstRemove"]
let count = 100000


var results = [TestcaseResult]()

for (name, testcase) in zip(names, testcases) {
    let set = createSet(count)
    let duration = Stopwatch.time {
        testcase(set)
    }
    
    results.append(TestcaseResult(name: name, time: duration))
}

let resultGroup = TestcaseGroupResult(input: count, results: results)
print(resultGroup)