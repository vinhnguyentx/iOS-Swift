//
//  ViewController.swift
//  NguyenVinh-hw7
//
//  Created by Vinh Nguyen on 3/28/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, SkiAreaDataProtocol {
    
    var skiAreaData: SkiAreaData = SkiAreaData()

    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var returnLabel: UILabel!
    
    @IBAction func getAreaData(sender: AnyObject) {
        
        zipCodeTextField.endEditing(true)
        let zipcode:String = zipCodeTextField.text!
        if (zipcode != "") {
            skiAreaData.getData(zipcode)
        } else {
            returnLabel.text = "You need to input the zipcode"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        skiAreaData.delegate = self
        self.zipCodeTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

