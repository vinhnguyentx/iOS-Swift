//
//  TableViewController.swift
//  TestMultiTableViewCells
//
//  Created by Vinh Nguyen on 2/8/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var people:[Person] = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Custom Table View Cell App"
        
        self.loadDataModel()
    }
    
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    func loadDataModel() {

        
        self.people.append(Person(firstName: "Vinh", lastName: "Nguyen", age: 33))
        self.people.append(Person(firstName: "Linh", lastName: "Mach", age: 33))
        self.people.append(Person(firstName: "Kaden", lastName: "Nguyen", age: 4))
        self.people.append(Person(firstName: "Joe", lastName: "Smauss", age: 15))
        self.people.append(Person(firstName: "Anne", lastName: "Smith", age: 45))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.people.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! TableViewCell

        // Configure the cell...
                
        let person = self.people[indexPath.row]
        
        cell.label1.text = person.firstName
        
        cell.label2.text = person.lastName

        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
