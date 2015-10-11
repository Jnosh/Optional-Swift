//
//  Tests.swift
//  AnySequence
//
//  Created by Janosch Hildebrand on 01/09/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

func baselineTest(size: DiscreteSize) {
    for _ in size {
    }
}

func generatorSequenceTest(size: DiscreteSize) {
    let genseq = GeneratorSequence(size.generate())
    for _ in genseq {
    }
}

func anySequenceTest(size: DiscreteSize) {
    let anySequence = AnySequence(size)
    for _ in anySequence {
    }
}

func anyGeneratorTest(size: DiscreteSize) {
    let generator = anyGenerator(size.generate())
    for _ in generator {
    }
}

func anyGeneratorClosureTest(size: DiscreteSize) {
    var g = size.generate()
    let generator = anyGenerator( { return g.next() } )
    for _ in generator {
    }
}


func sequenceFunc<S: SequenceType where S.Generator.Element == DiscretePoint>(sequence: S) {
    for _ in sequence {
    }
}

func genericSequence(size: DiscreteSize) {
    sequenceFunc(size)
}


func generateFunc<G: GeneratorType where G.Element == DiscretePoint>(generator: G) {
    for _ in GeneratorSequence(generator) {
    }
}

func genericGenerator(size: DiscreteSize) {
    generateFunc(size.generate())
}

