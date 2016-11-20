//
//  UnitClass.swift
//  Equivalence
//
//  Created by Henry Bourne on 15/03/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import Foundation

protocol UnitClass: class
{
    var unitClassName:String {get}
    var units:[Unit] {get}
    
    func convertToMilliseconds(_ input: Double, unitID: Int) -> Double
    func convertFromMilliseconds(_ input: Double, unitID: Int) -> Double
    func descriptionStringBefore(_ unitID: Int) -> String
    func descriptionStringAfter(_ unitID: Int) -> String
    
    func getUnit(_ unitID: Int) -> Unit
    func getUnitName(_ unitID: Int) -> String
}


// Extend the protocol to provide some default function implementations, so that I don't have to rewrite the implementation in each class.
extension UnitClass
{
    func getUnit(_ unitID: Int) -> Unit
    {
        if (unitID >= units.count)
        {
            return self.units[units.count-1]
        }
        else if (unitID < 0)
        {
            return self.units[0]
        }
        else
        {
            return self.units[unitID]
        }
    }
    
    func getUnitName(_ unitID: Int) -> String
    {
        return self.units[unitID].name
    }
}
