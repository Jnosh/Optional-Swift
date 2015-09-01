//
//  Tests.swift
//  CopyArrayData
//
//  Created by Janosch Hildebrand on 22/04/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

import Foundation

func testBaseline(n: Int, iterations: Int) -> Duration {
    let source = UnsafeMutablePointer<Int>.alloc(n)
    source.initializeFrom(Repeat(count: n, repeatedValue: 0))
    let target = UnsafeMutablePointer<Int>.alloc(n)
    target.initializeFrom(Repeat(count: n, repeatedValue: 0))
    

    let duration = Stopwatch.meanTime(iterations: iterations) {
        target.assignFrom(source, count: n)
    }

    source.destroy(n)
    source.dealloc(n)
    target.destroy(n)
    target.dealloc(n)
    
    return duration
}


func memcopy(inout target: Array<Int>, source: Array<Int>) {
    target.withUnsafeMutableBufferPointer {
        (inout targetBuffer: UnsafeMutableBufferPointer<Int>) -> Void in
        source.withUnsafeBufferPointer {
            (sourceBuffer: UnsafeBufferPointer<Int>) -> Void in
            let targetAddr = UnsafeMutablePointer<Void>(targetBuffer.baseAddress)
            let sourceAddr = UnsafePointer<Void>(sourceBuffer.baseAddress)

            memcpy(targetAddr, sourceAddr, strideof(Int) * source.count)
        }
    }
}

func assignFrom(inout target: Array<Int>, source: Array<Int>) {
    target.withUnsafeMutableBufferPointer {
        (inout targetBuffer: UnsafeMutableBufferPointer<Int>) -> Void in
        source.withUnsafeBufferPointer {
            (sourceBuffer: UnsafeBufferPointer<Int>) -> Void in
            let targetAddr = targetBuffer.baseAddress
            let sourceAddr = UnsafeMutablePointer<Int>(sourceBuffer.baseAddress)
            targetAddr.assignFrom(sourceAddr, count: sourceBuffer.count)
        }
    }
}

func arrayAppend(inout target: Array<Int>, source: Array<Int>) {
    target.removeAll(keepCapacity: true)
    for i in source {
        target.append(i)
    }
}

func arrayExtend(inout target: Array<Int>, source: Array<Int>) {
    target.removeAll(keepCapacity: true)
    target.appendContentsOf(source)
}

func arrayReplace(inout target: Array<Int>, source: Array<Int>) {
    target.replaceRange(target.indices, with: source)
}

func sliceAppend(inout target: Array<Int>, source: Array<Int>) {
    func test(inout target: Array<Int>, source: ArraySlice<Int>) {
        for i in source {
            target.append(i)
        }
    }

    target.removeAll(keepCapacity: true)
    test(&target, source: source[source.indices])
}

func sliceExtend(inout target: Array<Int>, source: Array<Int>) {
    func test(inout target: Array<Int>, source: ArraySlice<Int>) {
        target.appendContentsOf(source)
    }

    target.removeAll(keepCapacity: true)
    test(&target, source: source[source.indices])
}

func sliceReplace(inout target: Array<Int>, source: Array<Int>) {
    func test(inout target: Array<Int>, source: ArraySlice<Int>) {
        target.replaceRange(target.indices, with: source)
    }

    test(&target, source: source[source.indices])
}



func arrayTypeAppend<S: _ArrayType where S.Generator.Element == Int>(inout target: Array<Int>, source: S) {
    target.removeAll(keepCapacity: true)
    for i in source {
        target.append(i)
    }
}

func arrayTypeExtend<S: _ArrayType where S.Generator.Element == Int>(inout target: Array<Int>, source: S) {
    target.removeAll(keepCapacity: true)
    target.appendContentsOf(source)
}

func arrayTypeReplace<S: _ArrayType where S.Generator.Element == Int>(inout target: Array<Int>, source: S) {
    target.replaceRange(target.indices, with: source)
}

func arrayTypeReplaceArray<S: _ArrayType where S.Generator.Element == Int>(inout target: Array<Int>, source: S) {
    target.replaceRange(target.indices, with: Array(source))
}

func arrayTypeReplaceNativeBuffer<S: _ArrayType where S.Generator.Element == Int>(inout target: Array<Int>, source: S) {
    target.replaceRange(target.indices, with: source)
}

func arrayTypeReplaceBuffer<S: _ArrayType where S._Buffer.Generator.Element == Int>(inout target: Array<Int>, source: S) {
    target.replaceRange(target.indices, with: source._buffer)
}

func arrayTypeReplaceBufferPtr<S: _ArrayType where S._Buffer.Element == Int>(inout target: Array<Int>, source: S) {
    source._buffer.withUnsafeBufferPointer { buffer -> Void in
        target.replaceRange(target.indices, with: buffer)
    }
}

func arrayTypeReplaceBaseAddress<S: _ArrayType where S.Element == Int>(inout target: Array<Int>, source: S) {
    target.replaceRange(target.indices, with: UnsafeBufferPointer(start: source._baseAddressIfContiguous, count: source.count))
}


func collectionAppend<C: CollectionType where C.Generator.Element == Int>(inout target: Array<Int>, source: C) {
    target.removeAll(keepCapacity: true)
    for element in source {
        target.append(element)
    }
}

func collectionExtend<C: CollectionType where C.Generator.Element == Int>(inout target: Array<Int>, source: C) {
    target.removeAll(keepCapacity: true)
    target.appendContentsOf(source)
}

func collectionReplace<C: CollectionType where C.Generator.Element == Int>(inout target: Array<Int>, source: C) {
    target.replaceRange(target.indices, with: source)
}

func collectionReplaceArray<C: CollectionType where C.Generator.Element == Int>(inout target: Array<Int>, source: C) {
    target.replaceRange(target.indices, with: Array(source))
}



func sequenceAppend<S: SequenceType where S.Generator.Element == Int>(inout target: Array<Int>, source: S) {
    target.removeAll(keepCapacity: true)
    for element in source {
        target.append(element)
    }
}

func sequenceExtend<S: SequenceType where S.Generator.Element == Int>(inout target: Array<Int>, source: S) {
    target.removeAll(keepCapacity: true)
    target.appendContentsOf(source)
}

func sequenceReplaceArray<S: SequenceType where S.Generator.Element == Int>(inout target: Array<Int>, source: S) {
    target.replaceRange(target.indices, with: Array(source))
}


func anySequenceAppend(inout target: Array<Int>, source: Array<Int>) {
    func test(inout target: Array<Int>, source: AnySequence<Int>) {
        for element in source {
            target.append(element)
        }
    }

    target.removeAll(keepCapacity: true)
    test(&target, source: AnySequence(source))
}

func anySequenceExtend(inout target: Array<Int>, source: Array<Int>) {
    func test(inout target: Array<Int>, source: AnySequence<Int>) {
        target.appendContentsOf(source)
    }

    target.removeAll(keepCapacity: true)
    test(&target, source: AnySequence(source))
}

func anySequenceReplaceArray(inout target: Array<Int>, source: Array<Int>) {
    func test(inout target: Array<Int>, source: AnySequence<Int>) {
        target.replaceRange(target.indices, with: Array(source))
    }
    test(&target, source: AnySequence(source))
}


func anyGeneratorAppend(inout target: Array<Int>, source: Array<Int>) {
    func test(inout target: Array<Int>, source: AnyGenerator<Int>) {
        for element in source {
            target.append(element)
        }
    }
    
    target.removeAll(keepCapacity: true)
    test(&target, source: anyGenerator(source.generate()))
}

func anyGeneratorExtend(inout target: Array<Int>, source: Array<Int>) {
    func test(inout target: Array<Int>, source: AnyGenerator<Int>) {
        target.appendContentsOf(source)
    }
    
    target.removeAll(keepCapacity: true)
    test(&target, source: anyGenerator(source.generate()))
}

func anyGeneratorReplaceArray(inout target: Array<Int>, source: Array<Int>) {
    func test(inout target: Array<Int>, source: AnyGenerator<Int>) {
        target.replaceRange(target.indices, with: Array(source))
    }
    test(&target, source: anyGenerator(source.generate()))
}


