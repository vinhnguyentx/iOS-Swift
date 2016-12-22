//
//  ShowCandidatesTableViewController.swift
//  NguyenVinh-hw6
//
//  Created by Vinh Nguyen on 3/10/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class ShowCandidatesTableViewController: UITableViewController {

    var data:DataModel = DataModel()
    var reuseIdentifier:String = "cellCandidate"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.navigationItem.title = "Show Candidates"
        let back = UIBarButtonItem(title: "Back", style: .Bordered, target: nil, action: nil)
        navigationItem.backBarButtonItem = back
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return data.count()
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellCandidate", forIndexPath: indexPath)
        
        // get data
        let index:Int = indexPath.row
        let temp:Candidate = data.getCandidate(index: index)
        
        // configure cell
        cell.textLabel!.text = temp.firstName + " " + temp.lastName
        cell.detailTextLabel!.text = temp.party
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "showDetail") {
            
            let indexPath:NSIndexPath = self.tableView!.indexPathForSelectedRow!
            let detailView:CandidateDetailViewController = segue.destinationViewController as! CandidateDetailViewController
            
            detailView.candidate = data.getCandidate(index: indexPath.row)
        }
    }

}
