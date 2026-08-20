//
//  ARC.swift
//  Day04
//
//  Created by HIMANK on 20/08/26.
//

// MARK: - ARC

// ARC = Automatic Reference Counting
// ARC automatically manages memory for class instances
// It keeps track of how many strong references are pointing to an object

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


// MARK: - Strong Reference

// By default, class references are strong

//var employee: Employee? = Employee(name: "Nav")

// Strong reference count = 1

//employee = nil

// Strong reference count = 0
// Object gets deallocated
// deinit will be called


// MARK: - Multiple Strong References

//var employee1: Employee? = Employee(name: "Nav")

// Strong reference count = 1

//var employee2 = employee1

// Strong reference count = 2

//employee1 = nil

// Strong reference count = 1
// Object is still alive because employee2 is holding it

//employee2 = nil

// Strong reference count = 0
// Object gets deallocated


// MARK: - ARC Works with Classes

// ARC is used for class instances because classes use reference semantics

// Structs use value semantics, so ARC is not involved in the same way



// MARK: - Retain Cycle

class Person {

    var apartment: Apartment?

    deinit {

        print("Person deallocated")

    }

}


class Apartment {

    var tenant: Person?

    deinit {

        print("Apartment deallocated")

    }

}


//var person: Person? = Person()

//var apartment: Apartment? = Apartment()


//person?.apartment = apartment

// Person strongly holds Apartment


//apartment?.tenant = person

// Apartment strongly holds Person


//person = nil

//apartment = nil


// Both external references are removed
// But Person and Apartment are still strongly holding each other
// Strong reference cycle / Retain cycle
// Objects will not be deallocated
// deinit will not be called



// MARK: - Fix Retain Cycle Using weak

class PersonWithWeakReference {

    var apartment: ApartmentWithWeakReference?

    deinit {

        print("Person deallocated")

    }

}


class ApartmentWithWeakReference {

    weak var tenant: PersonWithWeakReference?

    deinit {

        print("Apartment deallocated")

    }

}


// weak does not increase the reference count
// weak reference can become nil
// weak is used to break retain cycles


//var person: PersonWithWeakReference? = PersonWithWeakReference()

//var apartment: ApartmentWithWeakReference? = ApartmentWithWeakReference()

//person?.apartment = apartment

//apartment?.tenant = person


//person = nil

// Person gets deallocated
// Apartment's weak tenant automatically becomes nil


//apartment = nil

// Apartment gets deallocated



// MARK: - weak vs unowned

// weak
// Can become nil
// Does not increase reference count
// Must be var
// Must be optional
// Safer when object lifecycle is uncertain


// unowned
// Does not increase reference count
// Assumes the object will always exist
// Usually non-optional
// Can crash if the referenced object is already deallocated



// MARK: - Delegate Example

protocol EmployeeDelegate: AnyObject {

    func employeeUpdated()

}


class EmployeeManager {

    weak var delegate: EmployeeDelegate?

}


// AnyObject is required because
// weak references only work with class types



// MARK: - Closure Retain Cycle

class DataManager {

    var completion: (() -> Void)?

    func setup() {

        completion = {

            self.updateData()

        }

    }

    func updateData() {

        print("Data updated")

    }

    deinit {

        print("DataManager deallocated")

    }

}
// Closure strongly captures self
// DataManager owns closure
// Closure owns DataManager
// Retain cycle occurs



// MARK: - Fix Closure Retain Cycle

class SafeDataManager {

    var completion: (() -> Void)?

    func setup() {

        completion = { [weak self] in

            self?.updateData()

        }

    }

    func updateData() {

        print("Data updated")

    }

    deinit {

        print("SafeDataManager deallocated")

    }

}


// [weak self] means closure does not strongly hold self
// self can become nil
// Retain cycle is avoided



// MARK: - unowned self in Closure

//completion = { [unowned self] in

//    updateData()

//}


// Use unowned only when you are 100% sure
// self will exist when the closure executes
// Otherwise accessing self can cause a crash



// MARK: - Important ARC Debugging

// Add deinit to a class or ViewModel

class TestViewModel {

    deinit {

        print("TestViewModel deallocated")

    }

}


// Navigate to the screen
// Navigate away from the screen

// If deinit is called:
// Object was released correctly

// If deinit is not called when expected:
// Check for retain cycles
// Check closures
// Check delegates
// Check timers
// Check Combine subscriptions
// Check async Tasks



// ARC manages memory for class instances

// Strong reference:
// Keeps object alive

// weak:
// Does not keep object alive
// Can become nil
// Used to break retain cycles

// unowned:
// Does not keep object alive
// Assumes object will always exist
// Can crash if accessed after deallocation

// Retain cycle:
// Two or more objects strongly holding each other

// Closure retain cycle:
// Object -> Closure -> Object

// deinit:
// Called before an object is removed from memory
