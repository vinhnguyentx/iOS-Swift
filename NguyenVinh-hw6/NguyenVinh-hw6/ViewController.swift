//
//  ViewController.swift
//  NguyenVinh-hw6
//
//  Created by Vinh Nguyen on 3/10/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var votePopover: UIButton!
    
    @IBOutlet weak var showVotePopover: UIButton!
    
    @IBAction func voteAction(sender: AnyObject) {
        
        let popoverVoteController = PopoverVoteViewController(data: data)
        
        popoverVoteController.presentVotePopover(sourceController: self, sourceView: self.votePopover, sourceRect: self.votePopover.bounds)
    }
    
    @IBAction func shoeVoteAction(sender: AnyObject) {
        
        let popoverVoteController = PopoverVoteViewController(data: data)
        
        popoverVoteController.presentShowVotesPopover(sourceController: self, sourceView: self.showVotePopover, sourceRect: self.showVotePopover.bounds)
    }
    
    var data:DataModel = DataModel()
    
    var delegate:DataModelProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Candidate Manager"
        
        // Add Observer for 'add Candidates' and 'vote'
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addCandidateNotificationHandler:", name: "addCandidateNotificationKey", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "voteNotificationHandler:", name: "voteNotificationKey", object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        
        if (segue.identifier == "segueAddCandidate" ) {
            // set delegate
            self.delegate = (segue.destinationViewController as? AddCandidateViewController)!
            
            // change view to subview
            let view = segue.destinationViewController as! AddCandidateViewController
            view.rootView = self
            
        } else if (segue.identifier == "segueCandidateDetail") {
            
            let showCandidates = segue.destinationViewController as! ShowCandidatesTableViewController
            
            showCandidates.data = data
            
        }
    }
    
    // handler for 'add candidate' notification
    func addCandidateNotificationHandler(notification: NSNotification) {
        let candidate:Dictionary<String, String> = notification.userInfo as! Dictionary<String, String>
        
        data.addCandidate(firstName: candidate["firstName"]!, lastName: candidate["lastName"]!, state: candidate["state"]!, party: candidate["party"]!)
    }
    
    // handler for 'vote' notification
    func voteNotificationHandler(notification: NSNotification) {
        let dict:Dictionary<String, Int> = notification.userInfo as! Dictionary<String, Int>
        let candidate:Candidate = data.getCandidate(index: dict["index"]!)
        candidate.addVote()
    }
    
    func addCandidateNotify() {
        
        self.delegate?.notify("Data has been saved!")
    }



}

