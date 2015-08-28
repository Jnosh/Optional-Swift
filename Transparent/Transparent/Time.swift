//
//  Time.swift
//  JHKit
//
//  Created by Janosch Hildebrand on 14/02/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

import Foundation

/// Represents a time interval in seconds. Equivalent to NSTimeInterval
public typealias TimeInterval = Double

/// Represents a time interval with nanosecond precision.
public struct Duration {
    public let nanoseconds: UInt64

    private init(nanoseconds: UInt64) {
        self.nanoseconds = nanoseconds
    }

    public var microseconds: Double {
        return Double(nanoseconds) / 1_000
    }

    public var milliseconds: Double {
        return Double(nanoseconds) / 1_000_000
    }

    public var seconds: Double {
        return Double(nanoseconds) / 1_000_000_000
    }
}


/// A simple stopwatch that counts the elapsed time since its creation
public struct Stopwatch {
    private let start: UInt64

    private static let timebase: mach_timebase_info_data_t = {
        var timebase = mach_timebase_info_data_t()
        mach_timebase_info(&timebase)
        return timebase
    }()

    /// Create a new stopwatch that counts the time elapsed since it was created
    public init() {
        start = mach_absolute_time()
    }

    /// The number of nanoseconds that elapsed since this stopwatch was created
    public func elapsed() -> Duration {
        let current = mach_absolute_time()
        let elapsed = current - start

        let timebase = Stopwatch.timebase
        let elapsedNano = (elapsed * numericCast(timebase.numer)) / numericCast(timebase.denom)

        return Duration(nanoseconds: elapsedNano)
    }
}

public func measureTime(@noescape block: () -> ()) -> Duration {
    return measureTime(1, block: block)
}

public func measureTime(iterations: Int, @noescape block: () -> ()) -> Duration {
    return measureGrossTime(iterations, block: block) / UInt64(iterations)
}

public func measureGrossTime(iterations: Int, @noescape block: () -> ()) -> Duration {
    precondition(iterations >= 0)

    let stopwatch = Stopwatch()
    for _ in 0..<iterations { block() }
    return stopwatch.elapsed()
}

public func measureNetTime(iterations: Int, samples: Int, @noescape block: () -> ()) -> Double {

    // TODO: could request real-time scheduling for thread


    // Step 0:  Load cache with a single iteration of the routine.
    measureTime(1, block: block)

    // Step 1:  Record the minimum time in <samples> samples to execute two iterations.
    let m0 = (0..<samples).reduce(UInt64.max) {
        let time = measureGrossTime(2, block: block)
        return min($0.0, time.nanoseconds)
    }


    // Step 2:  Record the minimum time in <samples> samples to execute 2+<iterations> iterations.
    let m1 = (0..<samples).reduce(UInt64.max) {
        let time = measureGrossTime(2 + iterations, block: block)
        return min($0.0, time.nanoseconds)
    }

    // Step 3:  Calculate the time to execute <iterations> iterations as the
    // difference between the time to execute 2 iterations and the time to
    // execute 2+<iterations> iterations.
    let time = m1 - m0

    return Double(time) / Double(iterations)
}


extension Duration: Equatable { }
public func ==(lhs: Duration, rhs: Duration) -> Bool {
    return lhs.nanoseconds == rhs.nanoseconds
}

extension Duration: Comparable { }
public func <(lhs: Duration, rhs: Duration) -> Bool {
    return lhs.nanoseconds < rhs.nanoseconds
}

extension Duration: Hashable {
    public var hashValue: Int {
        return nanoseconds.hashValue
    }
}

public func +(lhs: Duration, rhs: Duration) -> Duration {
    return Duration(nanoseconds: lhs.nanoseconds + rhs.nanoseconds)
}

public func -(lhs: Duration, rhs: Duration) -> Duration {
    return Duration(nanoseconds: lhs.nanoseconds - rhs.nanoseconds)
}

public func *(lhs: Duration, rhs: UInt64) -> Duration {
    return Duration(nanoseconds: lhs.nanoseconds * rhs)
}

public func *(lhs: UInt64, rhs: Duration) -> Duration {
    return rhs * lhs
}

public func /(lhs: Duration, rhs: UInt64) -> Duration {
    return Duration(nanoseconds: lhs.nanoseconds / rhs)
}



