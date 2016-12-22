//
//  Pictures.swift
//  TestCollectionView
//
//  Created by Robert Seitsinger on 9/17/15.
//  Copyright © 2015 cs378. All rights reserved.
//

import UIKit

class Pictures: NSObject {
    private var list:[Picture] = [Picture]()
    
    override init() {
        super.init()
        // Populate the array
        self.populateList(1)
        self.populateList(11)
        self.populateList(21)
    }
    
    func populateList(startingId:Int) {
        var idToUse = startingId
        for i in 1...10 {
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
            return Picture(id:1, image:UIImage(named:"image1.png")!)
        }
    }
    
    func deletePicture(index index:Int) {
        if index < list.count {
            list.removeAtIndex(index)
        }
    }
}
