//
//  Tests.swift
//  AnySequence
//
//  Created by Janosch Hildebrand on 01/09/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

import Chronos

func baselineTest(size: DiscreteSize) {
    for p in size {
        consumeValue(p)
    }
}

func generatorSequenceTest(size: DiscreteSize) {
    let genseq = GeneratorSequence(size.generate())
    for p in genseq {
        consumeValue(p)
    }
}

func anySequenceTest(size: DiscreteSize) {
    let anySequence = AnySequence(size)
    for p in anySequence {
        consumeValue(p)
    }
}

func anyGeneratorTest(size: DiscreteSize) {
    let generator = AnyGenerator(size.generate())
    for p in generator {
        consumeValue(p)
    }
}

func anyGeneratorClosureTest(size: DiscreteSize) {
    var g = size.generate()
    let generator = AnyGenerator(body: { return g.next() } )
    for p in generator {
        consumeValue(p)
    }
}


func sequenceFunc<S: SequenceType where S.Generator.Element == DiscretePoint>(sequence: S) {
    for p in sequence {
        consumeValue(p)
    }
}

func genericSequence(size: DiscreteSize) {
    sequenceFunc(size)
}


func generateFunc<G: GeneratorType where G.Element == DiscretePoint>(generator: G) {
    for p in GeneratorSequence(generator) {
        consumeValue(p)
    }
}

func genericGenerator(size: DiscreteSize) {
    generateFunc(size.generate())
}

