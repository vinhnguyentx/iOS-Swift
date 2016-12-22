//
//  ViewController.swift
//  AnimationApp
//
//  Created by Vinh Nguyen on 2/29/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.lblText.frame = CGRect(x:self.lblText.frame.origin.x, y:0, width:self.lblText.frame.size.width, height:self.lblText.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnAction(sender: AnyObject) {
        
        UIView.animateWithDuration(1.0, delay: 0, options: .CurveLinear, animations: {
            self.lblText.frame.origin.y += 100.0;
            },
            completion:nil)
    }

}

