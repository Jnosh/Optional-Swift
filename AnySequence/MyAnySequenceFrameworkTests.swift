//
//  MyAnySequenceFrameworkTests.swift
//  SwiftPerf
//
//  Created by Janosch Hildebrand on 10/10/15.
//
//

import AnySequenceFramework
import Chronos

func f_anySequence_Test(size: DiscreteSize) {
    let anySequence = AnySequenceFramework.AnySequence_(size)
    for p in anySequence {
        consumeValue(p)
    }
}

func f_anyGenerator_Test(size: DiscreteSize) {
    let generator = AnySequenceFramework.anyGenerator_(size.generate())
    for p in generator {
        consumeValue(p)
    }
}

func f_anyGenerator_ClosureTest(size: DiscreteSize) {
    var g = size.generate()
    let generator = AnySequenceFramework.anyGenerator_( { return g.next() } )
    for p in generator {
        consumeValue(p)
    }
}

func f_myAnyGeneratorTest(size: DiscreteSize) {
    let generator = AnySequenceFramework.MyAnyGenerator(size.generate())
    for p in generator {
        consumeValue(p)
    }
}

func f_myAnyGeneratorClosureTest(size: DiscreteSize) {
    var g = size.generate()
    let generator = AnySequenceFramework.MyAnyGenerator( { return g.next() } )
    for p in generator {
        consumeValue(p)
    }
}

func f_anySequence__Test(size: DiscreteSize) {
    let anySequence = AnySequenceFramework.AnySequence__(size)
    for p in anySequence {
        consumeValue(p)
    }
}

func f_anyGenerator__Test(size: DiscreteSize) {
    let generator = AnySequenceFramework.AnyGenerator__(size.generate())
    for p in generator {
        consumeValue(p)
    }
}

func f_anyGenerator__ClosureTest(size: DiscreteSize) {
    var g = size.generate()
    let generator = AnySequenceFramework.AnyGenerator__( { return g.next() } )
    for p in generator {
        consumeValue(p)
    }
}