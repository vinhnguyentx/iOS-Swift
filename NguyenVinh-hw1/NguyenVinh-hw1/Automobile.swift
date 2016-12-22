//
//  Automobile.swift
//  NguyenVinh-hw1
//
//  Created by Vinh Nguyen on 1/28/16.
//  Copyright © 2016 CS378. All rights reserved.
//

import Foundation

class Automobile {
    
    private var make:String
    
    private var model:String
    
    private var numberOfDoors:Int
    
    private var speed:Int
    
    // init method
    // initialize all properties to their passed-in values
    init(make:String, model:String, numberOfDoors:Int, speed:Int) {
        
        self.make = make
        
        self.model = model
        
        self.numberOfDoors = numberOfDoors
        
        self.speed = speed
        
    }
    
    // create method
    // create an instance of an object
    class func create(make:String, model:String, numberOfDoors:Int, speed:Int) -> Automobile {
        
        return Automobile(make: make, model: model, numberOfDoors: numberOfDoors, speed: speed)
        
    }
    
    // getMake method
    // get Make of object
    func getMake() -> String {
        
        return make
        
    }
    
    // setMake method
    // set a given Make for object
    func setMake(value:String) {
        
        make = value
        
    }
    
    // getModel method
    // get Model of object
    func getModel() -> String {
        
        return model
        
    }
    
    // setModel method
    // set a given Model for object
    
    func setModel(value:String) {
        
        model = value
        
    }
    
    // getNumberOfDoors method
    // get Number of doors of object
    func getNumberOfDoors() -> Int {
        
        return numberOfDoors
        
    }
    
    // setNumberOfDoors method
    // set a given Number of doors for object
    func setNumberOfDoors(value:Int) {
        
        numberOfDoors = value
        
    }
    
    // getSpeed method
    // get speed of object
    func getSpeed() -> Int {
        
        return speed
        
    }
    
    // setSpeed method
    // set a given speed for object
    func setSpeed(value:Int) {
        
        speed = value
        
    }
    
    // increaseSpeed method
    // make change to the speed of object
    func increaseSpeed(speedChange:Int) {
        
        speed = min(150, speed + speedChange)
        
    }
    
    // decreaseSpeed method
    // make change to the speed of object
    func decreaseSpeed(speedChange:Int) {
        
        speed = max(0, speed - speedChange)
        
    }
    
    // description method
    // get the description of object
    func description() -> String {
        
        return "Make: \(make), Model: \(model), NumDoors: \(numberOfDoors), Speed: \(speed)"
        
    }
    
}