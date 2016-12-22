//
//  Pictures.swift
//  NguyenVinh-hw4
//
//  Created by Vinh Nguyen on 2/23/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class Pictures: NSObject {
    
    private var list:[Picture] = [Picture]()
    
    override init() {
        super.init()
        // Populate the array
        self.populateList(4)
    }
    
    func populateList(startingId:Int) {
        var idToUse = startingId
        for i in 1...4{
            let imageFileName = "image" + String(i) + ".png"
            list.append(Picture(id:idToUse, image:UIImage(named:imageFileName)!))
            idToUse++
        }
    }
    
    func count() -> Int {
        return list.count
    }
    
    func getPicture(index index:Int) -> Picture {
        if index < list.count {
            return list[index]
        } else {
            return Picture(id:1, image:UIImage(named:"ClubsAce.png")!)
        }
    }
    
    func deletePicture(index index:Int) {
        if index < list.count {
            list.removeAtIndex(index)
        }
    }

}
