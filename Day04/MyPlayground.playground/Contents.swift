import UIKit

var greeting = "Hello, playground"

class Employee {

    let name: String

    init(name: String) {
        self.name = name
        print("\(name) initialized")
    }

    deinit {
        print("\(name) deinitialized")
    }
}

var employee1: Employee? = Employee(name: "Nav")
var employee2 = employee1

employee1 = nil

print("employee1 removed")
print(employee2?.name ?? "User")
employee2 = nil

print("employee2 removed")




class Person {

   weak var apartment: Apartment?

    deinit {
        print("Person deallocated")
    }
}

class Apartment {

   weak var tenant: Person?

    deinit {
        print("Apartment deallocated")
    }
}


class CompanyData {

    var employees: [Employees] = []

    deinit {
        print("Company deallocated")
    }
}

class Employees {

    var name: String
    weak var company: CompanyData? //Fixed

    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) deallocated")
    }
}


//Task { [weak self] in
//    let result = await fetchData()
//
//    self?.saveResult(result) if self disappear save resault will not get called
//}
