import UIKit

var greeting = "Hello, playground"

//Normal Function
func sum(x : Int, y : Int) -> Int {
    return (x + y)
}

let result = sum(x: 20, y: 10)
print("result is ", result)

//Closure
let add = { (a : Int, b : Int)  -> Int in
    
    return(a+b)
}

print(add(12,12)) //to check result


let age = { (age : Int, Name : String) -> Bool in
    return age > 18
}

print(age(12,"User"))


func fetchUser(completion: () -> Void) {
    //  fetch logic...
    
    completion() // Execute callback when done
}

fetchUser {
    print("User data fetched")
}

func fetchUserName(name : String , completion : (String)->String ){
    completion(name)
}

func createMultiplier(_ multiplier: Int) -> (Int) -> Int {
    return { number in
        number * multiplier
    }
}

let double = createMultiplier(5)

print("Double: \(double(7))")


func captureList() {

    var count = 0

    let increment = { [count] in
        print("Captured count: \(count)")
    }

    count = 10

    increment()
}


func captureExample() {

    var count = 0

    let increment = {
        print("Captured count: \(count)")
    }

    count = 10

    increment()
}

captureList()
captureExample()


func higherOrderFunctionsExampple() {
    let numbers = [1, 2, 3, 4, 5]
    
    let doubled = numbers.map { $0 * 2 }
    print("Doubled: \(doubled)")
    
    let evenNumbers = numbers.filter { $0 % 2 == 0 }
    print("Even numbers: \(evenNumbers)")
    
    let sum = numbers.reduce(0) { result, number in
        result + number
    }
    
    print("Sum: \(sum)")
}

higherOrderFunctionsExampple()

func checkCondition(_ condition: @autoclosure () -> Bool) {
    if condition() {
        print("Condition is true")
    }
    
}

checkCondition(12<5)

func validateCondition(_ condition: () -> Bool) {
    if condition() {
        print("Condition is true")
    }
    
}
validateCondition {
    10>6
}


func createPair<T, U>(_ first: T, _ second: U) -> (T, U) {
    return (first, second)
}

createPair("Nav", 25)


func areEqual<T: Equatable>(_ first: T, _ second: T) -> Bool {
    return first == second
}
areEqual(10, 10)
areEqual("Nav", "Neet")


func findMaximum<T: Comparable>(_ first: T, _ second: T) -> T {
    return first > second ? first : second
}
findMaximum(10, 20)
findMaximum("Nav", "Neet.")

