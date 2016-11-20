//
//  Converter.swift
//  Equivalence
//
//  Created by Henry Bourne on 15/03/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import Foundation

enum ConverterUnitTarget {
    case source
    case destination
}

class Converter {
    let unitClasses:[UnitClass]
    
    var sourceUnitClass:UnitClass
    var sourceUnitClassID:Int
    var sourceUnit:Unit
    var sourceUnitID:Int
    var sourceValue:Double = 0
    var sourceValueString:String = "0"
    
    var destinationUnitClass:UnitClass
    var destinationUnitClassID:Int
    var destinationUnit:Unit
    var destinationUnitID:Int
    var destinationValue:Double = 0
    var destinationValueString:String = "0"
    
    init() {
        unitClasses = [
            Frames(),
            Frequency(),
            Samples(),
            Time(),
            Wavelength()
        ]
        self.sourceUnitClassID = 2
        self.sourceUnitID = 2
        self.sourceUnitClass = self.unitClasses[self.sourceUnitClassID]
        self.sourceUnit = self.sourceUnitClass.getUnit(sourceUnitID)
        
        self.destinationUnitClassID = 3
        self.destinationUnitID = 1
        self.destinationUnitClass = self.unitClasses[destinationUnitClassID]
        self.destinationUnit = self.sourceUnitClass.getUnit(destinationUnitID)
        
        
        convert()
    }
    
    func selectUnit(target:ConverterUnitTarget, unitClassID:Int, unitID:Int) -> Void
    {
        if (target == ConverterUnitTarget.source)
        {
            self.sourceUnitClassID = unitClassID
            self.sourceUnitID = unitID
            self.sourceUnitClass = self.unitClasses[self.sourceUnitClassID]
            self.sourceUnit = self.sourceUnitClass.getUnit(self.sourceUnitID)
        }
        else
        {
            self.destinationUnitClassID = unitClassID
            self.destinationUnitID = unitID
            self.destinationUnitClass = self.unitClasses[self.destinationUnitClassID]
            self.destinationUnit = self.destinationUnitClass.getUnit(self.destinationUnitID)

        }
        convert()
        print("--- New Unit Selected")
        print(self.sourceUnit.name)
        print(self.destinationUnit.name)
    }
    
    func numberOfUnitClasses() -> Int
    {
        return unitClasses.count
    }
    
    func nameOfUnitClass(atIndex:Int) -> String
    {
        if (atIndex < 0 || atIndex >= self.unitClasses.count)
        {
            return "Unit Class Out of Bounds"
        }
        else
        {
            return unitClasses[atIndex].unitClassName
        }
    }
    
    func numberOfUnitsInClass(atIndex:Int) -> Int
    {
        if (atIndex < 0 || atIndex >= self.unitClasses.count)
        {
            return 0
        }
        else
        {
            return unitClasses[atIndex].units.count
        }
    }
    
    func nameOfUnit(atIndex atUnitIndex:Int, atClassIndex:Int) -> String
    {
        if (atClassIndex < 0 || atClassIndex >= self.unitClasses.count)
        {
            return "Unit Class Out of Bounds"
        }
        else
        {
            if (atUnitIndex < 0 || atClassIndex >= unitClasses[atClassIndex].units.count)
            {
                return "Unit Out of Bounds"
            }
            else
            {
                return unitClasses[atClassIndex].units[atUnitIndex].name
            }
        }
    }
    
    func convert() -> Void {
        let sourceInMS: Double = self.sourceUnitClass.convertToMilliseconds(self.sourceValue, unitID: self.sourceUnitID)
        self.destinationValue = self.destinationUnitClass.convertFromMilliseconds(sourceInMS, unitID: self.destinationUnitID)
        self.destinationValueString = self.stringFromNumber(self.destinationValue)
        
    }
    
    func swap() -> Void {
//        let newDestinationValue: Double = self.sourceValue
//        self.sourceValue = self.destinationValue
//        self.destinationValue = newDestinationValue
//        
//        let newDestinationValueString: String = self.sourceValueString
//        self.sourceValueString = self.destinationValueString
//        self.destinationValueString = newDestinationValueString
 
        self.sourceValue = 0
        self.destinationValue = 0
        self.sourceValueString = self.stringFromNumber(self.sourceValue)
        self.destinationValueString = self.stringFromNumber(self.destinationValue)
        
        let newDestinationUnit: Unit = self.sourceUnit
        self.sourceUnit = self.destinationUnit
        self.destinationUnit = newDestinationUnit
        
        let newDestinationUnitClass:UnitClass = self.sourceUnitClass
        self.sourceUnitClass = self.destinationUnitClass
        self.destinationUnitClass = newDestinationUnitClass
        
        let newDestinationUnitClassID: Int = self.sourceUnitClassID
        self.sourceUnitClassID = self.destinationUnitClassID
        self.destinationUnitClassID = newDestinationUnitClassID
        
        let newDestinationUnitID: Int = self.sourceUnitID
        self.sourceUnitID = self.destinationUnitID
        self.destinationUnitID = newDestinationUnitID
    }
    
    // Has problems if the source string contains "xxxe-x" 
    // Removed backspace button, and replaced with clear button, so this is not called.
    func deleteCharacter() {
        if (self.sourceValueString != "0") {
            if (self.sourceValueString.characters.count <= 1) {
                self.sourceValueString = "0"
            } else {
                var newSource: String = self.sourceValueString
                newSource.remove(at: newSource.index(newSource.endIndex, offsetBy: -1))
                if (newSource[newSource.index(newSource.endIndex, offsetBy: -1)] == ".") {
                    newSource.remove(at: newSource.index(newSource.endIndex, offsetBy: -1))
                }
                self.sourceValueString = newSource
            }
            self.sourceValue = Double(self.sourceValueString)!
            self.convert()
        }
    }
    
    func clear() {
        self.sourceValue = 0
        self.sourceValueString = "0"
        self.convert()
    }
    
    func addNumber(_ number: String) {
        if (self.sourceValueString == "0") {
            self.sourceValueString = ""
        }
        if (self.sourceValueString.characters.count < 20) {
            self.sourceValueString += number
            self.sourceValue = Double(self.sourceValueString)!
            self.convert()
        }
    }
    
    func addDecimal() {
        if (self.sourceValueString.range(of: ".") == nil) {
            if (self.sourceValueString.characters.count < 20) {
                self.sourceValueString += "."
                self.sourceValue = Double(self.sourceValueString)!
                self.convert()
            }
        }
    }
    
    func stringFromNumber(_ number: Double) -> String {
        var newString: String = "\(number)"
        let range:Range? = newString.range(of: ".0")
        if (range != nil) {
            if (range?.upperBound == newString.endIndex) {
                newString.removeSubrange(range!)
            }
        }
        if (newString == "inf")
        {
            newString = "0"
        }
        return newString
    }
    
    // MARK: - Labels
    func sourceDescriptionStringBefore() -> String
    {
        return sourceUnitClass.descriptionStringBefore(self.sourceUnitID)
    }
    func sourceDescriptionStringAfter() -> String
    {
        return sourceUnitClass.descriptionStringAfter(self.sourceUnitID)
    }
    func destinationDescriptionStringBefore() -> String
    {
        return destinationUnitClass.descriptionStringBefore(self.destinationUnitID)
    }
    func destinationDescriptionStringAfter() -> String
    {
        return destinationUnitClass.descriptionStringAfter(self.destinationUnitID)
    }
    
}




