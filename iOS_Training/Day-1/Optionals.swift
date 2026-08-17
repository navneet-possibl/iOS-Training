//
//  Optionals.swift
//  iOS_Training
//
//  Created by Navneet on 17/08/26.
//

import Foundation

struct User{
    var profile : Profile? //optional
}

struct Profile {
    var name : String? //optional
}


class OptionalsExampple {
    //An Optional is a type that can either contain a value or contain nil.
    
    var optionalName : String?  // Declaration - of an optional var - it may contain a value or not
    
//    var name : String = nil //compile time error as initialization of non optional cannot be nil
    
    var user : User? // Declaration - of an optional User
    
    
    func userName(){
        optionalName = "user" //It has value
        optionalName = nil // Now it is nil --> but app will not crash as the property name is declared as optional
    }
    
    func fetchUsersData() -> User? { // Means can or cannot return User
      return nil
    }
    
    //MARK: - Optional Binding
    //Optional binding is used to safely unwrap an optional value using if let or guard let. If the optional contains a value, Swift creates a non-optional constant containing that value; otherwise, the failure path is executed.
    
    func fetchUserName(){
        
        if let name = optionalName{
            print(name) //temporary assigns optionalName to name -> now it is string not string?
            //shortlived  inside the if let block only
        }
        
        
        guard let name = optionalName else{ //if optional name has value then it will assign it to name otherwise else block will run - helps handling the failures early -> Early exit happy path
            return
        }//name will outlive the guard block but can be used inside the fetchUserName only
        
    }
    
    //MARK: - Optional Chaining
    // optional chaining lets us safely access multiple levels of optional properties without deeply nested if let statements. If any link in the chain is nil, the entire expression returns nil, making the code more concise and readable.
    
    func fetchUserNameFromStruct(){
        if let user = user{
            if let profile = user.profile {
                if let name = profile.name{
                    print(name)

                }
            }
        }//useful when have to perform something on each level
        
       // instead of writing above code we can use the shorthand as it has no nested pyramid
        
        if let user = user?.profile?.name{
            
        } // return optional string
        // if anything becomes nil it will return nil
        
        
    
    }
    
    //MARK: - Nil-Coalescing Operator
   // The nil-coalescing operator (??) is used with an Optional to provide a default value when the Optional is nil.
    func displayName(){
        
        let displayName = user?.profile?.name ?? "Guest"
        //if user-profile-name exists show that --> otherwise show Guest (default)

    }
    
    
    //MARK: - Force Unwrapping — !
    //sure that this Optional contains a value. Give me the value directly.
    //Avoid ! unless sure that value cannot be nil.
    
    func forceUnwrap(){
        let name : String? = "Some Name"
        print(name!)
        //This works as name != nil there is a default value for safety
        
        let age : Int? = nil
        print(age!) //This won't work as age = nil it will cause crash
    }
    
//    ?.  → "Can I safely access it?"
//    ??  → "If I can't, what should I use?"
//    !   → "I guarantee it's there."
    
//    if let   → "I need the value only here."
//    guard let → "I need the value for the rest of this scope."
}
