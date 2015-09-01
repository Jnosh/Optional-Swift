//
//  main.swift
//  GeneratorOfPerf
//
//  Created by Janosch Hildebrand on 25/03/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

/* Swift 1.2
==============================
Baseline:              8.410ms
GeneratorSequence:     10.63ms
AnySequence:           67.48ms
AnyGenerator:          63.35ms
Generic Sequence:      10.56ms
Generic Generator:     10.53ms
==============================

FMO
==============================
Baseline:              3.010ms
GeneratorSequence:     2.690ms
AnySequence:           68.64ms
AnyGenerator:          58.72ms
Generic Sequence:      3.020ms
Generic Generator:     2.010ms
==============================
*/

/* Swift 2.0b6
==============================
Baseline:              3.362ms
GeneratorSequence:     5.372ms
AnySequence:           34.06ms
MyAnySequence:         34.32ms
AnyGenerator Closure:  26.70ms
AnyGenerator:          5.376ms
MyClosureAnySequence:  33.80ms
Generic Sequence:      5.374ms
Generic Generator:     5.381ms
==============================

FMO
========= [1000 by 1000] =========
Baseline:                  1.012ms
GeneratorSequence:         1.109ms
AnySequence:               34.10ms
AnyGenerator:              34.46ms
AnyGenerator Closure:      26.82ms
Generic Sequence:          1.011ms
Generic Generator:         1.011ms
MyAnySequence:             1.010ms
MyClosureAnySequence:      1.010ms
==================================
*/


let testcases = [baselineTest, generatorSequenceTest, anySequenceTest, myAnySequenceTest, anyGeneratorClosureTest, anyGeneratorTest, myClosureAnySequenceTest, genericSequence, genericGenerator]
let names = ["Baseline", "GeneratorSequence", "AnySequence", "AnyGenerator", "AnyGenerator Closure", "Generic Sequence", "Generic Generator", "MyAnySequence", "MyClosureAnySequence"]
let iterations = 100
let size = DiscreteSize(width: 1000, height: 1000)


var results = [TestcaseResult]()

for (name, testcase) in zip(names, testcases) {
    let duration = Stopwatch.meanTime(iterations: iterations) {
        testcase(size)
    }
    
    results.append(TestcaseResult(name: name, time: duration))
}

let resultGroup = TestcaseGroupResult(input: size, results: results)
print(resultGroup)






