//
//  EquivalenceViewController.swift
//  Equivalence
//
//  Created by Henry Bourne on 13/03/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import UIKit

class EquivalenceViewController: UIViewController {
    
    @IBOutlet weak var sourceUnitView: UnitView!
    @IBOutlet weak var destinationUnitView: UnitView!
    var converter: Converter = Converter()
    var unitClassPickerTableViewController: UnitClassPickerTableViewController?
    var unitTapped: ConverterUnitTarget = ConverterUnitTarget.Source
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBar.barTintColor = UIColor(red:0.929, green:0.929, blue:0.929, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        self.updateLabels()
    }
    
    @IBAction func numberTapped(sender: UIButton) {
        let buttonText: String = sender.titleLabel!.text!
        self.converter.addNumber(buttonText)
        self.updateLabels()
    }
    
    @IBAction func decimalTapped(sender: UIButton) {
        self.converter.addDecimal()
        self.updateLabels()
    }

    @IBAction func clearTapped(sender: UIButton) {
        self.converter.clear()
        self.updateLabels()
    }
    
    @IBAction func backspaceTapped(sender: UIButton) {
        self.converter.deleteCharacter()
        self.updateLabels()
    }
    
    @IBAction func swapTapped(sender: UIBarButtonItem) {
        print("swapTapped")
        self.converter.swap()
        self.updateLabels()
    }
    
    @IBAction func sourceTapped(sender: UnitView) {
        print("sourceTapped")
        self.unitTapped = ConverterUnitTarget.Source
        performSegueWithIdentifier("showUnitClassPicker", sender: self)
    }
    
    @IBAction func destinationTapped(sender: UnitView) {
        print("destinationTapped")
        self.unitTapped = ConverterUnitTarget.Destination
        performSegueWithIdentifier("showUnitClassPicker", sender: self)
    }
    
//    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
//        <#code#>
//    }
    
    @IBAction func unwindToConverter(segue: UIStoryboardSegue) {
        print("\(#function)")
        print(self.converter.sourceUnit.name)
        print(self.converter.destinationUnit.name)
        self.updateLabels()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("EquivalenceViewController prepareForSegue")
        if (segue.identifier == "showUnitClassPicker") {
            print("\tshowUnitClassPicker")
            self.unitClassPickerTableViewController = (segue.destinationViewController as! UnitClassPickerTableViewController)
            self.unitClassPickerTableViewController!.converter = self.converter
            self.unitClassPickerTableViewController!.unitTarget = self.unitTapped
            if (self.unitTapped == ConverterUnitTarget.Source)
            {
                self.unitClassPickerTableViewController!.currentUnitClassID = self.converter.sourceUnitClassID
                self.unitClassPickerTableViewController!.currentUnitID = self.converter.sourceUnitID
            }
            else if (self.unitTapped == ConverterUnitTarget.Destination)
            {
                self.unitClassPickerTableViewController!.currentUnitClassID = self.converter.destinationUnitClassID
                self.unitClassPickerTableViewController!.currentUnitID = self.converter.destinationUnitID
            }
        }
    }
    
    
    func updateLabels() -> Void {
        self.sourceUnitView.beforeLabel.text = converter.sourceDescriptionStringBefore()
        self.sourceUnitView.afterLabel.text = converter.sourceDescriptionStringAfter()
        self.sourceUnitView.valueLabel.text = converter.sourceValueString
        
        self.destinationUnitView.beforeLabel.text = converter.destinationDescriptionStringBefore()
        self.destinationUnitView.afterLabel.text = converter.destinationDescriptionStringAfter()
        self.destinationUnitView.valueLabel.text = converter.destinationValueString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

