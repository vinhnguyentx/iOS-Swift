//
//  Picture.swift
//  TestCollectionView
//
//  Created by Robert Seitsinger on 9/17/15.
//  Copyright © 2015 cs378. All rights reserved.
//

import UIKit

class Picture : NSObject {
 
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