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
    var unitTapped: ConverterUnitTarget = ConverterUnitTarget.source
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Unarchive Converter data if available
        let defaults = UserDefaults.standard
        if let savedConverter = defaults.object(forKey: "converter") as? Data {
            self.converter = NSKeyedUnarchiver.unarchiveObject(with: savedConverter) as! Converter
        }
        
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.barTintColor = UIColor(red:0.929, green:0.929, blue:0.929, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        self.updateLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateLabels()
        self.saveData()
    }
    
    @IBAction func numberTapped(_ sender: UIButton) {
        let buttonText: String = sender.titleLabel!.text!

        let labelText = self.sourceUnitView.valueLabel.text! + String("0")
        let textSize = (labelText as NSString).size(attributes: [NSFontAttributeName: self.sourceUnitView.valueLabel.font]);
        
        if (textSize.width < self.sourceUnitView.valueLabel.bounds.width) {
            self.converter.addNumber(buttonText)
            self.updateLabels()
        } else {
            print("Input Full")
        }
    }
    
    @IBAction func decimalTapped(_ sender: UIButton) {
        self.converter.addDecimal()
        self.updateLabels()
    }

    @IBAction func clearTapped(_ sender: UIButton) {
        self.converter.clear()
        self.updateLabels()
    }
    
    @IBAction func backspaceTapped(_ sender: UIButton) {
        self.converter.deleteCharacter()
        self.updateLabels()
    }
    
    @IBAction func swapTapped(_ sender: UIBarButtonItem) {
        self.converter.swap()
        self.updateLabels()
    }
    
    @IBAction func sourceTapped(_ sender: UnitView) {
        self.unitTapped = ConverterUnitTarget.source
        performSegue(withIdentifier: "showUnitClassPicker", sender: self)
    }
    
    @IBAction func destinationTapped(_ sender: UnitView) {
        self.unitTapped = ConverterUnitTarget.destination
        performSegue(withIdentifier: "showUnitClassPicker", sender: self)
    }
    
    func updateLabels() -> Void {
        self.sourceUnitView.beforeLabel.text = converter.sourceDescriptionStringBefore()
        self.sourceUnitView.afterLabel.text = converter.sourceDescriptionStringAfter()
        self.sourceUnitView.valueLabel.text = converter.sourceValueString
        
        self.destinationUnitView.beforeLabel.text = converter.destinationDescriptionStringBefore()
        self.destinationUnitView.afterLabel.text = converter.destinationDescriptionStringAfter()
        self.destinationUnitView.valueLabel.text = converter.destinationValueString
    }
    
    func saveData() {
        let savedConverter = NSKeyedArchiver.archivedData(withRootObject: self.converter)
        let defaults = UserDefaults.standard
        defaults.set(savedConverter, forKey: "converter")
    }
    
    // MARK: Segues
    
//    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
//
//    }
    
    @IBAction func unwindToConverter(_ segue: UIStoryboardSegue) {
        self.updateLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showUnitClassPicker") {
            self.unitClassPickerTableViewController = (segue.destination as! UnitClassPickerTableViewController)
            self.unitClassPickerTableViewController!.converter = self.converter
            self.unitClassPickerTableViewController!.unitTarget = self.unitTapped
            if (self.unitTapped == ConverterUnitTarget.source)
            {
                self.unitClassPickerTableViewController!.currentUnitClassID = self.converter.sourceUnitClassID
                self.unitClassPickerTableViewController!.currentUnitID = self.converter.sourceUnitID
            }
            else if (self.unitTapped == ConverterUnitTarget.destination)
            {
                self.unitClassPickerTableViewController!.currentUnitClassID = self.converter.destinationUnitClassID
                self.unitClassPickerTableViewController!.currentUnitID = self.converter.destinationUnitID
            }
        } else if (segue.identifier == "showSettings") {
            let settingsViewController = (segue.destination as! SettingsTableViewController)
            settingsViewController.converter = self.converter
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

