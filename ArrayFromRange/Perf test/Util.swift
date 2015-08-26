//
//  Util.swift
//  LazyArrayPerf
//
//  Created by Janosch Hildebrand on 22/04/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//


func paddedNames(names: [String]) -> [String] {
    let lengths = names.map { return $0.characters.count }
    let maxLength = lengths.maxElement()!

    return zip(names, lengths).map { (name: String, length: Int) -> String in
        let padding = Repeat<Character>(count: maxLength - length, repeatedValue: " ")
        return name + String(padding)
    }
}
