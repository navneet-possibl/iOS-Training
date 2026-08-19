import UIKit

var greeting = "Hello, playground"


struct User {
    var name: String
    var age: Int
}


let user = User(
    name: "Nav",
    age: 25
)

print(user.name)

var user2 = user
user2.name = "Somee"

print(user2.name)

struct Counter {

    var value = 0

    mutating func increment(incValue : Int = 1) {
        value += incValue
    }
}

var counter = Counter()

counter.increment(incValue: 10)
counter.increment()

print("Counter: \(counter.value)")

func updateUser(_ user: User) {

    var user = user

    user.name = "Updated"

    print("In function: \(user.name)")
}


func structFunctionParameter() {

    let user = User(
        name: "Navneet",
        age: 27
    )

    updateUser(user)

    // Original value remains unchanged.

    print(" Original value: \(user.name)")
}

structFunctionParameter()
updateUser(user)

struct Rectangle {
    
    
    var width: Double
    var height: Double

    var area: Double {
        return width * height
    }
}

func computedProperty() {

    let rectangle = Rectangle(
        width: 10,
        height: 5
    )

    print("Area: \(rectangle.area)")
}
computedProperty()


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
classInitialization()

func identityOperator() {

    let product1 = Product(
        name: "iPhone",
        price: 79999
    )

    let product2 = product1

    let product3 = Product(
        name: "iPhone",
        price: 79999
    )

    print(product1 === product2)
    print(product1 === product3)
}
identityOperator()


class Animal {

    func makeSound() {
        print("Animal sound")
    }
}

class Dog: Animal {

    override func makeSound() { //default changed
        print("Dog barking")
    }
}

func inheritanceExample() {

    let dog = Dog()

    dog.makeSound()
}

inheritanceExample()


struct Address{
    var city : String
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

classContainingStruct()

struct Employee {
    var name : String
    var empId : Int
    var skill : [String]
}


let emp1 : Employee = Employee(name: "Nav", empId: 12, skill: ["swift","swiftUI"])


func updateEmpDetails() {
    var emp2 = emp1
    emp2.name = "some"
    print("Emp 1" , emp1.name)
    print("Emp 2", emp2.name)
}

updateEmpDetails()



func updateProductDetails() {
    let product1 : Product = Product(name: "iphone", price: 100000)
    var product2 = product1
    product2.name = "samsung"
    print("Product 1" , product1.name)
    print("Product 2", product2.name)
}

updateProductDetails()



