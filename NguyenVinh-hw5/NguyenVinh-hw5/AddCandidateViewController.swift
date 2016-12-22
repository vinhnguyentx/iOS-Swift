//
//  AddCandidateViewController.swift
//  NguyenVinh-hw5
//
//  Created by Vinh Nguyen on 2/28/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit
import CoreData

class AddCandidateViewController: UIViewController {
   
    var party:String = ""
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var stateTextField: UITextField!
    
//    var firstName:String = firstNameTextField!.text
//    var lastName:String = ""
//    var state:String = ""
    
    var currentTwoOption = 0
    
    @IBOutlet weak var partyTextField: UISegmentedControl!
    
    @IBAction func partySegmentOption(sender: AnyObject) {
        self.currentTwoOption = self.partyTextField.selectedSegmentIndex
        self.setTwoOptionsLabelText()
    }
    
    func setTwoOptionsLabelText() {
        switch self.partyTextField.selectedSegmentIndex
        {
        case 0:
            self.party = "Democrat"
        case 1:
            self.party = "Republican"
        default:
            break
        }
    }
    
//    var ballot = [NSManagedObject]()
    
    @IBAction func saveButtonAction(sender: AnyObject) {
        
        let cand:Candidate = Candidate(firstName: firstNameTextField!.text!, lastName: lastNameTextField!.text!, state: stateTextField!.text!, party: self.party)
        
        DataModel.add(cand)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Candidate"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        let managedContext = appDelegate.managedObjectContext
//        
//        let fetchRequest = NSFetchRequest(entityName:"Candidate")
//        
//        var fetchedResults:[NSManagedObject]? = nil
//        
//        do {
//            try fetchedResults = managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
//        } catch {
//            // what to do if an error occurs?
//            let nserror = error as NSError
//            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
//            abort()
//        }
//        
//        if let results = fetchedResults {
//            ballot = results
//        } else {
//            print("Could not fetch")
//        }
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
//        
//        ////////////////////////////////////////////////////////
//        // Get the data from our DataModel object
//        //        let person = self.data.get(index: indexPath.row)
//        
//        //        cell.textLabel!.text! = person.name
//        //        cell.detailTextLabel!.text! = String(person.age)
//        
//        ////////////////////////////////////////////////////////
//        // Get the data from Core Data
//        let person = ballot[indexPath.row]
//        
//        cell.textLabel!.text = person.valueForKey("name") as? String
//        cell.detailTextLabel!.text = String((person.valueForKey("age") as? Int)!)
//        
//        return cell
//    }
//
//    func saveCandidate(name: String, age: String) {
//        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        let managedContext = appDelegate.managedObjectContext
//        
//        // Create the entity we want to save
//        let entity =  NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
//        
//        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
//        
//        // Set the attribute values
//        person.setValue(name, forKey: "name")
//        person.setValue(Int(age), forKey: "age")
//        
//        // Commit the changes.
//        do {
//            try managedContext.save()
//        } catch {
//            // what to do if an error occurs?
//            let nserror = error as NSError
//            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
//            abort()
//        }
//        
//        // Add the new entity to our array of managed objects
//        ballot.append(person)
//    }
    
    
}
