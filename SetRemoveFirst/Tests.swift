//
//  Tests.swift
//  SwiftPerf
//
//  Created by Janosch Hildebrand on 01/09/15.
//
//

func createSet(count: Int) -> Set<Int> {
    var set = Set<Int>(minimumCapacity: count)
    for i in 0..<count {
        set.insert(i)
    }
    return set
}

func createTest(set: Set<Int>) {
    createSet(set.count)
}

func removeLoop(set: Set<Int>) {
    var set = set
    for element in set {
        set.remove(element)
    }
}

func removeDirect(set: Set<Int>) {
    var set = set
    for i in 0..<set.count {
        set.remove(i)
    }
}

func removeFirst(set: Set<Int>) {
    var set = set
    while !set.isEmpty {
        set.removeFirst()
    }
}

func firstRemove(set: Set<Int>) {
    var set = set
    while !set.isEmpty {
        let first = set.first!
        set.remove(first)
    }
}

