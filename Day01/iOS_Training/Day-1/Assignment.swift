//
//  Assignment.swift
//  iOS_Training
//
//  Created by Navneet on 17/08/26.
//

import Foundation

//Assessment for optionals

//values
/*printUserDetails( username: "Navneet", email: nil, age: 25, city: nil )*/

//Output should be
/*Username: Navneet  Email: Not Provided Age: 25 City: Unknown Adult user*/


class OptionalsAssessment{
    
    func printUserDetails( username: String?, email: String?, age: Int?,city: String?) {

        if let name = username{
            print("Username : \(name)")
        }
        
        let providedEmail = email ?? "Not Provided"
        print("Email: \(providedEmail)")
        
        
        guard let ageUser = age else {
            print("Age: Not Provided")
            return
        }
        print("Age: \(ageUser)")
                        
        let cityUser = city ?? "Unknown"
        print("City : \(cityUser)")
        
        ageUser >= 18 ? print("Adult user") :print("Minor user")
        
        
    }
}

//A user may have an optional email, password, and age. Create a LoginError enum for different login failures such as missing email, missing password, invalid credentials, and user not found. Write a throwing login() function that validates the input and returns the user on successful login. Handle all possible errors using do-catch and safely unwrap optional values using if let, guard let, or ??.

enum LoginError : Error{
    case invalidEmail
    case invalidPassword
    case invalidCredentials
    case userNotFound
}

struct LoginUser {
    
    var email : String?
    var password : String?
    let name: String?
    var age : Int?
}

class LoginManager{
    let user : LoginUser? = LoginUser(email: "nav@yopmail.com", password: "123", name: "Navneet",age: nil)
    
    func login(email : String?, password : String?) throws -> LoginUser {
        
        guard let email = email, !email.isEmpty else {
            throw LoginError.invalidEmail
        }
        
        // Optional password
        guard let password = password, !password.isEmpty else {
            throw LoginError.invalidPassword
        }
        
        // Optional user
        guard let user = user else {
            throw LoginError.userNotFound
        }
        
        // Validate credentials
        guard user.email == email && user.password == password else {
            throw LoginError.invalidCredentials
        }
        
        return user
    }
    
    func logginUSer(){
        do {
            let user = try login(
                email: "nav@mail.com",
                password: "123456"
            )
            
            print("Login successful")
            print("Welcome \(user.name)")
            
            // Handle optional age
            if let age = user.age {
                print("Age: \(age)")
            } else {
                print("Age not provided")
            }
            
        } catch LoginError.invalidEmail {
            print("Email is required")
            
        } catch LoginError.invalidPassword {
            print("Password is required")
            
        } catch LoginError.invalidCredentials {
            print("Invalid email or password")
            
        } catch LoginError.userNotFound {
            print("User not found")
            
        } catch {
            print("Something went wrong")
        }
    }
}



