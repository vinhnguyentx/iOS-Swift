//
//  CandidateDetailViewController.swift
//  NguyenVinh-hw6
//
//  Created by Vinh Nguyen on 3/10/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class CandidateDetailViewController: UIViewController {
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var party: UILabel!
    @IBOutlet weak var vote: UILabel!
    

    var candidate:Candidate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Candidate Detail"
        self.navigationItem.leftBarButtonItem?.title = "Back"
        displayInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayInfo() {
        firstName.text = candidate!.firstName
        lastName.text = candidate!.lastName
        state.text = candidate!.state
        party.text = candidate!.party
        vote.text = String(candidate!.vote)
    }
    

}
