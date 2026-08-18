//
//  ClosuresExample.swift
//  Day02
//
//  Created by Navneet on 18/08/26.
//

//Closures are self-contained blocks of functionality that can be passed around and used in your code.
//{ (parameters) -> ReturnType in
// body
//}

import Foundation

class ClosuresExample {
    
    // MARK: - 1. Basic Closure
    
    func basicClosure() {
        let greeting = {
            print("Hello")
        }
        
        greeting()
    }
    
    
    // MARK: - 2. Closure with Parameters
    
    func closureWithParameters() {
        let greetUser = { (name: String) in //param - string type
            print("Hello, \(name)")
        }
        
        greetUser("Nav")
    }
    
    
    // MARK: - 3. Closure with Return Value
    
    func closureWithReturnValue() {
        let addNumbers = { (a: Int, b: Int) -> Int in // Input - int , output int
            return a + b
        }
        
        let result = addNumbers(10, 20)
        print("Sum: \(result)")
    }
    
    
    // MARK: - 4. Closure Type
    //{ parameters in
    //code
    //}
    //stroring a closure in a variable
    func closureType() {
        let multiply: (Int, Int) -> Int = { a, b in // in ->  separates the parameters and return type declaration from the body
            return a * b
        }
        
        print("Multiplication: \(multiply(5, 4))")
    }
    
    
    // MARK: - 5. Passing Closure as Parameter
    
    func performOperation( a: Int, b: Int, operation: (Int, Int) -> Int ) {
        let result = operation(a, b)
        print("Result: \(result)")
    } //Trailing as closure is the last parameter
    
    
    // MARK: - 6. Trailing Closure
    
    func trailingClosureExample() {
        performOperation(a: 10, b: 5) { a, b in
            return a - b
        }
    }
    
    
    // MARK: - 7. Shorthand Arguments
    
    func shorthandArguments() {
        let add: (Int, Int) -> Int = {
            $0 + $1 //shorthand arguments can be used in simple or non complex closures ... for any additional values we can use $2, $3 etc like we do in higher order functions
        }
        
        print("Result: \(add(10, 20))")
    }
    
    
    // MARK: - 8. Closure Returning Closure
    
    func closureReturningClosure() {
        func createMultiplier(_ multiplier: Int) -> (Int) -> Int {
            return { number in
                number * multiplier
            }
        }
        
        let double = createMultiplier(2) //double is a clousure because createMultiplier returns a value
        
        print("Double: \(double(10))")
    }
    
    
    // MARK: - 9. Escaping Closure
    
    func escapingClosure(
        completion: @escaping (String) -> Void
    ) {
        DispatchQueue.main.async {
            completion("Data fetched successfully")
        }
    }//@escaping says - This closure may be stored or executed after this function has returned.
    
    //non escaping
    //    function starts
    //         ↓
    //    closure executes
    //         ↓
    //    function finishes
    
    //escaping
    //    function starts
    //         ↓
    //    closure is scheduled
    //         ↓
    //    function finishes
    //         ↓
    //    closure executes
    
    
    // MARK: - 10. Capture List
    
    func captureListExample() {
        var count = 0
        
        let increment = { [count] in //capture [count] output will be 0 as captured here initial value
            print("Captured count: \(count)")
        }
        
        count = 10
        
        increment()
    }
    
    
    // MARK: - 11. Array Higher-Order Functions
    // functions that can accept other functions or closures as parameters, or return functions example - map, filter, and reduce.
    func higherOrderFunctions() {
        let numbers = [1, 2, 3, 4, 5]
        
        let doubled = numbers.map { $0 * 2 } //take element -$0 and multiply by 2
        print("Doubled: \(doubled)")
        
        let evenNumbers = numbers.filter { $0 % 2 == 0 } //filter if element $0 is divisible by 2
        print("Even numbers: \(evenNumbers)")
        
        let sum = numbers.reduce(0) { result, number in
            result + number
        } //combine all
        
        print("Sum: \(sum)")
    }
    
    //MARK: - @autoclosure
    // automatically wraps an expression inside a closure.
    func checkCondition(_ condition: @autoclosure () -> Bool) {
        if condition() {
            print("Condition is true")
        }
    }
    
//    with autoClosure - check(10>5)
//    without - check { 10 > 5 }
    //@autoclosure automatically wraps an expression in a closure and delays its evaluation until the closure is executed. It allows us to pass an expression directly instead of explicitly writing a closure.
    
}


