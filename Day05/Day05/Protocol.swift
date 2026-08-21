//
//  Protocol.swift
//  Day05
//
//  Created by HIMANK on 21/08/26.
//

//A protocol defines a contract.
//"Any type conforming to me must provide these properties or functions."
protocol Vehicle {
    var name: String { get }
    
    func start()
}

struct Car: Vehicle {
    
    let name: String
    
    func start() {
        print("\(name) started")
    }
   
}

//let car = Car(name: "BMW")
//
//car.start() //Use it like this
//Output will be- BMW started

//Without protocols, code can become tightly coupled.

class APIService  {

    func loginUser() {
        print("Fetching user from API")
    }
}

//bad usage - as it directly depends on the UserAPIService
class LoginViewModel {

    func fetchUser() {
        let service = APIService()
        service.loginUser()
    }
}


//Protocol
protocol UserServiceProtocol {
    func fetchUser()
}

class UserAPIService: UserServiceProtocol {

    func fetchUser() {
        print("Fetching user from API")
    }
}

class UserViewModel {

    private let service: UserServiceProtocol

    init(service: UserServiceProtocol) {
        self.service = service
    }

    func loadUser() {
        service.fetchUser()
    }
}

//Protocol Properties
protocol UserProtocol {

    var id: Int { get } //read

    var name: String { get set } //read and write
}

//use it as
struct User: UserProtocol {

    let id: Int

    var name: String
}

//Protocol Functions
protocol LoginProtocol {

    func login(email: String, password: String)

    func logout()
}

final class AuthService: LoginProtocol {
    func login(email: String, password: String) {
        print("Logging in: \(email)")
    }

    func logout() {
        print("Logging out")
    }
}
//

//Protocol Extensions - making protocols powerful
//We can provide a default implementation:
extension Vehicle {

    func start() {
        print("Car named: \(name) started")
    }
}//Protocol extensions allow  to share behavior without requiring inheritance.

//Any Protocol
//when storing a protocol as a type:
//let service: any UserServiceProtocol

class AnyViewModel {

    private let service: any UserServiceProtocol

    init(service: any UserServiceProtocol) {
        self.service = service
    }
} //This variable can hold an instance of any concrete type that conforms to this protocol.
