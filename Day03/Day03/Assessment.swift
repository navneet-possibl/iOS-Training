//
//  Assessment.swift
//  Day03
//
//  Created by HIMANK on 19/08/26.
//

//Task Struct
//Create employee1.
//Create employee2 by assigning employee1.
//Change employee2.name.
//Print both employees.

struct Employee {
    var name : String
    var empId : Int
    var skill : [String]
}

class EmployeeTask {
    
    let emp1 : Employee = Employee(name: "Nav", empId: 12, skill: ["swift","swiftUI"])
    
    
    func updateEmpDetails() {
        var emp2 = emp1
        emp2.name = "some"
        print("Emp 1" , emp1.name)
        print("Emp 2", emp2.name)
    }
    
}


//Task Class
//Create product1.
//Create product2 = product1.
//Change product2.name.
//Print both employees.

class Product {
    
    var name : String
    var price : Double
    var id : Int
    
    init(name: String, price: Double , id: Int) {
        self.name = name
        self.price = price
        self.id = id
    }
}

class ProductTask {
    
    let product1 : Product = Product(name: "iphone", price: 100000.0, id : 1)
    
    func updateProductDetails() {
        var product2 = product1
        product2.name = "samsung"
        print("Product 1" , product1.name)
        print("Product 2", product2.name)
    }
}


//🔥 Challenge

//You are building an iOS shopping app. You have a Product model and a ShoppingCart.
//
//Requirement:
//
//When a product is added to the cart, modifying the product later should not modify the product already stored in the cart. However, the cart itself should be shared across different parts of the app, so if one screen adds a product, another screen should see the updated cart.
//
//Your task
//
//Decide:
//
//Should Product be a struct or class? - struct
//Should ShoppingCart be a struct or class? -> Class
//Write a small Swift implementation demonstrating your decision.

class ShoppingProduct {
    
    var name : String
    var price : Double
    var id : Int
    
    init(name: String, price: Double , id: Int) {
        self.name = name
        self.price = price
        self.id = id
    }
}


class ShoppingCart {

    var products: [ShoppingProduct] = []

    func addProduct(_ product: ShoppingProduct) {
        products.append(product)
    }

    func removeProduct(_ product: ShoppingProduct) {
        products.removeAll {
            $0.id == product.id
        }
    }

    func totalPrice() -> Double {
        products.reduce(0) {
            $0 + $1.price
        }
    }
    
    
    func updateCart(){
        let iphone = ShoppingProduct(name: "iPhone", price: 80000.0, id: 1)
        let airpods = ShoppingProduct(name: "airpod", price: 12000.0, id: 2)
        addProduct(iphone)
        addProduct(airpods)
        
        print(totalPrice())
    }
}
