
//
//  GenericsExample.swift
//  Day02
//
//  Created by Navneet on 18/08/26.
//

// Generics allow us to write reusable and type-safe code that can work with different data types.
//
// Instead of writing separate functions for Int, String, Double, etc.,
// we can write one generic function using a placeholder type such as T.
//


import Foundation

class GenericsExample {
    
    // MARK: - 1. Basic Generic Function
    
    func printValue<T>(_ value: T) {
        print("Value: \(value)")
    }
    
    // T is  placeholder
    // determines the actual type when the function is called.
    //
    // printValue(10)       -> T = Int
    // printValue("nav")  -> T = String
    // printValue(10.5)     -> T = Double
    
    
    // MARK: - 2. Generic Function with Return Value
    
    func getValue<T>(_ value: T) -> T {
        return value
    }
    
    // type T is used for both input and output.
    //
    // getValue(10)       -> returns Int
    // getValue("Nav")    -> returns String
    
    
    // MARK: - 3. Generic Function with Two Parameters
    
    func createPair<T, U>(_ first: T, _ second: U) -> (T, U) {
        return (first, second)
    }
    
    // T and U can represent different types.
    //
    // createPair("Nav", 25)
    // T = String
    // U = Int
    //
    // Result:
    // ("Nav", 25)
    
    
    // MARK: - 4. Generic Array
    
    func getFirstElement<T>(_ array: [T]) -> T? {
        return array.first
    }
    
    // T represents the type of elements inside the array.
    //
    // [1, 2, 3]       -> T = Int
    // ["A", "B"]      -> T = String
    
    
    // MARK: - 5. Generic Swap
    
    func swapValues<T>(_ first: inout T, _ second: inout T) {
        let temp = first
        first = second
        second = temp
    }
    
    //
    // Int:
    // var a = 10
    // var b = 20
    // swapValues(&a, &b)
    //
    // String:
    // var first = "nav"
    // var second = "neet"
    // swapValues(&first, &second)
    
    
    // MARK: - 6. Generic Type
    
    struct Box<T> {
        var value: T
    }
    
    func genericTypeExample() {
        let intBox = Box(value: 100)
        let stringBox = Box(value: "nav")
        
        print("Integer Box: \(intBox.value)")
        print("String Box: \(stringBox.value)")
    }
    
    // Box<T> is a generic structure.
    //
    // Box(value: 100)
    // -> Box<Int>
    //
    // Box(value: "nav")
    // -> Box<String>
    
    
    // MARK: - 7. Generic Constraint - Equatable
    
    func areEqual<T: Equatable>(_ first: T, _ second: T) -> Bool {
        return first == second
    }
    
    // T: Equatable means:
    // T must conform to the Equatable protocol.
    // areEqual(10, 10)
    // -> true
    // areEqual("nav", "neet")
    // -> false
    
    
    // MARK: - 8. Generic Constraint - Comparable
    
    func findMaximum<T: Comparable>(_ first: T, _ second: T) -> T {
        return first > second ? first : second
    }
    
    // T: Comparable means:
    // T must support comparison such as >, <, >= and <=.
    //
    // findMaximum(10, 20)
    // -> 20
    //
    // findMaximum("Apple", "Banana") char count in this case
    // -> Banana
    
    
    // MARK: - 9. Generic Function with Collection
    
    func printAll<T>(_ items: [T]) {
        for item in items {
            print(item)
        }
    }
    
    // This function can work with:
    // [1, 2, 3]
    // ["Nav", "John"]
    // [10.5, 20.5]
    //
    // T represents the type of each element present in array.
    
    
    // MARK: - 10. Generic + Protocol Constraint
    
    func processCodableData<T: Codable>(_ value: T) {
        print("Processing Codable value: \(value)")
    }
    
    // T: Codable means:
    // The type passed to this function must conform to Codable.
    //
    // Generics + protocol constraints are commonly used in networking and JSON parsing.
    
    
    // MARK: - 11. Generic Result Example
    
    func createResult<T>(_ value: T) -> Result<T, Error> {
        return .success(value)
    }
    
    // Result<T, Error> is itself a generic type.
    //
    // T can be:
    // User
    // String
    // Data
    // Int
    // etc.
    
}
