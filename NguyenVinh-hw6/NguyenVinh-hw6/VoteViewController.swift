//
//  VoteViewController.swift
//  NguyenVinh-hw6
//
//  Created by Vinh Nguyen on 3/10/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class VoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellId:String = "voteCell"
    var tableView:UITableView = UITableView()
    var data:DataModel = DataModel()
    
    convenience init(title:String, data:DataModel, preferredContentSize:CGSize) {
        self.init()
        
        self.preferredContentSize = preferredContentSize
        self.title = title
        self.data = data
        
        self.modalPresentationStyle = UIModalPresentationStyle.Popover
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.frame         =   CGRectMake(0, 0, self.preferredContentSize.width, self.preferredContentSize.height);
        self.tableView.delegate      =   self
        self.tableView.dataSource    =   self
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
        
        self.view.addSubview(self.tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellId, forIndexPath: indexPath)
        
        // get data
        let index:Int = indexPath.row
        let candidate:Candidate = self.data.getCandidate(index: index)
        
        // set cell info
        cell.textLabel?.text = candidate.firstName + " " + candidate.lastName
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // get info
        let index = ["index":indexPath.row]

        NSNotificationCenter.defaultCenter().postNotificationName("voteNotificationKey", object: nil, userInfo: index)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
