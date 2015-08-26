//
//  main.swift
//  GeneratorOfPerf
//
//  Created by Janosch Hildebrand on 25/03/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

/* Swift 1.2
8.41354
10.633364
67.482037
63.358729
10.564091
10.538189
*/

/* Swift 1.2 (FMO)
3.017241
2.69113
68.649413
58.726634
3.028329
2.011253
*/


func sequenceF<S: SequenceType where S.Generator.Element == DiscretePoint>(sequence: S) {
    for _ in sequence {
    }
}

func generateF<G: GeneratorType where G.Element == DiscretePoint>(generator: G) {
    for _ in GeneratorSequence(generator) {
    }
}


let size = DiscreteSize(width: 1000, height: 1000)


let s1 = measureNetTime(10, samples: 10) {
    for _ in size {
    }
}
print(s1.milliseconds)


let genseq = GeneratorSequence(size.generate())
let s2 = measureNetTime(10, samples: 10) {
    for _ in genseq {
    }
}
print(s2.milliseconds)


let anySequence = AnySequence(size)
let s3 = measureNetTime(10, samples: 10) {
    for _ in anySequence {
    }
}
print(s3.milliseconds)


// let anyGen = anyGenerator(size.generate())
let s4 = measureNetTime(10, samples: 10) {
    var g = size.generate()
    for pt in anyGenerator(size.generate()) {
    }
}
print(s4.milliseconds)

let s4_2 = measureNetTime(10, samples: 10) {
    var g = size.generate()
    for pt in anyGenerator( { return g.next() }) {
    }
}
print(s4_2.milliseconds)



let s5 = measureNetTime(10, samples: 10) {
    sequenceF(size)
}
print(s5.milliseconds)


let generator = size.generate()
let s6 = measureNetTime(10, samples: 10) {
    generateF(generator)
}
print(s6.milliseconds)


let myClosureSeq = MyClosureAnySequence(size)
let s7 = measureNetTime(10, samples: 10) {
    for _ in myClosureSeq {
    }
}
print(s7.milliseconds)


let myAnySeq = MyAnySequence(size)
let s8 = measureNetTime(10, samples: 10) {
    for _ in myAnySeq {
    }
}
print(s8.milliseconds)


