//
//  main.swift
//  AnySequence
//
//  Created by Janosch Hildebrand on 25/03/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

import Chronos

let iterations = 100
let size = DiscreteSize(width: 1000, height: 1000)


// MARK: Stdlib

let testcases = [baselineTest, generatorSequenceTest, anySequenceTest, anyGeneratorTest, anyGeneratorClosureTest, genericSequence, genericGenerator]
let names = ["Baseline", "GeneratorSequence", "AnySequence", "AnyGenerator", "AnyGenerator Closure", "Generic Sequence", "Generic Generator"]

let resultSwift = runTestcaseGroup(testcases: testcases, names: names, input: size, iterations: iterations)
print("Stdlib")
print(resultSwift)


// MARK: Local Reimplementations

let localReimplementations = [anySequence_Test, anyGenerator_Test, anyGenerator_ClosureTest, myAnyGeneratorTest, myAnyGeneratorClosureTest, anySequence__Test, anyGenerator__Test, anyGenerator__ClosureTest]
let reimplementationNames = ["AnySequence_", "AnyGenerator_", "AnyGenerator_ Closure", "MyAnyGenerator", "MyAnyGenerator Closure", "AnySequence__", "AnyGenerator__", "AnyGenerator__ Closure"]

let resultLocal = runTestcaseGroup(testcases: localReimplementations, names: reimplementationNames, input: size, iterations: iterations)
print("Local")
print(resultLocal)


// MARK: Framework Reimplementations

let frameworkReimplementations = [f_anySequence_Test, f_anyGenerator_Test, f_anyGenerator_ClosureTest, f_myAnyGeneratorTest, f_myAnyGeneratorClosureTest, f_anySequence__Test, f_anyGenerator__Test, f_anyGenerator__ClosureTest]

let resultFramework = runTestcaseGroup(testcases: frameworkReimplementations, names: reimplementationNames, input: size, iterations: iterations)
print("Framework")
print(resultFramework)




