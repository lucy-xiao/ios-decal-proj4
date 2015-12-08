//
//  AddHouseMemberTableViewController.swift
//  ChoreIt
//
//  Created by Lucy Xiao on 12/5/15.
//  Copyright © 2015 Lucy Xiao. All rights reserved.
//

import Foundation
import UIKit

class AddHouseMemberTableViewController: UITableViewController {
    var newMember: User?
    var choreTable: ChoreListTableViewController!
    var houseMemberTable: HouseTableViewController!
    
    @IBOutlet var addMemberTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            addMemberTextField.becomeFirstResponder()
        } /*else if indexPath.section == 0 && indexPath.row == 1 {
        addDesigneeTextField.becomeFirstResponder()
        }*/
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func pressedSaveButton() {
        print("Pressed Save Button")
        let name = addMemberTextField.text!
        if (name.characters.count > 0){
            var userExists = false
            
            for user in choreTable.users {
                if name == user!.username {
                    userExists = true
                }
            }
            if (userExists) {
                let alertController = UIAlertController(title: "Invalid name", message: "There's already someone with that name in this house!", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "😱", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                //chore = Chore(choreName: addChoreTextField.text!, username: addDesigneeTextField.text!)
                newMember = User(username: name)
                newMember!.userIndexRow = choreTable.users.count
                //choreTable.backFromAddMemberView(newMember)
                choreTable.users.append(newMember)
                houseMemberTable.tableView.reloadData()
                performSegueWithIdentifier("segueBackFromAddMember", sender: saveButton)
            }
        } else {
            let alertController = UIAlertController(title: "Invalid name", message: "Your new house member needs a name!", preferredStyle: UIAlertControllerStyle.Alert)
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

