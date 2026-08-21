import UIKit

var greeting = "Hello, playground"

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

let service = UserAPIService()

let viewModel = UserViewModel(service: service)

viewModel.loadUser()


protocol UserProtocol {

    var id: Int { get } //read

    var name: String { get set } //read and write
}

//use it as
struct User: UserProtocol {

    let id: Int

    var name: String
}

protocol Vehicle {

    var name: String { get }

    func start()
}

extension Vehicle {

    func start() {
        print("Car named: \(name) started")
    }
}

struct Car: Vehicle {

    let name: String
}

let car = Car(name: "BMW")

car.start()

