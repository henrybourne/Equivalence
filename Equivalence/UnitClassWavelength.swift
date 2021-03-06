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
    var constants: Constants
    
    init(constants: Constants) {
        self.unitClassName = "Wavelength"
        self.units = [
            Unit(name: "Meters",        scalar: 1),
            Unit(name: "Centimeters",   scalar: 100),
            Unit(name: "Millimeters",   scalar: 1000),
            Unit(name: "Feet",          scalar: 3.2808),
            Unit(name: "Inches",        scalar: 39.370)
        ]
        self.constants = constants
    }
    
    func convertToMilliseconds(_ input: Double, unitID: Int) -> Double {
        let output:Double = (input / (self.constants.speedOfSound * self.units[unitID].scalar)) * 1000.0
        return output
    }
    
    func convertFromMilliseconds(_ input: Double, unitID: Int) -> Double {
        let output:Double = (self.constants.speedOfSound * self.units[unitID].scalar) * (input / 1000.0)
        return output
    }
    
    func descriptionStringBefore(_ unitID: Int) -> String {
        return "One cycle with a wavelength of"
    }
    
    func descriptionStringAfter(_ unitID: Int) -> String {
        return self.units[unitID].name
    }
}
