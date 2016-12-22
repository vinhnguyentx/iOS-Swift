//
//  SkiAreaDataProtocol.swift
//  NguyenVinh-hw7
//
//  Created by Vinh Nguyen on 3/28/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import Foundation

protocol SkiAreaDataProtocol {
    
    func responseDataHandler(data: NSDictionary)
    
    func responseError(message: String)
}