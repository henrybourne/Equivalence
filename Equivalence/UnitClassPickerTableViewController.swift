//
//  UnitPickerTableViewController.swift
//  Equivalence
//
//  Created by Henry Bourne on 21/05/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import UIKit

class UnitClassPickerTableViewController: UITableViewController {
    var unitPickerTableViewController: UnitPickerTableViewController?
    var converter: Converter?
    var unitTarget: ConverterUnitTarget = ConverterUnitTarget.source
    var currentUnitClassID: Int = -1
    var currentUnitID: Int = -1

    override func viewDidLoad() {
        print("UnitClassPickerViewController viewDidLoad")
        super.viewDidLoad()
        
        //self.tableView.delegate = self
        
        if (self.unitTarget == ConverterUnitTarget.source) {
            print("Source Picker")
            self.navigationItem.title = "Source Unit Classes"
        } else {
            print("Destination Picker")
            self.navigationItem.title = "Destination Unit Classes"
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        //self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorColor = UIColor.clear
        self.tableView.tableFooterView = UIView(frame:CGRect.zero)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.converter?.numberOfUnitClasses())!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UnitClassCell", for: indexPath)

        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = self.converter?.nameOfUnitClass(atIndex: (indexPath as NSIndexPath).row)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        if (self.currentUnitClassID == (indexPath as NSIndexPath).row)
        {
            cell.backgroundColor = UIColor(red:0.9, green:0.9, blue:0.9, alpha: 1)
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("UnitClassPickerTaleViewController prepareForSegue")
        if (segue.identifier == "showUnitPicker") {
            print("\tshowUnitPicker")
            self.unitPickerTableViewController = (segue.destination as! UnitPickerTableViewController)
            self.unitPickerTableViewController!.converter = self.converter
            self.unitPickerTableViewController!.unitTarget = self.unitTarget
            self.unitPickerTableViewController!.unitClassIndex = ((tableView.indexPathForSelectedRow as NSIndexPath?)?.row)!
            if (self.currentUnitClassID == ((tableView.indexPathForSelectedRow as NSIndexPath?)?.row)!)
            {
                self.unitPickerTableViewController!.currentUnitID = self.currentUnitID
            }
            else
            {
                self.unitPickerTableViewController!.currentUnitID = -1
            }
        }
    }

}
