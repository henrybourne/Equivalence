//
//  UnitClassWavelength.swift
//  Equivalence
//
//  Created by Henry Bourne on 15/03/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import Foundation

class Wavelength: UnitClass {
    var unitClassName:String
    var units:[Unit]
    
    init() {
        self.unitClassName = "Wavelength"
        self.units = [
            Unit(name: "Meters",        scalar: 1),
            Unit(name: "Centimeters",   scalar: 100),
            Unit(name: "Millimeters",   scalar: 10000),
            Unit(name: "Feet",          scalar: 3.2808),
            Unit(name: "Inches",        scalar: 39.370)
        ]
    }
    
    func convertToMilliseconds(input: Double, unitID: Int) -> Double {
        let output:Double = (input / (GlobalValues.sharedInstance.speedOfSound * self.units[unitID].scalar)) * 1000.0
        return output
    }
    
    func convertFromMilliseconds(input: Double, unitID: Int) -> Double {
        let output:Double = (GlobalValues.sharedInstance.speedOfSound * self.units[unitID].scalar) * (input / 1000.0)
        return output
    }
    
    func descriptionStringBefore(unitID: Int) -> String {
        return "Sne cycle of a waveform with a wavelength of"
    }
    
    func descriptionStringAfter(unitID: Int) -> String {
        return self.units[unitID].name
    }
}