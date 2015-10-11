//
//  main.swift
//  NSDataFromArray
//
//  Created by Janosch Hildebrand on 28/09/15.
//
//

import Foundation

// Key for associated object
private var arrayBoxKey = 0

extension NSData {
    private class ArrayBox {
        let value: [UInt8]
        
        private init(_ value: [UInt8]) {
            self.value = value
        }
    }
    
    var unsafeBufferPointer: UnsafeBufferPointer<UInt8> {
        return UnsafeBufferPointer(start: UnsafePointer<UInt8>(self.bytes), count: self.length)
    }
    
    convenience init(bytes: [UInt8]) {
        // Get an UnsafePointer to the array contents to avoid copying the array contents
        let ptr = bytes.withUnsafeBufferPointer { return $0.baseAddress }
        
        // Cast the UnsafePointer into an UnsafeMutablePointer needed for NSData
        let mutablePtr = unsafeBitCast(ptr, UnsafeMutablePointer<UInt8>.self)
        
        self.init(bytesNoCopy: mutablePtr, length: bytes.count, freeWhenDone: false)
        
        // Store the Swift array in an associated object
        // Exsentially a retain on the array so it isn't deallocated while we still hold a pointer
        // to it & CoW works on the Swift side (not if you modify via NSMutableData).
        objc_setAssociatedObject(self, &arrayBoxKey, ArrayBox(bytes), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}


// MARK: Helper functions to measure memory usage

func getMemoryUsage() -> (current: Int, max: Int)? {
    let MACH_TASK_BASIC_INFO_COUNT = sizeof(mach_task_basic_info_data_t) / sizeof(natural_t)
    
    var info = mach_task_basic_info_t.alloc(1)
    var infoSize = mach_msg_type_number_t(MACH_TASK_BASIC_INFO_COUNT)
    defer {
        info.dealloc(1)
        info.destroy(1)
    }
    
    let result = task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), task_info_t(info), &infoSize)
    guard (result == KERN_SUCCESS) else { return nil }
    
    return (current: Int(info.memory.resident_size), max: Int(info.memory.resident_size_max))
}

func printMemoryUsage() {
    let usage = getMemoryUsage()
    if let usage = usage {
        print("Current: \(usage.current)")
        print("Max: \(usage.max)")
    } else {
        print("Failed to retrieve memory usage.")
    }
}

// MARK: Test
func createData() -> NSData {
    var bytes = [UInt8](count: 1_000_000_000, repeatedValue: 0x2A)
    
    printMemoryUsage()
    
    let data = NSData(bytes: bytes)
    
    printMemoryUsage()
    
    bytes[0] = 0
    
    printMemoryUsage()
    
    print("Array: \(bytes[0])")
    print("NSData: \(data.unsafeBufferPointer[0])")
    
    return data
}

func runTest() {
    autoreleasepool {
        let data = createData()
        
        printMemoryUsage()
        
        // Just checking that data is still live
        print("NSData: \(data.unsafeBufferPointer[0])")
    }
}


// Run test
printMemoryUsage()
runTest()
printMemoryUsage()

