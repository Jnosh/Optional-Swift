//
//  Tests.swift
//  SwiftPerf
//
//  Created by Janosch Hildebrand on 01/09/15.
//
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


func sequenceF<S: SequenceType where S.Generator.Element == DiscretePoint>(sequence: S) {
    for _ in sequence {
    }
}

func genericSequence(size: DiscreteSize) {
    sequenceF(size)
}


func generateF<G: GeneratorType where G.Element == DiscretePoint>(generator: G) {
    for _ in GeneratorSequence(generator) {
    }
}

func genericGenerator(size: DiscreteSize) {
    generateF(size.generate())
}


func myAnySequenceTest(size: DiscreteSize) {
    let anySequence = MyAnySequence(size)
    for _ in anySequence {
    }
}

func myClosureAnySequenceTest(size: DiscreteSize) {
    let anySequence = MyClosureAnySequence(size)
    for _ in anySequence {
    }
}

