//
//  GlobalValues.swift
//  Equivalence
//
//  Created by Henry Bourne on 15/03/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import Foundation

class GlobalValues: NSObject {
    
    static let sharedInstance = GlobalValues()
    var speedOfSound:Double
    var speedOfSoundDefault:Double
    
    private override init() {
        self.speedOfSound = 343.2
        self.speedOfSoundDefault = 343.2
    }
}
