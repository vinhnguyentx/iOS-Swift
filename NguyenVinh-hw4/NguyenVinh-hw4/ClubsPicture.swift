//
//  Picture.swift
//  NguyenVinh-hw4
//
//  Created by Vinh Nguyen on 2/23/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class ClubsPicture: NSObject {
    
    private var id:Int = 0
    private var image:UIImage? = nil
    
    init(id:Int, image:UIImage?) {
        super.init()
        self.id = id
        self.image = image
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func getImage() -> UIImage? {
        return self.image
    }

}
