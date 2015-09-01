//
//  main.swift
//  SwiftPerf
//
//  Created by Janosch Hildebrand on 30/08/15.
//
//


/*
Swift 2.0b6

========= 100000 =========
Create Set:        22.84ms
RemoveLoop:        25.76ms
RemoveDirect:      20.64ms
RemoveFirst:   2.409e+04ms
FirstRemove:   2.330e+04ms
==========================
*/


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