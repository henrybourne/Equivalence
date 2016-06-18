//
//  UnitClassSamples.swift
//  Equivalence
//
//  Created by Henry Bourne on 15/03/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import Foundation

class Samples: UnitClass {
    var unitClassName:String
    var units:[Unit]
    
    init() {
        self.unitClassName = "Samples"
        self.units = [
            Unit(name: "22.05 kHz", scalar: 22050),
            Unit(name: "44.1 kHz",  scalar: 44100),
            Unit(name: "48 kHz",    scalar: 48000),
            Unit(name: "88.2 kHz",  scalar: 88200),
            Unit(name: "96 kHz",    scalar: 96000),
            Unit(name: "192 kHz",   scalar: 192000)
        ]
    }
    
    func convertToMilliseconds(input: Double, unitID: Int) -> Double {
        let output:Double = (input / self.units[unitID].scalar) * 1000.0
        return output
    }
    
    func convertFromMilliseconds(input: Double, unitID: Int) -> Double {
        let output:Double = (input / 1000.0) * self.units[unitID].scalar
        return output
    }
    
    func descriptionStringBefore(unitID: Int) -> String {
        return "The duration of"
    }
    
    func descriptionStringAfter(unitID: Int) -> String {
        return "Samples at a rate of \(self.units[unitID].name)"
    }
}