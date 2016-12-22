//
//  TableViewCell.swift
//  TestMultiTableViewCells
//
//  Created by Vinh Nguyen on 2/8/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label1: UILabel!

    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
