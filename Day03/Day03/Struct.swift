//
//  Struct.swift
//  Day03
//
//  Created by Navneet on 19/08/26.
//

// Struct is a VALUE TYPE.
// When a struct is assigned to another variable, the new variable gets its own independent value.
//
// Common examples of value types:
// Struct, Enum, Tuple
//
// Structs are commonly used for:
// - Models
// - Data objects
// - View state
// - Configuration
// - Lightweight types

struct User {
    var name: String
    var age: Int
}

struct StructExample {

    
    
    // MARK: - Basic Struct
    let user = User( name: "Nav", age: 25 )
    
    func basicStructEg() {

        print("Name: \(user.name)")
        print("Age: \(user.age)")
    }



    // MARK: -  Value Type Behaviour

    func valueTypeBehaviour() {


        // Struct is a value type.
        // user2 gets an independent copy of user.

        var user2 = user

        user2.name = "Some"

        print("User 1: \(user1.name)")
        print("User 2: \(user2.name)")
    }

    // Output:
    // User 1: Nav
    // User 2: Some

    // Changing user2 does NOT affect user1.


    // MARK: - Struct with Let

    func structWithLet() {

        let user = User(
            name: "Nav",
            age: 25
        )

        // updation not allowed as user is a constant struct value.
        //stored var properties cannot be modified.
    }


    // MARK: - Struct with Var

    func structWithVar() {

        var user = User(
            name: "Nav",
            age: 25
        )

        user.name = "Some"
        user.age = 30

        print("Name: \(user.name)")
        print("Age: \(user.age)")
    }


    // MARK: - Mutating Method

    struct Counter {

        var value = 0

        // A struct method cannot modify stored properties unless it is marked with the mutating keyword.

        mutating func increment() {
            value += 1
        }
    }

    func mutatingMethod() {

        var counter = Counter()

        counter.increment()
        counter.increment()

        print("Counter: \(counter.value)")
    }



    // MARK: -  Struct Method

    struct Calculator {

        var value: Int

        func square() -> Int {
            return value * value
        }
    }

    func structMethod() {

        let calculator = Calculator(value: 5)

        print("Square: \(calculator.square())")
    }


    // MARK: - Struct Assignment

    func structAssignment() {

        var person1 = User(
            name: "Nav",
            age: 25
        )

        var person2 = person1

        print("Before modification:")
        print("Person 1: \(person1.name)")
        print("Person 2: \(person2.name)")

        person2.name = "Neet"

        print("After modification:")
        print("Person 1: \(person1.name)")
        print("Person 2: \(person2.name)")
    }

    // Struct:
    //
    // person1 → User value
    //
    // person2 → Independent copy of User value
    //
    // Therefore changing person2 does not change person1.


    // MARK: - Passing Struct to Function

    func updateUser(_ user: User) {

        var user = user

        user.name = "Updated"

        print("In function: \(user.name)")
    }

    func structFunctionParameter() {

    

        updateUser(user)

        // Original value remains unchanged.

        print(" Original value: \(user.name)")
    }


    // MARK: -  Struct Returning from Function

    func createUser() -> User {

        return user
    }

    func structReturnValue() {

        let user = createUser()

        print("Created User: \(user.name)")
    }


    // MARK: - Nested Struct

    struct Address {

        var city: String
        var country: String
    }

    struct Customer {

        var name: String
        var address: Address
    }

    func nestedStruct() {

        let customer = Customer(
            name: "Nav",
            address: Address(
                city: "Chandigarh",
                country: "India"
            )
        )

        print("Name: \(customer.name)")
        print("City: \(customer.address.city)")
        print("Country: \(customer.address.country)")
    }


    // MARK: - Struct and Value Semantics

    func valueSemantics() {

        var address1 = Address(
            city: "Chandigarh",
            country: "India"
        )

        var address2 = address1

        address2.city = "City"

        print("Address 1: \(address1.city)")
        print("Address 2: \(address2.city)")
    }

    // Output:
    //
    // Address 1: Chandigarh
    // Address 2: City
    //
    // Each variable has its own value.


    // MARK: - Struct with Computed Property

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


    // MARK: - Struct with Static Property

    struct AppConfiguration {

        static let appName = "MyApp"

        var environment: String
    }

    func staticProperty() {

        print("App Name: \(AppConfiguration.appName)")

        let config = AppConfiguration(
            environment: "Production"
        )

        print("Environment: \(config.environment)")
    }


    // MARK: -  Struct in iOS Model

    struct UserModel {

        let id: Int
        let name: String
        let email: String
    }

    func iOSModelExample() {

        let user = UserModel(
            id: 101,
            name: "Nav",
            email: "nav@example.com"
        )

        print("ID: \(user.id)")
        print("Name: \(user.name)")
        print("Email: \(user.email)")
    }

    // Structs are commonly used for API models
    // because they represent data and usually
    // don't require object identity.



    // Struct:
    //
    // 1. Value type
    // 2. Independent copies
    // 3. No inheritance
    // 4. Does not use ARC
    // 5. Supports mutating methods
    // 6. No deinit
    // 7. Good for data/models
    // 8. Provides value semantics
}
