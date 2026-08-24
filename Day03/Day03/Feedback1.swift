//
//  Feedback1.swift
//  Day03
//
//  Created by HIMANK on 24/08/26.
//

//Access Specifiers
//
//Access control decides where a property, method, or type can be accessed.
//
//private
//
//Accessible only within the enclosing declaration and its extensions in the same file.

class Users {

    private var password = "1234"

    func printPassword() {
        print(password)
    }
}

//let user = Users()

// user.password - This will not work from outside

//EG:
class LoginViewModel {

    private var authToken: String? //This will not work from outside

    func login() {
        authToken = "token_123"
    }
}


//fileprivate

//Accessible anywhere within the same Swift file.

fileprivate class UserManager {

    fileprivate var name = "Nav"
}

class AnotherClass {

    func test() {
        let manager = UserManager()
        print(manager.name)
    }
}

/*private
 Only the enclosing declaration


 fileprivate
 Anywhere in the same file*/

/*public

Accessible outside the module.

Useful when creating a framework or library.*/

public class NetworkManager {

    public init() {}

    public func fetchData() {
        print("Fetching data")
    }
}

//An app importing your framework can use:

func fetchManager() {
    let manager = NetworkManager()
    manager.fetchData()
}

//Important
//
//With public, the API can be accessed outside the module, but subclassing/overriding has restrictions compared with open.

/*open

open is the most permissive access level for classes and overridable class members.

It allows code outside the module to subclass the class and override open members.*/

open class Animal {

    public init() {}

    open func makeSound() {
        print("Animal sound")
    }
}

//Another module can do:

class Dog: Animal {

    override func makeSound() {
        print("Bark")
    }
}

/*private
 - Only inside the declaration / relevant same-file extensions


 fileprivate
 - Anywhere in the same Swift file


 internal
 - Anywhere in the same module
 - Default access level


 public
 - Accessible outside the module


 open
 - Accessible outside the module
 - Can also be subclassed/overridden outside the module*/

//MARK: -final :

//This class cannot be subclassed.

final class NetworkManagers {

    func fetchData() {
        print("Fetching data")
    }
}

//This is not allowed:
// class CustomNetworkManager: NetworkManagers
//Prevent unintended inheritance
//Protect behavior
//Potential optimization


class LoginManager {

    final func logout() {
        print("User logged out")
    }

    func login() {
        print("User logged in")
    }
}
//A subclass can override login(), but not logout().


/*Choose struct when:
 You represent data.
 Value semantics are desirable.
 Identity doesn't matter.
 You don't need inheritance.
 Independent values are safer.
 
 Choose class when:
  Identity matters.
  Multiple places need to share the same instance.
  You need reference semantics.
  You need inheritance.
  You need deinit.
  You need shared mutable state. */
