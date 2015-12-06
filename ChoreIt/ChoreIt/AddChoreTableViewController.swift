//
//  AddChoreViewController.swift
//  ChoreIt
//
//  Created by Lucy Xiao on 12/5/15.
//  Copyright © 2015 Lucy Xiao. All rights reserved.
//

import Foundation
import UIKit

class AddChoreTableViewController: UITableViewController {
    var chore: Chore?
    var designee: String?
    var listOfUsers: [User?]!
    var choreTable: ChoreListTableViewController!
    var delegateAndSource: PickerViewDelegateAndSource!
    
    @IBOutlet var addChoreTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var wheelOfMisfortune: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wheelOfMisfortune.dataSource = delegateAndSource
        wheelOfMisfortune.delegate = delegateAndSource
        
        /*if listOfUsers != nil && listOfUsers!.count != 0 {
            designee = listOfUsers[0]!.username
        } else {
            if listOfUsers!.count != 0 {
                wheelOfMisfortune.selectedRowInComponent((listOfUsers!.count - 1)/2)
            }
        }*/
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            addChoreTextField.becomeFirstResponder()
        } /*else if indexPath.section == 0 && indexPath.row == 1 {
            addDesigneeTextField.becomeFirstResponder()
        }*/
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func pressedSaveButton() {
        print("Pressed Save Button")
        if (addChoreTextField.text!.characters.count > 0){
            /*if (addDesigneeTextField.text!.characters.count == 0) {
                print("In here")
                let alertController = UIAlertController(title: "Invalid designee", message: "Who's responsible for this chore?", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "😱", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {*/
            //chore = Chore(choreName: addChoreTextField.text!, username: addDesigneeTextField.text!)
            print(addChoreTextField.text)
            if delegateAndSource.designeeName != nil {
                designee = delegateAndSource.designeeName
                delegateAndSource.designeeName = nil
            } else {
                designee = listOfUsers[0]!.username
            }
            chore = Chore(choreName: addChoreTextField.text!, username: designee!)
            choreTable.backFromAddChoreView(chore)
            performSegueWithIdentifier("segueBackFromAdd", sender: saveButton)
        } else {
            let alertController = UIAlertController(title: "Invalid chore", message: "There's no chore to save!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Oops", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (addChoreTextField.text!.characters.count > 0){
            if (addDesigneeTextField.text!.characters.count == 0) {
                print("In here")
                let alertController = UIAlertController(title: "Invalid designee", message: "You need to assign a designee for this chore", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                chore = Chore(choreName: addChoreTextField.text!, username: addDesigneeTextField.text!)
            }
        }
    }*/
    

    
}
