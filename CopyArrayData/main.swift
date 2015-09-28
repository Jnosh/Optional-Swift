//
//  main.swift
//  CopyArrayData
//
//  Created by Janosch Hildebrand on 22/04/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

/* Swift 2.1b2

================ 10 =================
Baseline:                     48.59ns
memcpy:                       403.9ns
assignFrom:                   394.6ns
Array append:                 104.9ns
Array extend:                 77.52ns
Array replace:                60.98ns
Slice append:                 138.1ns
Slice extend:                 107.3ns
Slice replace:                93.53ns
ArrayType append:             146.2ns
ArrayType extend:             107.1ns
ArrayType replace:            87.04ns
ArrayType Array:              90.50ns
ArrayType nativeBuffer:       89.07ns
ArrayType buffer:             89.47ns
ArrayType withBufferPtr:      91.83ns
ArrayType baseAddress:        88.69ns
Collection append:            146.2ns
Collection extend:            106.8ns
Collection replace:           86.72ns
Collection Array:             90.50ns
Sequence append:              146.2ns
Sequence extend:              128.7ns
Sequence Array:               90.32ns
AnySequence append:           5833.ns
AnySequence extend:           5730.ns
AnySequence Array:            304.5ns
AnyGenerator append:          320.1ns
AnyGenerator extend:          319.8ns
AnyGenerator Array:           320.4ns
=====================================

================ 100 ================
Baseline:                     29.80ns
memcpy:                       418.0ns
assignFrom:                   484.1ns
Array append:                 343.0ns
Array extend:                 90.10ns
Array replace:                162.9ns
Slice append:                 375.9ns
Slice extend:                 118.7ns
Slice replace:                218.7ns
ArrayType append:             455.2ns
ArrayType extend:             118.7ns
ArrayType replace:            189.0ns
ArrayType Array:              190.0ns
ArrayType nativeBuffer:       186.8ns
ArrayType buffer:             195.0ns
ArrayType withBufferPtr:      198.6ns
ArrayType baseAddress:        191.9ns
Collection append:            455.9ns
Collection extend:            117.6ns
Collection replace:           187.9ns
Collection Array:             189.4ns
Sequence append:              455.5ns
Sequence extend:              226.0ns
Sequence Array:               196.3ns
AnySequence append:       4.363e+04ns
AnySequence extend:       4.393e+04ns
AnySequence Array:            409.4ns
AnyGenerator append:          749.3ns
AnyGenerator extend:          590.5ns
AnyGenerator Array:           602.7ns
=====================================

=============== 1000 ================
Baseline:                     210.8ns
memcpy:                       578.0ns
assignFrom:                   1317.ns
Array append:                 2712.ns
Array extend:                 259.9ns
Array replace:                1473.ns
Slice append:                 2581.ns
Slice extend:                 283.1ns
Slice replace:                1421.ns
ArrayType append:             3604.ns
ArrayType extend:             284.7ns
ArrayType replace:            1236.ns
ArrayType Array:              1321.ns
ArrayType nativeBuffer:       1236.ns
ArrayType buffer:             1348.ns
ArrayType withBufferPtr:      1289.ns
ArrayType baseAddress:        1287.ns
Collection append:            3486.ns
Collection extend:            287.6ns
Collection replace:           1234.ns
Collection Array:             1237.ns
Sequence append:              3488.ns
Sequence extend:              1180.ns
Sequence Array:               1259.ns
AnySequence append:       4.443e+05ns
AnySequence extend:       4.225e+05ns
AnySequence Array:            1448.ns
AnyGenerator append:          3377.ns
AnyGenerator extend:          3432.ns
AnyGenerator Array:           3414.ns
=====================================

=============== 1000 ================
Baseline:                     212.4ns
memcpy:                       577.2ns
assignFrom:                   1312.ns
Array append:                 2582.ns
Array extend:                 246.9ns
Array replace:                1212.ns
Slice append:                 2577.ns
Slice extend:                 274.7ns
Slice replace:                1420.ns
ArrayType append:             3487.ns
ArrayType extend:             281.3ns
ArrayType replace:            1247.ns
ArrayType Array:              1240.ns
ArrayType nativeBuffer:       1247.ns
ArrayType buffer:             1294.ns
ArrayType withBufferPtr:      1250.ns
ArrayType baseAddress:        1253.ns
Collection append:            3488.ns
Collection extend:            281.8ns
Collection replace:           1246.ns
Collection Array:             1235.ns
Sequence append:              3488.ns
Sequence extend:              1179.ns
Sequence Array:               1234.ns
AnySequence append:       4.435e+05ns
AnySequence extend:       4.251e+05ns
AnySequence Array:            1455.ns
AnyGenerator append:          3047.ns
AnyGenerator extend:          3048.ns
AnyGenerator Array:           3040.ns
=====================================

=============== 10000 ===============
Baseline:                     8.279us
memcpy:                       10.75us
assignFrom:                   16.00us
Array append:                 29.29us
Array extend:                 10.47us
Array replace:                12.45us
Slice append:                 28.33us
Slice extend:                 8.544us
Slice replace:                13.77us
ArrayType append:             34.80us
ArrayType extend:             8.298us
ArrayType replace:            11.87us
ArrayType Array:              11.98us
ArrayType nativeBuffer:       12.91us
ArrayType buffer:             12.05us
ArrayType withBufferPtr:      12.05us
ArrayType baseAddress:        11.98us
Collection append:            34.16us
Collection extend:            8.331us
Collection replace:           10.90us
Collection Array:             10.97us
Sequence append:              34.21us
Sequence extend:              10.75us
Sequence Array:               11.00us
AnySequence append:           4280.us
AnySequence extend:           4246.us
AnySequence Array:            11.25us
AnyGenerator append:          100.9us
AnyGenerator extend:          101.1us
AnyGenerator Array:           100.8us
=====================================

============== 100000 ===============
Baseline:                     134.3us
memcpy:                       133.5us
assignFrom:                   98.95us
Array append:                 270.2us
Array extend:                 154.9us
Array replace:                112.6us
Slice append:                 258.7us
Slice extend:                 164.5us
Slice replace:                138.8us
ArrayType append:             396.7us
ArrayType extend:             148.9us
ArrayType replace:            114.3us
ArrayType Array:              114.5us
ArrayType nativeBuffer:       114.5us
ArrayType buffer:             107.3us
ArrayType withBufferPtr:      104.4us
ArrayType baseAddress:        117.3us
Collection append:            358.2us
Collection extend:            141.6us
Collection replace:           143.1us
Collection Array:             134.8us
Sequence append:              349.8us
Sequence extend:              110.7us
Sequence Array:               121.9us
AnySequence append:       4.345e+04us
AnySequence extend:       4.304e+04us
AnySequence Array:            115.5us
AnyGenerator append:          548.3us
AnyGenerator extend:          836.2us
AnyGenerator Array:           1005.us
=====================================

============== 1000000 ==============
Baseline:                     3.470ms
memcpy:                       3.541ms
assignFrom:                   5.729ms
Array append:                 5.530ms
Array extend:                 3.466ms
Array replace:                5.524ms
Slice append:                 5.947ms
Slice extend:                 3.303ms
Slice replace:                5.635ms
ArrayType append:             6.200ms
ArrayType extend:             3.112ms
ArrayType replace:            5.808ms
ArrayType Array:              5.727ms
ArrayType nativeBuffer:       5.570ms
ArrayType buffer:             5.393ms
ArrayType withBufferPtr:      5.349ms
ArrayType baseAddress:        5.154ms
Collection append:            6.201ms
Collection extend:            3.310ms
Collection replace:           5.472ms
Collection Array:             5.526ms
Sequence append:              6.325ms
Sequence extend:              5.686ms
Sequence Array:               5.301ms
AnySequence append:           427.5ms
AnySequence extend:           432.6ms
AnySequence Array:            5.442ms
AnyGenerator append:          8.727ms
AnyGenerator extend:          8.091ms
AnyGenerator Array:           9.111ms
=====================================
*/

import Chronos


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
    print(resultGroup.description)
}


