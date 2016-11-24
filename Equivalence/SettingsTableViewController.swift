//
//  SettingsTableViewController.swift
//  Equivalence
//
//  Created by Henry Bourne on 20/11/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var speedOfSoundTextField: UITextField!
    var converter:Converter?
   
//    init(converter:Converter) {
//        self.converter = converter
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        self.converter = Converter()
//        super.init(coder: aDecoder)
//    }

    override func viewDidLoad() {
        print("SettingsTableViewController viewDidLoad")
        super.viewDidLoad()
        self.navigationItem.title = "Settings"

        self.speedOfSoundTextField.delegate = self
        self.speedOfSoundTextField.text = "\((self.converter?.constants.speedOfSound)!)"
        
        let barButtonDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self.speedOfSoundTextField, action:#selector(UIResponder.resignFirstResponder))
        let barButtonFlexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let toolbar  = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        toolbar.items = [barButtonFlexibleSpace, barButtonDone]
        toolbar.tintColor = UIColor.black
        self.speedOfSoundTextField.inputAccessoryView = toolbar
    }
    
    @IBAction func speedOfSoundEditingDidEnd(_ sender: UITextField) {
        if (sender.text == "") {
            sender.text = "\(self.converter?.constants.speedOfSound)"
            self.converter?.constants.speedOfSound = (self.converter?.constants.speedOfSoundDefault)!
        } else {
            self.converter?.constants.speedOfSound = Double(sender.text!)!
        }
        self.converter?.convert()
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
        return 1
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsTableViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool
    {
        let newCharacters = CharacterSet(charactersIn: string)
        let boolIsNumber = CharacterSet.decimalDigits.isSuperset(of: newCharacters)
        if boolIsNumber == true {
            return true
        } else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy: ".").count - 1
                if countdots == 0 {
                    return true
                } else {
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            } else {
                return false
            }
        }
    }
    
}
