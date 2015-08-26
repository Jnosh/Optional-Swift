//
//  Types.swift
//  AnySequenceTest
//
//  Created by Janosch Hildebrand on 04/08/15.
//  Copyright © 2015 Janosch Hildebrand. All rights reserved.
//


struct MyClosureAnySequence<Element> : SequenceType {
    let generator: () -> AnyGenerator<Element>
    init<S : SequenceType where S.Generator.Element == Element>(_ base: S) {
        generator = { anyGenerator(base.generate()) }
    }
    init<G : GeneratorType where G.Element == Element>(_ makeUnderlyingGenerator: () -> G) {
        generator = { anyGenerator(makeUnderlyingGenerator()) }
    }
    func generate() -> AnyGenerator<Element> {
        return generator()
    }
}


class _MyAnySequenceBox {
    func generate() -> AnyObject {
        fatalError()
    }
}
class _MySequenceBox<Seq: SequenceType>: _MyAnySequenceBox {
    let _base: Seq
    init(_ base: Seq) { _base = base }
    override func generate() -> AnyObject {
        return anyGenerator(_base.generate())
    }
}

class _MyClosureBasedSequence<G: GeneratorType>: SequenceType {
    let _makeUnderlyingGenerator: () -> G
    init(_ makeUnderlyingGenerator: () -> G) {
        _makeUnderlyingGenerator = makeUnderlyingGenerator
    }
    func generate() -> G {
        return _makeUnderlyingGenerator()
    }
}

struct MyAnySequence<Element> : SequenceType {
    let _box: _MyAnySequenceBox
    
    init<S : SequenceType where S.Generator.Element == Element>(_ base: S) {
        _box = _MySequenceBox(base)
    }
    init<G : GeneratorType where G.Element == Element>(_ makeUnderlyingGenerator: () -> G) {
        _box = _MySequenceBox(_MyClosureBasedSequence(makeUnderlyingGenerator))
    }
    
    func generate() -> AnyGenerator<Element> {
        return _box.generate() as! AnyGenerator<Element>
    }
}
