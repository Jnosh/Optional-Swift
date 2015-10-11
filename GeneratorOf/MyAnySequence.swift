//
//  MyAnySequence.swift
//  AnySequence
//
//  Created by Janosch Hildebrand on 04/08/15.
//  Copyright © 2015 Janosch Hildebrand. All rights reserved.
//

// Rob Napier's reimplementations
// https://github.com/rnapier/MyAnySequence


@noreturn private func _abstract(file: StaticString = __FILE__, line: UInt = __LINE__) {
    fatalError("Method must be overridden", file: file, line: line)
}

public class AnyGenerator_<Element> : _AnyGeneratorBase, GeneratorType, SequenceType {
    private override init() {
        guard self.dynamicType != AnyGenerator_.self else {
            fatalError("AnyGenerator<Element> instances can not be created; create a subclass instance instead")
        }
    }
    public func next() -> Element? {
        _abstract()
    }
}

public func anyGenerator_<G : GeneratorType>(base: G) -> AnyGenerator_<G.Element> {
    return _GeneratorBox(base)
}

public func anyGenerator_<Element>(body: () -> Element?) -> AnyGenerator_<Element> {
    return _FunctionGenerator(body)
}

public class _AnyGeneratorBase {} // You were expecting something complicated?

private final class _GeneratorBox<Base : GeneratorType> : AnyGenerator_<Base.Element> {
    private var base: Base
    private init(_ base: Base) { self.base = base }
    private override func next() -> Base.Element? {
        return base.next()
    }
}

private final class _FunctionGenerator<Element> : AnyGenerator_<Element> {
    private final let body: () -> Element?
    private init (_ body: () -> Element?) { self.body = body }
    private override func next() -> Element? {
        return body()
    }
}

public final class MyAnyGenerator<Element> : _AnyGeneratorBase, GeneratorType, SequenceType {
    private final var box: AnyGenerator_<Element>? = nil
    private override init() {}
    public init<G : GeneratorType where G.Element == Element>(_ base: G) {
        box = _GeneratorBox(base)
    }
    public init(_ body: () -> Element?) {
        box = _FunctionGenerator(body)
    }
    public func next() -> Element? {
        return box?.next()
    }
}

public struct AnySequence_<Element> : SequenceType {
    private let _box: _AnySequenceBox

    public init<S : SequenceType where S.Generator.Element == Element>(_ base: S) {
        _box = _SequenceBox(base)
    }

    public init<G : GeneratorType where G.Element == Element>(_ makeUnderlyingGenerator: () -> G) {
        _box = _SequenceBox(_ClosureBasedSequence(makeUnderlyingGenerator))
    }

    public func generate() -> AnyGenerator_<Element> {
        return _box.generate() as! AnyGenerator_<Element>
    }
}

private class _AnySequenceBox {
    private func generate() -> _AnyGeneratorBase {
        fatalError()
    }
    //  func _underestimateCount() -> Swift.Int
    //  func _initializeTo(ptr: Swift.UnsafeMutablePointer<Swift.Void>) -> Swift.UnsafeMutablePointer<Swift.Void>
    //  func _copyToNativeArrayBuffer() -> Swift._ContiguousArrayStorageBase
}

private final class _SequenceBox<Seq: SequenceType>: _AnySequenceBox {
    private let _base: Seq
    private init(_ base: Seq) { _base = base }
    private override func generate() -> _AnyGeneratorBase {
        return anyGenerator_(_base.generate())
    }
    //  override func _underestimateCount() -> Swift.Int
    //  override func _initializeTo(ptr: Swift.UnsafeMutablePointer<Swift.Void>) -> Swift.UnsafeMutablePointer<Swift.Void>
    //  override func _copyToNativeArrayBuffer() -> Swift._ContiguousArrayStorageBase
}

private struct _ClosureBasedSequence<G: GeneratorType>: SequenceType {
    private let _makeUnderlyingGenerator: () -> G
    private init(_ makeUnderlyingGenerator: () -> G) {
        _makeUnderlyingGenerator = makeUnderlyingGenerator
    }
    private func generate() -> G {
        return _makeUnderlyingGenerator()
    }
}


public final class AnyGenerator__<Element> : GeneratorType, SequenceType {
    private final let _next: () -> Element?
    public init<G : GeneratorType where G.Element == Element>(var _ base: G) {
        _next = { return base.next() }
    }
    public init(_ body: () -> Element?) {
        _next = body
    }
    public func next() -> Element? {
        return _next()
    }
}

public struct AnySequence__<Element> : SequenceType {
    private let _generate: () -> AnyGenerator__<Element>

    public init<S : SequenceType where S.Generator.Element == Element>(_ base: S) {
        _generate = { return AnyGenerator__(base.generate()) }
    }

    public init<G : GeneratorType where G.Element == Element>(_ makeUnderlyingGenerator: () -> G) {
        _generate = { AnyGenerator__(makeUnderlyingGenerator()) }
    }

    public func generate() -> AnyGenerator__<Element> {
        return _generate()
    }
}
