//
//  DiscreteGeometry.swift
//  JHKit
//
//  Created by Janosch Hildebrand on 12/02/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

// MARK: DiscretePoint

public struct DiscretePoint {
    public var x: Int
    public var y: Int

    public static let zeroPoint = DiscretePoint(x: 0, y: 0)

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    public init(_ x: Int, _ y: Int) {
        self.init(x: x, y: y)
    }
}

extension DiscretePoint : CustomDebugStringConvertible {
    public var debugDescription : String {
        return "[\(x); \(y)]"
    }
}


// MARK: DiscreteSize

public struct DiscreteSize {
    public var width: Int
    public var height: Int

    public static let zeroSize = DiscreteSize(width: 0, height: 0)

    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }

    public init(_ width: Int, _ height: Int) {
        self.init(width: width, height: height)
    }
}

extension DiscreteSize : CustomDebugStringConvertible {
    public var debugDescription : String {
        return "[\(width) by \(height)]"
    }
}




extension DiscreteSize: SequenceType {
    public func generate() -> DiscreteRectPointGenerator {
        return DiscreteRectPointGenerator(size: self)
    }
}

public struct DiscreteRectPointGenerator: GeneratorType {
    private let maxX: Int
    private let minX: Int
    private let maxY: Int
    
    private var currentX: Int
    private var currentY: Int
    
    init(size: DiscreteSize) {
        maxX = size.width
        minX = 0
        maxY = size.height
        currentX = 0
        currentY = 0
    }
    
    public mutating func next() -> DiscretePoint? {
        if currentX >= maxX {
            currentX = minX
            currentY++
        }
        
        if currentY >= maxY {
            return nil
        }
        
        let position = DiscretePoint(x: currentX, y: currentY)
        currentX++
        
        return position
    }
}

