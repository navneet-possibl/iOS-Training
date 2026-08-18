//
//  ErrorHandling.swift
//  iOS_Training
//
//  Created by Navneet on 17/08/26.
//

enum LogError: Error { //Creation of error
    case invalidEmail
    case wrongPassword
    case userNotFound
}

//API Example

enum APIError : Error{
    case invalidURL
    case loginFailed
    case unauthenticated
    case serverError
    case unknown
    
}


class ErrorHandling {
    //Error handling is to handle unexpected situations in a controlled way instead of letting the application crash.
    
    
    /*throw → throws an error
     throws → marks a function that can throw an error
     do-catch → handles the error
     try → calls a throwing function
     try? → converts an error into nil
     try! → assumes there will be no error; can crash*/
    
    
    func login(email : String?, password : String) throws {
        if email == nil {
            throw LogError.invalidEmail
        }else if password != "1234" {
            throw LogError.wrongPassword
        }
        print("Login success")
    }
    
    func logginUSer(){
        do {
            try login(email: "nav@mail.com", password: "123")
        }
        catch LogError.invalidEmail{
            print("invalid Email")
        }catch LogError.wrongPassword{
            print("incorrect password")
        }catch {
            print("something went wrong")
        }
    }
}

