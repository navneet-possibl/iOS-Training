//
//  AccessControl.swift
//  Day05
//
//  Created by HIMANK on 21/08/26.
//

//open    Anywhere + subclassable outside module
//public    Anywhere, but subclassing restrictions apply
//package    Within the same Swift package
//internal    Same module
//fileprivate    Same file
//private    Same declaration/scope
//


class UserService {

    func fetchUsers() {
        print("Fetching users")
    }
}
//Internal - by default -  Accessible anywhere within the same app/module.

final class UserDataViewModel {

    private var users: [String] = []

    private func updateUsers() {
        print("Updating users")
    }
}//Accessible only inside the declaration and its appropriate extensions.


class UserList{
    
    let viewModel = UserDataViewModel()

    func fetchUsers(){
       // viewModel.updateUsers()//not allowed
    }
}


//Accessible only within the same Swift file.
fileprivate class Helper {

    func execute() {
        print("Executed")
    }
}


public class AnalyticsService {

    public init() {}

    public func trackEvent() {
        print("Event tracked")
    }
}
//Used when building frameworks or SDKs.
//Other modules can access

open class Animal {}
//Other modules can:
//
//Access it
//Subclass it
//Override eligible methods
//
//open is primarily for framework APIs designed for external customization.
