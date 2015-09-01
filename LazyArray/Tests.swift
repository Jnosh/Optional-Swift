//
//  Tests.swift
//  SwiftPerf
//
//  Created by Janosch Hildebrand on 01/09/15.
//
//


func baseline(array: Array<Int>) {
    for _ in array { }
}

func reverseIterate(array: Array<Int>) {
    for _ in array.reverse() { }
}

func arrayReverseIterate(array: Array<Int>) {
    for _ in Array(array.reverse()) { }
}

func lazyReverseIterate(array: Array<Int>) {
    for _ in array.lazy.reverse() { }
}
