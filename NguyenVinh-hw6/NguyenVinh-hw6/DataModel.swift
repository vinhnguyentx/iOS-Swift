//
//  DataModel.swift
//  NguyenVinh-hw6
//
//  Created by Vinh Nguyen on 3/10/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit
import CoreData

class DataModel: NSObject {

    private var candidates:[Candidate] = [Candidate]()
    
    // Core Data object
    var data = [NSManagedObject]()
    
    override init() {
        super.init()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //
        let fetchRequest = NSFetchRequest(entityName:"Candidate")
        
        //
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // update local data from permanent storage by using another thread
        if let results = fetchedResults {
            data = results
            dispatch_sync(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
                for i in self.data {
                    let object = i
                    let firstName:String = (object.valueForKey("firstName") as? String!)!
                    let lastName:String = (object.valueForKey("lastName") as? String)!
                    let party:String = (object.valueForKey("party") as? String)!
                    let state:String = (object.valueForKey("state") as? String)!
                    let vote:Int = (object.valueForKey("vote") as? Int)!
                    let temp = Candidate(firstName: firstName, lastName: lastName, state: state, party: party, vote: vote)
                    self.candidates.append(temp)
                }
            }
            
        } else {
            print("Could not fetch")
        }
    }
    
    func count() -> Int {
        return candidates.count
    }
    
    func addCandidate(firstName firstName:String, lastName:String, state:String, party:String) {
        
        let temp = Candidate(firstName: firstName, lastName: lastName, state: state, party: party)
        
        // save to both storages
        candidates.append(temp)
        saveCandidate(temp)
    }
    
    func getCandidate(index index:Int) -> Candidate {
        return candidates[index]
    }
    
    // save to permanent storage
    private func saveCandidate(candidate: Candidate) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entityForName("Candidate", inManagedObjectContext: managedContext)
        
        let cand = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        // Set the attribute values
        cand.setValue(candidate.firstName, forKey: "firstName")
        cand.setValue(candidate.lastName, forKey: "lastName")
        cand.setValue(candidate.party, forKey: "party")
        cand.setValue(candidate.state, forKey: "state")
        
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // Add the new entity to our array of managed objects
        data.append(cand)
    }
}
