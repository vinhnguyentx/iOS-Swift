//
//  Candidate.swift
//  NguyenVinh-hw6
//
//  Created by Vinh Nguyen on 3/10/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit
import CoreData

class Candidate: NSObject {

    private var _firstName:String = ""
    private var _lastName:String = ""
    private var _state:String = ""
    private var _party:String = ""
    private var _vote:Int = 0
    
    init(firstName:String, lastName:String, state:String, party:String) {
        super.init()
        _firstName = firstName;
        _lastName = lastName
        _state = state
        _party = party
    }
    
    init(firstName:String, lastName:String, state:String, party:String, vote:Int) {
        super.init()
        _firstName = firstName;
        _lastName = lastName
        _state = state
        _party = party
        _vote = vote
    }
    
    convenience override init () {
        self.init(firstName: "", lastName: "", state: "", party: "")
    }
    
    var firstName:String {
        get {
            return _firstName
        }
        set (value) {
            _firstName = value
        }
    }
    
    var lastName:String {
        get {
            return _lastName
        }
        set (value) {
            _lastName = value
        }
    }
    
    var state:String {
        get {
            return _state
        }
        set (value) {
            _state = value
        }
    }
    
    var party:String {
        get {
            return _party
        }
        set (value) {
            _party = value
        }
    }
    
    var vote:Int {
        get {
            return _vote
        }
        set (value) {
            _vote = value
        }
    }
    
    func addVote() {
        ++_vote
        // save to permanent storage
        updateCandidate()
    }
    
    // update both permanent and local data
    private func updateCandidate() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName:"Candidate")
        
        // filter the candidate needed
        fetchRequest.predicate = NSPredicate(format: "firstName = %@", firstName)
        fetchRequest.predicate = NSPredicate(format: "lastName = %@", lastName)
        
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            fetchedResults?.first?.setValue(vote, forKey: "vote")
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
}
