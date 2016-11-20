//
//  UnitClassTime.swift
//  Equivalence
//
//  Created by Henry Bourne on 15/03/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import Foundation

class Time: UnitClass {
    var unitClassName:String
    var units:[Unit]
    
    init() {
        self.unitClassName = "Time"
        self.units = [
            Unit(name: "Microseconds",  scalar: 1000),
            Unit(name: "Milliseconds",  scalar: 1),
            Unit(name: "Seconds",       scalar: 0.001),
            Unit(name: "Minutes",       scalar: 0.001/60),
            Unit(name: "Hours",         scalar: 0.001/360)
        ]
    }
    
    func convertToMilliseconds(_ input: Double, unitID: Int) -> Double {
        let output:Double = input / self.units[unitID].scalar
        return output
    }
    
    func convertFromMilliseconds(_ input: Double, unitID: Int) -> Double {
        let output:Double = input * self.units[unitID].scalar
        return output
    }
    
    func descriptionStringBefore(_ unitID: Int) -> String {
        return "A duration of"
    }
    
    func descriptionStringAfter(_ unitID: Int) -> String {
        return self.units[unitID].name
    }
}
