//
//  Generators.swift
//  GeneratorOfPerf
//
//  Created by Janosch Hildebrand on 25/03/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//


extension DiscreteRect: SequenceType {
    public func generate() -> DiscreteRectPointGenerator {
        return DiscreteRectPointGenerator(rect: self)
    }
}

extension DiscreteSize: SequenceType {
    public func generate() -> DiscreteRectPointGenerator {
        return DiscreteRectPointGenerator(size: self)
    }
}

public struct DiscreteRectPointGenerator: GeneratorType {
    private let rect: DiscreteRect

    private var currentX: Int
    private var currentY: Int

    init(rect: DiscreteRect) {
        self.rect = rect
        currentX = rect.minX
        currentY = rect.minY
    }

    init(size: DiscreteSize) {
        let rect = DiscreteRect(origin: .zeroPoint, size: size)
        self.init(rect: rect)
    }

    public mutating func next() -> DiscretePoint? {
        if currentX >= rect.maxX {
            currentX = rect.minX
            currentY++
        }

        if currentY >= rect.maxY {
            return nil
        }

        let position = DiscretePoint(x: currentX, y: currentY)
        currentX++

        return position
    }
}
