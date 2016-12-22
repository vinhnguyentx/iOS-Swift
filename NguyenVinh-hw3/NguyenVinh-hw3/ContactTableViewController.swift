//
//  ContactTableViewController.swift
//  NguyenVinh-hw3
//
//  Created by Vinh Nguyen on 2/17/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
    var people:[Person] = [Person]()
    
    var alertController:UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Person List"
        
        self.loadDataModel()
    }
    
    func loadDataModel() {
        
        self.people.append(Person(firstName: "August", lastName: "Olivier", age: 33,
            street: "A Mustang Dr", city: "Austin", state: "TX", zip: 78754))
        self.people.append(Person(firstName: "Bell", lastName: "Beckham", age: 39,
            street: "B Beckingham Blvd", city: "London", state: "LA", zip: 78987))
        self.people.append(Person(firstName: "Cristiano", lastName: "Ronaldo", age: 32,
            street: "Cartin Ave", city: "Lisbon", state: "MN", zip: 76539))
        self.people.append(Person(firstName: "Dwayne", lastName: "Rooney", age: 31,
            street: "Duckess Ln", city: "Manchester", state: "NY", zip: 13746))
        self.people.append(Person(firstName: "Elibaba", lastName: "Mohamed", age: 40,
            street: "Eorty Robbers Blvd", city: "Bagdad", state: "IR", zip: 43340))
        self.people.append(Person(firstName: "Fionel", lastName: "Messi", age: 31,
            street: "FC Barca Club Dr", city: "Barcelona", state: "SP", zip: 13826))
        self.people.append(Person(firstName: "Ghost", lastName: "Murphy", age: 23,
            street: "Glabama Bovd", city: "Union", state: "VA", zip: 76129))
        self.people.append(Person(firstName: "Halex", lastName: "Ferguson", age: 74,
            street: "Houth Park Pl", city: "Glassgow", state: "SC", zip: 34982))
        self.people.append(Person(firstName: "Iliosch", lastName: "Kohler", age: 52,
            street: "Iortuna Ave", city: "New York", state: "AZ", zip: 32257))
        
    }
    
    @IBAction func btnSimpleAlert(sender: AnyObject) {
        
        var displayName = ""
        
        if let parent = sender.superview!!.superview as? NameTableViewCell {
            
            displayName = parent.firstNameLabel.text! + " " + parent.lastNameLabel.text!
         
        }
                
        self.alertController = UIAlertController(title: "Person", message:  "\(displayName)", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            print("Ok Button Pressed 1");
        }
        
        self.alertController!.addAction(okAction)

        self.presentViewController(self.alertController!, animated: true, completion:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: (NSIndexPath!)) -> CGFloat {
        
        // Toggle the cell height - alternating between rows.
        let cellSelector = indexPath.row % 2
        
        if cellSelector == 0 {
            return 50
        } else {
            return 55
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.people.count * 2
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let person = self.people[indexPath.row/2]
        
        let cellSelector = indexPath.row % 2
        
        if cellSelector == 0 {
            
            let cell:NameTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! NameTableViewCell
            
            cell.firstNameLabel.text = person.firstName
            
            cell.lastNameLabel.text = person.lastName
            
            var age = person.age
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! AddressTableViewCell
            
            cell.streetLabel.text = person.street
            
            cell.cityLabel.text = person.city
            
            cell.stateLabel.text = person.state
            
            cell.zipLabel.text = String(person.zip)
            
            return cell
            
        }
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}