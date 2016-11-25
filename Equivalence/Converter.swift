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

class Converter: NSObject, NSCoding {
    var unitClasses:[UnitClass]
    
    var constants:Constants
    
    var sourceUnitClassID:Int
    var sourceUnitID:Int
    var sourceValue:Double = 0
    var sourceValueString:String = "0"
    
    var destinationUnitClassID:Int
    var destinationUnitID:Int
    var destinationValue:Double = 0
    var destinationValueString:String = "0"
    
    override init() {
        self.constants = Constants()
        
        unitClasses = [
            Frames(),
            Frequency(),
            Samples(),
            Time(),
            Wavelength(constants: self.constants)
        ]
        self.sourceUnitClassID = 1
        self.sourceUnitID = 0
        
        self.destinationUnitClassID = 4
        self.destinationUnitID = 0
        
        super.init()
        
        convert()
    }
    
    func selectUnit(target:ConverterUnitTarget, unitClassID:Int, unitID:Int) -> Void
    {
        if (target == ConverterUnitTarget.source)
        {
            self.sourceUnitClassID = unitClassID
            self.sourceUnitID = unitID
        }
        else
        {
            self.destinationUnitClassID = unitClassID
            self.destinationUnitID = unitID
        }
        convert()
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
        let sourceInMS: Double = self.unitClasses[self.sourceUnitClassID].convertToMilliseconds(self.sourceValue, unitID: self.sourceUnitID)
        self.destinationValue = self.unitClasses[self.destinationUnitClassID].convertFromMilliseconds(sourceInMS, unitID: self.destinationUnitID)
        self.destinationValueString = self.stringFromNumber(self.destinationValue)
        
    }
    
    func swap() -> Void {
 
        self.sourceValue = 0
        self.destinationValue = 0
        self.sourceValueString = self.stringFromNumber(self.sourceValue)
        self.destinationValueString = self.stringFromNumber(self.destinationValue)
        
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
        return self.unitClasses[self.sourceUnitClassID].descriptionStringBefore(self.sourceUnitID)
    }
    func sourceDescriptionStringAfter() -> String
    {
        return self.unitClasses[self.sourceUnitClassID].descriptionStringAfter(self.sourceUnitID)
    }
    func destinationDescriptionStringBefore() -> String
    {
        return self.unitClasses[self.destinationUnitClassID].descriptionStringBefore(self.destinationUnitID)
    }
    func destinationDescriptionStringAfter() -> String
    {
        return self.unitClasses[self.destinationUnitClassID].descriptionStringAfter(self.destinationUnitID)
    }
    
    //MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        // Constants
        aCoder.encode(self.constants, forKey: "constants")
        // Source
        aCoder.encode(self.sourceUnitClassID, forKey: "sourceUnitClassID")
        aCoder.encode(self.sourceUnitID, forKey: "sourceUnitID")
        aCoder.encode(self.sourceValue, forKey: "sourceValue")
        // Destination
        aCoder.encode(self.destinationUnitClassID, forKey: "destinationUnitClassID")
        aCoder.encode(self.destinationUnitID, forKey: "destinationUnitID")
        aCoder.encode(self.destinationValue, forKey: "destinationValue")
        

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        // Constants
        self.constants = aDecoder.decodeObject(forKey: "constants") as! Constants
        // Source
        self.sourceUnitClassID      = aDecoder.decodeInteger(forKey: "sourceUnitClassID")
        self.sourceUnitID           = aDecoder.decodeInteger(forKey: "sourceUnitID")
        self.sourceValue            = aDecoder.decodeDouble(forKey: "sourceValue")
        // Destination
        self.destinationUnitClassID = aDecoder.decodeInteger(forKey: "destinationUnitClassID")
        self.destinationUnitID      = aDecoder.decodeInteger(forKey: "destinationUnitID")
        self.destinationValue       = aDecoder.decodeDouble(forKey: "destinationValue")
        // Unit Classes
        self.unitClasses = [
            Frames(),
            Frequency(),
            Samples(),
            Time(),
            Wavelength(constants: self.constants)
        ]
        convert()
        self.sourceValueString = self.stringFromNumber(self.sourceValue)
    }
    
}




