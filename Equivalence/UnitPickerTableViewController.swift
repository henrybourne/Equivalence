//
//  UnitPickerTableViewController.swift
//  Equivalence
//
//  Created by Henry Bourne on 21/05/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import UIKit

class UnitPickerTableViewController: UITableViewController {
    var converter: Converter?
    var unitTarget: ConverterUnitTarget = ConverterUnitTarget.Source
    var unitClassIndex: Int = 0
    var currentUnitID: Int = 0

    override func viewDidLoad() {
        print("UnitPickerViewController viewDidLoad")
        super.viewDidLoad()
        
        //self.tableView.delegate = self
        
        if (self.unitTarget == ConverterUnitTarget.Source) {
            print("Source Picker")
            self.navigationItem.title = "Source Units"
        } else {
            print("Destination Picker")
            self.navigationItem.title = "Destination Units"
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        //self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.converter?.numberOfUnitsInClass(atIndex: self.unitClassIndex))!
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UnitCell", forIndexPath: indexPath)

        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.text = self.converter?.nameOfUnit(atIndex: indexPath.row, atClassIndex: self.unitClassIndex)
        //cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        if (self.currentUnitID == indexPath.row)
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Selection
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.converter?.selectUnit(target: self.unitTarget, unitClassID: self.unitClassIndex, unitID: indexPath.row)
        self.performSegueWithIdentifier("unwindToConverter", sender: self)
    }

}
