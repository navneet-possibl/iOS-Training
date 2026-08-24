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
    
    //try! -- Avoid this in production unless failure is genuinely impossible. It crashes if an error occurs.
    
    //Use throws when a function can fail and the caller should handle the error.
    
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

//A good production error type should provide meaningful failure information.
enum ProductionAPIError : Error {
    case invalidURL
    case invalidResponse
    case unauthorized
    case serverError(statusCode: Int)
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."

        case .invalidResponse:
            return "The server returned an invalid response."

        case .unauthorized:
            return "You are not authorized."

        case .serverError(let statusCode):
            return "Server error: \(statusCode)"

        case .decodingError:
            return "Unable to process the response."
        }
    }
}

//case serverError(statusCode: Int)
//This connects Enums + Associated Values + Error Handling.


//throws vs Result
//Throws : The operation can fail and you want to propagate meaningful errors.

//This is generally a clean choice with modern async/await.

//RESULT:
//Success and failure need to be represented explicitly, especially in callback-based APIs.
