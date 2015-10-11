//
//  MyAnySequenceTests.swift
//  SwiftPerf
//
//  Created by Janosch Hildebrand on 10/10/15.
//
//

func anySequence_Test(size: DiscreteSize) {
    let anySequence = AnySequence_(size)
    for _ in anySequence {
    }
}

func anyGenerator_Test(size: DiscreteSize) {
    let generator = anyGenerator_(size.generate())
    for _ in generator {
    }
}

func anyGenerator_ClosureTest(size: DiscreteSize) {
    var g = size.generate()
    let generator = anyGenerator_( { return g.next() } )
    for _ in generator {
    }
}

func myAnyGeneratorTest(size: DiscreteSize) {
    let generator = MyAnyGenerator(size.generate())
    for _ in generator {
    }
}

func myAnyGeneratorClosureTest(size: DiscreteSize) {
    var g = size.generate()
    let generator = MyAnyGenerator( { return g.next() } )
    for _ in generator {
    }
}

func anySequence__Test(size: DiscreteSize) {
    let anySequence = AnySequence__(size)
    for _ in anySequence {
    }
}

func anyGenerator__Test(size: DiscreteSize) {
    let generator = AnyGenerator__(size.generate())
    for _ in generator {
    }
}

func anyGenerator__ClosureTest(size: DiscreteSize) {
    var g = size.generate()
    let generator = AnyGenerator__( { return g.next() } )
    for _ in generator {
    }
}