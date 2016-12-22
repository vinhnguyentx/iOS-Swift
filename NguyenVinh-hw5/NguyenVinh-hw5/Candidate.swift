//
//  Candidate.swift
//  NguyenVinh-hw5
//
//  Created by Vinh Nguyen on 2/28/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import Foundation

class Candidate {
    
    private var _firstName:String = ""
    private var _lastName:String = ""
    private var _state:String = ""
    private var _party:String = ""
    
    var firstName:String {
        get {
            return _firstName
        }
        
        set (newValue){
            _firstName = newValue
        }
    }
    
    var lastName:String {
        get {
            return _lastName
        }
        
        set (newValue){
            _lastName = newValue
        }
    }
    
    var state:String {
        get {
            return _state
        }
        
        set (newValue){
            _state = newValue
        }
    }
    
    var party:String {
        get {
            return _party
        }
        
        set (newValue){
            _party = newValue
        }
    }
    
    init (firstName:String, lastName:String, state:String, party:String) {
        self.firstName = firstName
        self.lastName = lastName
        self.state = state
        self.party = party
    }
    
    convenience init() {
        self.init(firstName:"", lastName:"", state:"", party:"")
    }
    
    
    
}