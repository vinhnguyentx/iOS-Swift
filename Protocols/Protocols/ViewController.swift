//
//  ViewController.swift
//  Protocols
//
//  Created by Vinh Nguyen on 2/24/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var delegate:MyProtocol? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        self.delegate = (segue.destinationViewController as? MyViewController)!
        
    }

    @IBAction func btnAction(sender: AnyObject) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            
            sleep(3)
            
            self.delegate?.callMe()
        }
        
    }
}

