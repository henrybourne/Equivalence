//
//  UnitClassFrequency.swift
//  Equivalence
//
//  Created by Henry Bourne on 15/03/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import Foundation

class Frequency: UnitClass {
    var unitClassName:String
    var units:[Unit]
    
    init() {
        self.unitClassName = "Frequency"
        self.units = [
            Unit(name: "Hz",    scalar: 1),
            Unit(name: "kHz",   scalar: 0.001)
        ]
    }
    
    func convertToMilliseconds(_ input: Double, unitID: Int) -> Double {
        let output:Double = (1000.0 / input) * self.units[unitID].scalar
        return output
    }
    
    func convertFromMilliseconds(_ input: Double, unitID: Int) -> Double {
        let output:Double = (input / 1000.0) * self.units[unitID].scalar
        return output
    }
    
    func descriptionStringBefore(_ unitID: Int) -> String {
        return "One cycle with frequency of"
    }
    
    func descriptionStringAfter(_ unitID: Int) -> String {
        return self.units[unitID].name
    }
}
