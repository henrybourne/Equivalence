//
//  UnitClassFrames.swift
//  Equivalence
//
//  Created by Henry Bourne on 15/03/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import Foundation

class Frames: UnitClass {
    var unitClassName:String
    var units:[Unit]
    
    init() {
        self.unitClassName = "Frames"
        self.units = [
            Unit(name: "23.98", scalar: 23.98),
            Unit(name: "24",    scalar: 24),
            Unit(name: "25",    scalar: 25),
            Unit(name: "29.97", scalar: 29.97),
            Unit(name: "30",    scalar: 30),
            Unit(name: "60",    scalar: 60),
            Unit(name: "120",   scalar: 120)
        ]
    }
    
    func convertToMilliseconds(_ input: Double, unitID: Int) -> Double {
        let output:Double = (input / self.units[unitID].scalar) * 1000.0
        return output
    }
    
    func convertFromMilliseconds(_ input: Double, unitID: Int) -> Double {
        let output:Double = (input / 1000.0) * self.units[unitID].scalar
        return output
    }
    
    func descriptionStringBefore(_ unitID: Int) -> String {
        return "The duration of"
    }
    
    func descriptionStringAfter(_ unitID: Int) -> String {
        return "Frames at a rate of \(self.units[unitID].name) fps"
    }
}
