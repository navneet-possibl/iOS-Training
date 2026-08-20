//
//  Assignment.swift
//  Day02
//
//  Created by Navneet on 18/08/26.
//

//Practice Swift Closures, Higher-Order Functions, @escaping, Capture Lists, @autoclosure, and Generics by implementing practical examples and solving closure/generic programming exercises. Focus on understanding how closures are passed, returned, captured, and used with generic types and constraints.

import Foundation

class Assignment {
    
    // Basic Closure
    let addNumbers = { (a: Int, b: Int) -> Int in
        return a + b
    }
    
    
    // Closure Passed as Parameter
    func calculate( a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
        return operation(a, b)
    }
    
    
    // Higher-Order Functions
    func higherOrderExample() {
        let numbers = [1, 2, 3, 4, 5]
        
        let doubled = numbers.map {
            $0 * 20
        }
        
        let evenNumbers = numbers.filter {
            $0 % 2 == 0
        }
        
        print("Doubled: \(doubled)")
        print("Even Numbers: \(evenNumbers)")
    }
    
    
    // @escaping
    func fetchData(completion: @escaping (String) -> Void) {
        completion("Data fetched")
    }
    
    
    // Capture List
    func captureListExample() {
        var count = 20
        
        let showCount = { [count] in
            print("Captured Count: \(count)")
        }
        
        count = 10
        
        showCount()
    }
    
    
    //  @autoclosure
    func validate( _ condition: @autoclosure () -> Bool) {
        print(condition())
    }
    
    
    // Closure Returning Closure
    func createMultiplier(_ number: Int) -> (Int) -> Int {
        return { value in
            value * number
        }
    }
    
    
    // Generic Function
    func printValue<T>(_ value: T) {
        print("Value: \(value)")
    }
    
    
    // Generic Constraint
    func areEqual<T: Equatable>( _ first: T, _ second: T) -> Bool {
        return first == second
    }
}
