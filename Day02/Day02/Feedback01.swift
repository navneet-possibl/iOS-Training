//
//  Feedback01.swift
//  Day02
//
//  Created by HIMANK on 24/08/26.
//
import Foundation

class Feedback01 {
    
    func performTask(completion: () -> Void) {
        completion()
    }
    
    //    The closure is executed before performTask finishes.
    /* performTask starts
     ↓
     completion executes
     ↓
     performTask ends*/
    
    
    func fetchUser(completion: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion("Navneet")
        }
    }
    
    /*fetchUser starts
     ↓
     Function returns
     ↓
     2 seconds later
     ↓
     Closure executes*/
    
    //MARK: - Real iOS examples
    /*Network API completion
     Animation completion
     Timers
     Delegated async work
     Stored callbacks*/
    
}

//MARK: - Why @escaping is Required
final class UserViewModel {
    
    var completion: (() -> Void)?
    
    /*func fetchData(completion: () -> Void) {
        self.completion = completion
    }*/
    //This will cause a compiler error because the closure is stored and may execute later.
    
    func fetchData(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
}

//MARK: - [weak self] and Retain Cycles
final class RetainViewModel {

    var userName = ""

    func fetchUser() {
//        APIService.shared.fetchUser { user in
//            self.userName = user.name
//        }
        /*UserViewModel -> API Service stores closure -> Closure strongly captures self -> UserViewModel remains alive*/
        
//        APIService.shared.fetchUser { [weak self] user in
//            self?.userName = user.name
//        }//weak self does not keep the ViewModel alive.
        //If the closure is short-lived and not retained in a way that can create a cycle, [weak self] may not be necessary.
    }
}
//Task {
//    let user = await service.fetchUser()
//    self.user = user
//}
 //

/*When to use unowned?

Only when you're certain self will still exist when the closure executes.

Otherwise, it can crash.

weak self
- self can become nil
- Safe

unowned self
- assumes self exists
- Can crash*/

//MARK: - Generics
//Without generics

func printInt(_ value: Int) {
    print(value)
}

func printString(_ value: String) {
    print(value)
}

//With generics
func printValue<T>(_ value: T) {
    print(value)
}

/*printValue(10)
 printValue("Hello")
 printValue(true)*/
//Works with any type

//Generic Constraints
func findMax<T: Comparable>(_ first: T, _ second: T) -> T {
    first > second ? first : second
}

//Usage
/*findMax(10, 20)
 findMax("Apple", "Banana")*/

//MARK: - Real iOS Generic API Response
struct APIResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String
    let data: T
}
//Will work for both
//APIResponse<User>
//APIResponse<Product>

struct User: Decodable {
    let id: Int
    let name: String
}

struct Product: Decodable {
    let id: Int
    let title: String
}

//associatedtype

//associatedtype is used inside protocols when the protocol works with a type that will be decided by the conforming type.

protocol Repository {
    associatedtype Item

    func fetch() async throws -> [Item]
}

struct UserRepository: Repository {

    typealias Item = User

    func fetch() async throws -> [User] {
        []
    }
}

struct ProductRepository: Repository {

    typealias Item = Product

    func fetch() async throws -> [Product] {
        []
    }
}
//The protocol defines the structure, while the conforming type decides the actual associated type.


//some represents one specific concrete type, but hides its exact type.---> Swift knows the concrete type behind the scenes.
//any represents a value of any type conforming to a protocol.

//some
//→ One underlying concrete type
//
//any
//→ Different conforming concrete types can be used
