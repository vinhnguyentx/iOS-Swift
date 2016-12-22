//
//  ShowCandiatesTableViewController.swift
//  NguyenVinh-hw5
//
//  Created by Vinh Nguyen on 2/29/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit
import CoreData

class ShowCandiatesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Show Candidates"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        return 1
        
    }

 

}
