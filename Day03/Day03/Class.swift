//
//  ClassExample.swift
//  Day03
//
//  Created by Navneet on 19/08/26.
//

import Foundation

// Class is a REFERENCE TYPE.
//
// When a class instance is assigned to another variable,both variables can refer to the SAME object.
//
// Classes support:
// - Inheritance
// - Reference semantics
// - ARC
// - Deinitialization
// - Object identity

class classUser {

    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class ClassExample {

    // MARK: - Basic Class

    let user = classUser(name: "Nav", age: 25)

    func basicClass() {

        print("Name: \(user.name)")
        print("Age: \(user.age)")
    }


    // MARK: - Class Initialization

    class Product {

        var name: String
        var price: Double

        init(name: String, price: Double) {
            self.name = name
            self.price = price
        }
    }

    func classInitialization() {

        let product = Product(
            name: "iPhone",
            price: 79999
        )

        print("Product: \(product.name)")
        print("Price: \(product.price)")
    }


    // MARK: - Reference Type Behaviour

    func referenceTypeBehaviour() {

        let user1 = user

        let user2 = user1

        user2.name = "Some"

        print("User 1: \(user1.name)")
        print("User 2: \(user2.name)")
    }

    // Output:
    //
    // User 1: John
    // User 2: John
    //
    // user1 and user2 refer to the same class instance.


    // MARK: - Class with Let

    func classWithLet() {

        let user = classUser(
            name: "Nav",
            age: 25
        )

        user.name = "Some"
        user.age = 30

        print("Name: \(user.name)")
        print("Age: \(user.age)")
    }



    // MARK: -  Class Assignment

    func classAssignment() {

        let user1 = classUser(
            name: "Nav",
            age: 25
        )

        let user2 = user1

        print("Before modification:")
        print("User 1: \(user1.name)")
        print("User 2: \(user2.name)")

        user2.name = "Some"

        print("After modification:")
        print("User 1: \(user1.name)")
        print("User 2: \(user2.name)")
    }

    


    // MARK: - Class Method

    class Counter {

        var value = 0

        func increment() {
            value += 1
        }
    }

    func classMethod() {

        let counter = Counter()

        counter.increment()
        counter.increment()

        print("Counter: \(counter.value)")
    }

    // Unlike a struct, a class method does NOT
    // require the mutating keyword.


    // MARK: -  Passing Class to Function

    func updateUser(_ user: classUser) {

        user.name = "Updated"

        print("Inside function: \(user.name)")
    }

    func classFunctionParameter() {

       
        updateUser(user)

        // Original object is also changed.

        print("Outside function: \(user.name)")
    }

    
   

    // MARK: - Identity Operator

    func identityOperator() {

        let user1 = classUser(
            name: "Nav",
            age: 25
        )

        let user2 = user1

        let user3 = classUser(
            name: "Nav",
            age: 25
        )

        print(user1 === user2)
        print(user1 === user3)
    }

    // Output:
    //
    // true
    // false
    //
    // === checks whether two references point to the exact same class instance.


    // MARK: -  Equality vs Identity

    class Employee: Equatable {

        let id: Int
        let name: String

        init(id: Int, name: String) {
            self.id = id
            self.name = name
        }

        static func == (
            lhs: Employee,
            rhs: Employee
        ) -> Bool {

            return lhs.id == rhs.id
        }
    }

    func equalityVsIdentity() {

        let employee1 = Employee(
            id: 1,
            name: "Nav"
        )

        let employee2 = Employee(
            id: 1,
            name: "Nav"
        )

        print(employee1 == employee2)
        print(employee1 === employee2)
    }

    // Output:
    //
    // true
    // false
    // == checks equality based on the Equatable implementation.
    //
    // === checks whether both references point to the same object.


    // MARK: - Class Inheritance

    class Animal {

        func makeSound() {
            print("Animal sound")
        }
    }

    class Dog: Animal {

        override func makeSound() {
            print("Dog barking")
        }
    }

    func inheritanceExample() {

        let dog = Dog()

        dog.makeSound()
    }

    // Structs do NOT support class inheritance.
    // Classes support inheritance.


    // MARK: - Overriding

    class Vehicle {

        func start() {
            print("Vehicle started")
        }
    }

    class Car: Vehicle {

        override func start() {
            print("Car started")
        }
    }

    func overridingExample() {

        let car = Car()

        car.start()
    }


    // MARK: -  Deinitializer

    class FileManagerExample {

        init() {
            print("Object created")
        }

        deinit {
            print("Object destroyed")
        }
    }

    // MARK: -  Reference Sharing

    class BankAccount {

        var balance: Double

        init(balance: Double) {
            self.balance = balance
        }
    }

    func referenceSharing() {

        let account1 = BankAccount(
            balance: 1000
        )

        let account2 = account1

        account2.balance = 500

        print("Account 1: \(account1.balance)")
        print("Account 2: \(account2.balance)")
    }

  
    // Account 1: 500
    // Account 2: 500
    //
    // Both variables point to the same object.


    // MARK: -  Class Containing Struct

    struct Address {

        var city: String
    }

    class Customer {

        var name: String
        var address: Address

        init(name: String, address: Address) {
            self.name = name
            self.address = address
        }
    }

    func classContainingStruct() {

        let customer1 = Customer(
            name: "Nav",
            address: Address(
                city: "Chandigarh"
            )
        )

        let customer2 = customer1

        customer2.address.city = "Mohali"

        print("Customer 1: \(customer1.address.city)")
        print("Customer 2: \(customer2.address.city)")
    }

    // Output:
    //
    // Customer 1: Mohali
    // Customer 2: Mohali
    // The Customer object is shared because Customer is a class.


    // MARK: -  Class in MVVM

    class UserViewModel {

        var user: classUser

        init(user: classUser) {
            self.user = user
        }

        func updateName(_ name: String) {
            user.name = name
        }
    }

    func mvvmExample() {

        let user = classUser(
            name: "Nav",
            age: 25
        )

        let viewModel = UserViewModel(
            user: user
        )

        viewModel.updateName("Neet")

        print("Name: \(viewModel.user.name)")
    }

    // ViewModels are commonly classes because they may have:
    //
    // - Identity
    // - Lifecycle
    // - Mutable state
    // - References to services
    // - Observers
    // - Shared state


    // MARK: - 16. Class and ARC

    class NetworkManager {

        static let shared = NetworkManager()

        private init() {}

        func fetchData() {
            print("Fetching data...")
        }
    }

    func arcExample() {

        let manager = NetworkManager.shared

        manager.fetchData()
    }

    // Class instances are managed by ARC
    // (Automatic Reference Counting).
    //
    // ARC keeps track of strong references to objects and removes an object when its strong reference count reaches zero.


    // MARK: - Class Summary

    // Class:
    //
    
    // 1. Reference type
    // 2. Supports shared references
    // 3. Supports inheritance
    // 4. Uses ARC
    // 5. Supports deinit
    // 6. Has object identity
    // 7. Supports ===
    // 8. Does not require mutating methods
    // 9. Useful for shared state
    // 10. Useful when identity/lifecycle matters
}
