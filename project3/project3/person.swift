//
//  person.swift
//  project3
//
//  Created by Vinh Nguyen on 1/27/16.
//  Copyright © 2016 CS378. All rights reserved.
//

import Foundation

class person {
    
    var firstName:String = "Vinh"
    
    var lastName:String
    
    var age:Int = 99
    
    
    
    init(lastName:String) {
        
        self.lastName = lastName
        
    }
    
    
    func description() -> String {
        
        return "\(self.firstName) \(self.lastName) \(self.age)"
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}