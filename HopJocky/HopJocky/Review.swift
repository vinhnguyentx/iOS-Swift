//
//  Review.swift
//  HopJocky
//
//  Created by Matt Union on 4/7/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import Foundation

class Review{
    private var Author = ""
    private var Summary = ""
    private var Review = ""
    private var Rating = 0.0
    
    var author: String {
        return self.Author
    }
    
    var summary: String{
        return self.Summary
    }
    
    var review: String {
        return self.Review
    }
    
    var rating: Double{
        return self.Rating
    }
    
    //initilize bar
    init(author: String, summary: String, review: String, rating: Double){
        self.Author = author
        self.Summary = summary
        self.Review = review
        self.Rating = rating
    }
    
}
