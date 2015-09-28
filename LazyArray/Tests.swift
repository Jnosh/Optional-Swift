//
//  Tests.swift
//  SwiftPerf
//
//  Created by Janosch Hildebrand on 01/09/15.
//
//

import Chronos

func baseline(array: Array<Int>) {
    for x in array { consumeValue(x) }
}

func reverseIterate(array: Array<Int>) {
    for x in array.reverse() { consumeValue(x) }
}

func arrayReverseIterate(array: Array<Int>) {
    for x in Array(array.reverse()) { consumeValue(x) }
}

func lazyReverseIterate(array: Array<Int>) {
    for x in array.lazy.reverse() { consumeValue(x) }
}
