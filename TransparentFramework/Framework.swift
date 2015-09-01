//
//  IntegerType+Extensions.swift
//  JHstdlib
//
//  Created by Janosch Hildebrand on 28/08/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//


public func roundUpDivision<T: IntegerType>(dividend: T, divisor: T) -> T {
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

@transparent public func roundUpDivisionTransparent<T: IntegerType>(dividend: T, divisor: T) -> T {
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
    public var odd: Bool {
        return (self & 1) == 1
    }
    
    @transparent public var oddTransparent: Bool {
        return (self & 1) == 1
    }
}

extension Int {
    public func rotate(factor: Int) -> Int {
        let bits = sizeof(Int) * 8
        precondition(factor < bits)
        
        return (self << factor) | (self >> (-factor & (bits - 1)))
    }
    
    @transparent public func rotateTransparent(factor: Int) -> Int {
        let bits = sizeof(Int) * 8
        precondition(factor < bits)
        
        return (self << factor) | (self >> (-factor & (bits - 1)))
    }
}




