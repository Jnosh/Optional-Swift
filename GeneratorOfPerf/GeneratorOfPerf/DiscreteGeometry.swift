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

extension DiscretePoint : Equatable {}
public func ==(lhs: DiscretePoint, rhs: DiscretePoint) -> Bool {
    return (lhs.x == rhs.x) && (lhs.y == rhs.y)
}


extension DiscretePoint : Hashable {
    public var hashValue: Int {
        let prime = 31

        var result = 1
        result = prime &* result &+ x.hashValue
        result = prime &* result &+ y.hashValue

        return result
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

extension DiscreteSize : Equatable {}
public func ==(lhs: DiscreteSize, rhs: DiscreteSize) -> Bool {
    return (lhs.width == rhs.width) && (lhs.height == rhs.height)
}

extension DiscreteSize : Hashable {
    public var hashValue: Int {
        let prime = 31

        var result = 1
        result = prime &* result &+ width.hashValue
        result = prime &* result &+ height.hashValue

        return result
    }
}

extension DiscreteSize : CustomDebugStringConvertible {
    public var debugDescription : String {
        return "[\(width) by \(height)]"
    }
}


// MARK: DiscreteRect

public struct DiscreteRect {
    public var origin: DiscretePoint
    public var size: DiscreteSize

    public init(origin: DiscretePoint, size: DiscreteSize) {
        self.origin = origin
        self.size = size
    }

    public init(x: Int, y: Int, width: Int, height: Int) {
        let origin = DiscretePoint(x: x, y: y)
        let size = DiscreteSize(width: width, height: height)
        self.init(origin: origin, size: size)
    }
}

extension DiscreteRect {
    public static let zeroRect = DiscreteRect(origin: .zeroPoint, size: .zeroSize)

    public var width: Int { return size.width }

    public var height: Int { return size.height }

    public var isEmpty: Bool { return self == DiscreteRect.zeroRect }

    public var minX: Int { return width >= 0 ? origin.x : origin.x + width }
    // public var midX: Int { return origin.x + (width / 2) }
    public var maxX: Int { return width >= 0 ? origin.x + width : origin.x }

    public var minY: Int { return height >= 0 ? origin.y : origin.y + height }
    // public var midY: Int { return origin.y + (width / 2) }
    public var maxY: Int { return height >= 0 ? origin.y + height : origin.y }

    public func contains(point: DiscretePoint) -> Bool {
        return point.x >= minX && point.y >= minY && point.x < maxX && point.y < maxY
    }

    public func contains(rect: DiscreteRect) -> Bool {
        return rect.minX >= minX && rect.minY >= minY && rect.maxX <= maxX && rect.maxY <= maxY
    }
}

extension DiscreteRect : Equatable {}
public func ==(lhs: DiscreteRect, rhs: DiscreteRect) -> Bool {
    return (lhs.origin == rhs.origin) && (lhs.size == rhs.size)
}

extension DiscreteRect : Hashable {
    public var hashValue: Int {
        let prime = 31

        var result = 1
        result = prime &* result &+ origin.hashValue
        result = prime &* result &+ size.hashValue

        return result
    }
}

extension DiscreteRect : CustomDebugStringConvertible {
    public var debugDescription : String {
        return "Origin: \(origin) – Size: \(size)"
    }
}
