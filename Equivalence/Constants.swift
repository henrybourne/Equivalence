//
//  Constants.swift
//  Equivalence
//
//  Created by Henry Bourne on 22/11/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import Foundation

class Constants: NSObject, NSCoding {
    var speedOfSound: Double
    let speedOfSoundDefault: Double
    
    override init() {
        self.speedOfSoundDefault = 343.2
        self.speedOfSound = self.speedOfSoundDefault
        super.init()
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.speedOfSound, forKey: "speedOfSound")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.speedOfSound = aDecoder.decodeDouble(forKey: "speedOfSound")
    }
}
