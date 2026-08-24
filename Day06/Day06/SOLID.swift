//
//# SOLID Principles in Swift
//
//A simple iOS project demonstrating the **SOLID principles** using Swift.
//
//## 📚 What is SOLID?
//
//SOLID is a set of five object-oriented design principles that help developers write clean, maintainable, scalable, and testable code.
//
//* **S** — Single Responsibility Principle
//* **O** — Open/Closed Principle
//* **L** — Liskov Substitution Principle
//* **I** — Interface Segregation Principle
//* **D** — Dependency Inversion Principle
//
//---
//
//## 1. Single Responsibility Principle (SRP)
//
//A class should have **only one reason to change**.
//
//```swift
//final class UserService {
//    func fetchUser() {
//        // Fetch user data
//    }
//}
//
//final class UserLogger {
//    func logUser() {
//        // Log user information
//    }
//}
//```
//
//Each class has a single responsibility.
//
//---
//
//## 2. Open/Closed Principle (OCP)
//
//Classes should be **open for extension but closed for modification**.
//
//```swift
//protocol Shape {
//    func calculateArea() -> Double
//}
//
//final class Circle: Shape {
//    func calculateArea() -> Double {
//        return 10
//    }
//}
//
//final class Rectangle: Shape {
//    func calculateArea() -> Double {
//        return 20
//    }
//}
//```
//
//New shapes can be added without changing existing code.
//
//---
//
//## 3. Liskov Substitution Principle (LSP)
//
//A subclass should be replaceable with its parent without breaking the application.
//
//```swift
//protocol Payment {
//    func pay()
//}
//
//final class CreditCardPayment: Payment {
//    func pay() {
//        print("Paid using Credit Card")
//    }
//}
//
//final class ApplePayPayment: Payment {
//    func pay() {
//        print("Paid using Apple Pay")
//    }
//}
//```
//
//Both payment types can be used wherever `Payment` is expected.
//
//---
//
//## 4. Interface Segregation Principle (ISP)
//
//A class should not be forced to implement methods it does not need.
//
//```swift
//protocol Workable {
//    func work()
//}
//
//protocol Eatable {
//    func eat()
//}
//
//final class Developer: Workable, Eatable {
//    
//    func work() {
//        print("Coding")
//    }
//    
//    func eat() {
//        print("Eating")
//    }
//}
//```
//
//Small, focused protocols are preferred over large protocols.
//
//---
//
//## 5. Dependency Inversion Principle (DIP)
//
//High-level modules should depend on **abstractions, not concrete implementations**.
//
//```swift
//protocol NetworkServiceProtocol {
//    func fetchData()
//}
//
//final class NetworkService: NetworkServiceProtocol {
//    func fetchData() {
//        print("Fetching data")
//    }
//}
//
//final class UserViewModel {
//    
//    private let service: NetworkServiceProtocol
//    
//    init(service: NetworkServiceProtocol) {
//        self.service = service
//    }
//}
//```
//
//This makes the code easier to test and maintain.
//
//---
//
//
//```text
//SOLID
//│
//├── SRP
//│   └── SingleResponsibility.swift
//│
//├── OCP
//│   └── OpenClosed.swift
//│
//├── LSP
//│   └── LiskovSubstitution.swift
//│
//├── ISP
//│   └── InterfaceSegregation.swift
//│
//├── DIP
//│   └── DependencyInversion.swift

//```
//
//## ✨ Key Benefits
//
//* Clean code
//* Better maintainability
//* Improved scalability
//* Easier unit testing
//* Loose coupling
//* Better code reusability
//
