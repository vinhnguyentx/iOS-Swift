//
//  DataModel.swift
//  NguyenVinh-hw5
//
//  Created by Vinh Nguyen on 2/29/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import Foundation

class DataModel {
    
    private var list:[Candidate] = [Candidate]()
    
    init() {
        // Create the list of people
//        list.append(Candidate(firstName: "Hillary", lastName: "Clinton", state: "CA", party: "Democrat"))
//        list.append(Candidate(firstName: "Ben", lastName: "Carson", state: "NY", party: "Republican"))

    }
    
    func count() -> Int {
        return list.count
    }
    
    func get(index index:Int) -> Candidate {
        if index < list.count {
            return list[index]
        } else {
            return Candidate(firstName: "Ben", lastName: "Carson", state: "NY", party: "Republican")
        }
    }
    
    func add(candidate candidate:Candidate) {
        list.append(candidate)
    }
    
    func delete(index index:Int) {
        if index < list.count {
            list.removeAtIndex(index)
        }
    }
}