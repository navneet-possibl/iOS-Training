//
//  Enums.swift
//  iOS_Training
//
//  Created by Navneet on 17/08/26.
//

//Enums are used to represent a finite set of related values. They can have raw values, associated values, computed properties, and methods. commonly use enums for API states, navigation routes, user roles, and screen states.

enum Direction {
    case north
    case south
    case east
    case west
}

//MARK: - Enums with raw Value
enum HTTPStatus: Int {
    case success = 200
    case unauthorized = 401
    case notFound = 404
    case serverError = 500
}

//MARK: - String Raw Values

enum Environment : String{
    case production = "prod"
    case development = "dev"
    case uat = "uat"

}

//MARK: - Enums with Methods

enum NetworkStatus {
    case connected
    case disconnected

    func description() -> String {
        switch self {
        case .connected:
            return "Internet available"

        case .disconnected:
            return "No internet"
        }
    }
}


//MARK: - Associated Enums
//Associated values allow each enum case to store additional data. The data can be different for each case.
enum Result {
    case success(data: String) //can be string, array, dict, int anything
    case failure(code: Int, error: String)
    
}

class EnumExamples {
    let direction = Direction.north // knows the type of direction is north
    
  //  direction = .east updated to east if var
    
    let status = HTTPStatus.success

    let environment = Environment.development
    
    func switchWithEnum() {
        switch direction {
        case .north:
            print("Direction is north")
        case .south:
            print("Direction is south")
        case .east:
            print("Direction is east")
        case .west:
            print("Direction is west")

        }
        //no default needed as we are woring with all enum cases here.
    }
    
    func rawValues(){
        
        print(status.rawValue) //-> result will be 200 // api responses
        print(environment.rawValue) // result will be "dev" //USeful for setting environment , apis, any other events
        let result = Result.success(data: "User Profile")
        
        let resultFail = Result.success(data: "User Profile fetch failed") //both result.success but have diff. data
        
        let failure = Result.failure(code: 401, error: "Auth Failed")
        
        switch result {
        case .success(let data)://Single Value
            print("Success: \(data)")

        case .failure(let code, let error): //Multiple values
            print("Code : \(code), Error: \(error)")
        }
    }
    
    func networkStat(){
        print(NetworkStatus.connected.description()) // - result "Internet available"
    }
}


//Raw has default predefined cases but associated can have different data for same case
