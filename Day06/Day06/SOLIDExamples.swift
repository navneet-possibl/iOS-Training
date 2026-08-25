//
//  SOLIDExamples.swift
//  Day06
//
//  Created by HIMANK on 24/08/26.
//

import Foundation

//MARK: — Single Responsibility Principle
//
//A class should have one primary responsibility and one reason to change.


//BAD EXAMPLE
final class UserManager {

    func fetchUser() {
        // API call
    }

    func saveUser() {
        // Database logic
    }

    func showUserAlert() {
        // UI logic
    }
}
//This class handles multiple responsibilities.

//Better Example
final class UserServices {
    func fetchUser() {
    }
}

final class UserRepository {
    func saveUser() {
    }
}

//MARK: - Open/Closed Principle

//Software entities should be open for extension but closed for modification.
protocol PaymentProcessor {
    func processPayment()
}

final class CardPayment: PaymentProcessor {

    func processPayment() {
        print("Processing card payment")
    }
}

//if needed we can extend by adding a new implementation.
final class ApplePayPayment: PaymentProcessor {

    func processPayment() {
        print("Processing Apple Pay")
    }
}


//MARK: - Liskov Substitution Principle

//A subtype should be usable wherever its parent type is expected without breaking the application.
protocol Vehicle {
    func start()
}


final class FourWheeler: Vehicle {

    func start() {
        print("FourWheeler started")
    }
}
//Any code expecting Vehicle should work correctly with Car.

//MARK: -  Interface Segregation Principle

//A class should not be forced to implement methods it does not need.
protocol Worker {
    func work()
    func eat()
    func sleep()
}

//Every conforming type must implement everything.

//Better
protocol Workable {
    func work()
}

protocol Eatable {
    func eat()
}


final class Developer: Workable, Eatable {

    func work() {
    }

    func eat() {
    }
}

//MARK: - Dependency Inversion Principle

//High-level modules should depend on abstractions, not concrete implementations.


//corect
final class UseViewModel {

    private let service: UserServiceProtocol

    init(service: UserServiceProtocol) {
        self.service = service
    }
}
