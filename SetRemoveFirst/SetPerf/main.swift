//
//  main.swift
//  SetPerf
//
//  Created by Janosch Hildebrand on 25/03/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

import Cocoa

let size = 100000

func createSet() -> Set<Int> {
    var set = Set<Int>()
    for i in 0..<size {
        set.insert(i)
    }
    return set
}

let insertStart = NSDate()
var set = createSet()
print("Insert: \(NSDate().timeIntervalSinceDate(insertStart))")


let removeFirstStart = NSDate()
while !set.isEmpty {
    set.removeFirst()
}
print("RemoveFirst: \(NSDate().timeIntervalSinceDate(removeFirstStart))")


set = createSet()
let firstRemoveStart = NSDate()
while !set.isEmpty {
    let first = set.first!
    set.remove(first)
}
print("FirstRemove: \(NSDate().timeIntervalSinceDate(firstRemoveStart))")


set = createSet()
let removeLoopStart = NSDate()
for element in set {
    set.remove(element)
}
print("RemoveLoop: \(NSDate().timeIntervalSinceDate(removeLoopStart))")


set = createSet()
let removeDirectStart = NSDate()
for i in 0..<size {
    set.remove(i)
}
print("RemoveDirect: \(NSDate().timeIntervalSinceDate(removeDirectStart))")



