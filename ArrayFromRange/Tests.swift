//
//  Tests.swift
//  SwiftPerf
//
//  Created by Janosch Hildebrand on 31/08/15.
//
//

func ptrTest(n: Int) {
    let base = UnsafeMutablePointer<Int>.alloc(n)
    for i in 0..<n {
        base[i] = i
    }
    base.destroy(n)
    base.dealloc(n)
}

func appendTest(n: Int) {
    var array = Array<Int>()
    array.reserveCapacity(n)
    for i in 0..<n {
        array.append(i)
    }
}

func mapTest(n: Int) {
    let range = 0..<n
    let _ = range.map { $0 }
}

func rangeTest(n: Int) {
    let _ = Array(0..<n)
}
