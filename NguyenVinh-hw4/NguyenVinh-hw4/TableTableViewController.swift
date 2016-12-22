//
//  TableTableViewController.swift
//  NguyenVinh-hw4
//
//  Created by Vinh Nguyen on 2/18/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Homework 4"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the indexPath for the table view cell that was selected
        let selectedIndexPath:NSIndexPath? = self.tableView!.indexPathForSelectedRow!
        var vc:UIViewController? = nil
        
        // Get the table view cell that was selected
        let cell:UITableViewCell! = self.tableView.cellForRowAtIndexPath(selectedIndexPath!)
        
        if segue.identifier == "Clubs" {
            vc = segue.destinationViewController as! CollectionViewController
//        } else if segue.identifier == "Diamonds" {
//            vc = segue.destinationViewController as! MyCustomScrollViewController
//        } else if segue.identifier == "Hearts" {
//            vc = segue.destinationViewController as! MyPagedScrollViewController
//        } else if segue.identifier == "Spades" {
//            vc = segue.destinationViewController as! MyPeekPagedScrollViewController
        }
        
        // Make sure we have a valid view controller before setting the navigation bar title.
        // We're just using the text that's in the table view cell.
        if let v = vc {
            // Set the navigation bar title to what was selected
            v.navigationItem.title = cell.textLabel!.text
        }

        
        
        
    }
    

}
