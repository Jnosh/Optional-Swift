//
//  Local.swift
//  Transparent
//
//  Created by Janosch Hildebrand on 28/08/15.
//  Copyright © 2015 Janosch Hildebrand. All rights reserved.
//


extension Int {
    /// Returns `self` after left rotation by `factor`.
    public func rotateLocal(factor: Int) -> Int {
        let bits = sizeof(Int) * 8
        precondition(factor < bits)
        
        return (self << factor) | (self >> (-factor & (bits - 1)))
    }
}


public func roundUpDivisionLocal<T: IntegerType>(dividend: T, divisor: T) -> T {
    var quotient = dividend / divisor
    let rest = dividend % divisor
    
    if rest != 0 {
        switch quotient {
        case let q where q > 0:
            quotient++
        case let q where q < 0:
            quotient--
        default: // 0
            if (dividend > 0 && divisor > 0) || (dividend < 0 && divisor < 0) {
                quotient++
            } else {
                quotient--
            }
        }
    }
    
    return quotient
}

extension IntegerType {
    public var oddLocal: Bool {
        return (self & 1) == 1
    }
}

