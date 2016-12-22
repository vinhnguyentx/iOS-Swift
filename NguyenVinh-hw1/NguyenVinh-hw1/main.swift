//
//  main.swift
//  NguyenVinh-hw1
//
//  Created by Vinh Nguyen on 1/28/16.
//  Copyright © 2016 CS378. All rights reserved.
//

import Foundation

func main() {
    
    // create an array of Automobile to store new objects
    var autoArray = [Automobile]()
    
    // (manually) add new objects to the array
    autoArray.append(Automobile.create("Maserati", model: "GranTurismo", numberOfDoors:  2, speed: 0))
    autoArray.append(Automobile.create("Honda", model: "Accord", numberOfDoors: 4, speed: 0))
    autoArray.append(Automobile.create("Tesla", model: "S 90", numberOfDoors: 2, speed: 0))
    
    // Random number generation (code from HW1 instruction sheet)
    func randomValueBetween(min:UInt32, max:UInt32) -> UInt32 {
        
        let randomValue:UInt32 = min + arc4random_uniform(UInt32(max - min + 1))
        
        return randomValue
    }
    
    // loop to run 10 times of speed changes
    for _ in 1...10 {
        
        // iterate through objects in autoArray
        for auto in autoArray {
            
            let speedChange = Int(randomValueBetween(0, max:16))
            
            auto.increaseSpeed(speedChange)
            
        }
        
    }
    
    
    // declare max speed
    var maxSpeed:Int = 0
    
    // declare winner, initial the winner is the 1st object
    var winner:Automobile = autoArray[0]
    
    // iterate through the autoArray to print out objects' final state
    for auto in autoArray {
        
        print(auto.description())
        
        // compare speed between automobile
        if auto.getSpeed() >= maxSpeed {
            
            maxSpeed = auto.getSpeed()
            
            winner = auto
            
        }
        
    }
    
    // print out the winner
    print("\(winner.getMake()) \(winner.getModel()) won!!")
    
}

main()