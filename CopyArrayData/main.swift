//
//  main.swift
//  CopyArrayData
//
//  Created by Janosch Hildebrand on 22/04/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//


let testcases = [
    memcopy, assignFrom,
    arrayAppend, arrayExtend, arrayReplace,
    sliceAppend, sliceExtend, sliceReplace,
    arrayTypeAppend, arrayTypeExtend, arrayTypeReplace, arrayTypeReplaceArray,
    arrayTypeReplaceNativeBuffer, arrayTypeReplaceBuffer, arrayTypeReplaceBufferPtr, arrayTypeReplaceBaseAddress,
    collectionAppend, collectionExtend, collectionReplace, collectionReplaceArray,
    sequenceAppend, sequenceExtend, sequenceReplaceArray,
    anySequenceAppend, anySequenceExtend, anySequenceReplaceArray,
    anyGeneratorAppend, anyGeneratorAppend, anyGeneratorAppend]

let names = [
    "memcpy", "assignFrom",
    "Array append", "Array extend", "Array replace",
    "Slice append", "Slice extend", "Slice replace",
    "ArrayType append", "ArrayType extend", "ArrayType replace", "ArrayType Array",
    "ArrayType nativeBuffer", "ArrayType buffer", "ArrayType withBufferPtr", "ArrayType baseAddress",
    "Collection append", "Collection extend", "Collection replace", "Collection Array",
    "Sequence append", "Sequence extend", "Sequence Array",
    "AnySequence append", "AnySequence extend", "AnySequence Array",
    "AnyGenerator append", "AnyGenerator extend", "AnyGenerator Array"]

let inputs = [10, 100, 1000, 1000, 10000, 100000, 1000000]
let iterations = 100


for input in inputs {
    var results = [TestcaseResult]()
    
    let baseline = TestcaseResult(name: "Baseline", time: testBaseline(input, iterations: iterations))
    results.append(baseline)
    
    let source = Array<Int>(count: input, repeatedValue: 0)
    var target = Array<Int>(count: input, repeatedValue: 0)
    
    for (name, testcase) in zip(names, testcases) {
        let duration = Stopwatch.meanTime(iterations: iterations) {
            testcase(&target, source: source)
        }
        
        results.append(TestcaseResult(name: name, time: duration))
    }
    
    let resultGroup = TestcaseGroupResult(input: input, results: results)
    print(resultGroup)
}


