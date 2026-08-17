import UIKit

var greeting = "Hello, playground"

func printUserDetails(
    username: String?,
    email: String?,
    age: Int?,
    city: String?
) {

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

printUserDetails(
 username: "Navneet",
 email: nil,
 age: 25,
 city: nil
 )

//Error Handling
enum LoginError: Error { 
    case invalidEmail
    case wrongPassword
    case userNotFound
}

func login(email : String?, password : String) throws {
    if email == nil {
        throw LoginError.invalidEmail
    }else if password != "1234" {
        throw LoginError.wrongPassword
    }
    print("Login success")
}

do {
    try login(email: "nav@mail.com", password: "123")
}
catch LoginError.invalidEmail{
  print("invalid Email")
}catch LoginError.wrongPassword{
    print("incorrect password")
}catch {
    print("something went wrong")
}

//try - catch errors , try? - will not catch errors, results nil , try! if there is any error app will crash
