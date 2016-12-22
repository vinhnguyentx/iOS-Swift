//
//  Person.swift
//  NguyenVinh-hw3
//
//  Created by Vinh Nguyen on 2/17/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import Foundation

class Person {
    
    var firstName:String = " "
    
    var lastName:String = " "
    
    var age:Int = 0
    
    var street:String = " "
    
    var city:String = " "
    
    var state:String = " "
    
    var zip:Int = 0
    
    init(firstName:String, lastName:String, age:Int, street:String, city:String, state:String, zip:Int) {
        
        self.firstName = firstName
        
        self.lastName = lastName
        
        self.age = age
        
        self.street = street
        
        self.city = city
        
        self.state = state
        
        self.zip = zip
        
    }
    
}