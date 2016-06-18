//
//  GlobalValues.swift
//  Equivalence
//
//  Created by Henry Bourne on 15/03/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import Foundation

class GlobalValues {
    static let sharedInstance = GlobalValues()
    var speedOfSound:Double
    
    private init() {
        self.speedOfSound = 343.2
    }
}