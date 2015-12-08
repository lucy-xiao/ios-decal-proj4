//
//  LoginViewController.swift
//  ChoreIt
//
//  Created by Lucy Xiao on 12/6/15.
//  Copyright © 2015 Lucy Xiao. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    var user: User!
    //var allUsers: [User]?
    //temporary
    
    var allHouses: [String: [User]]?
    
    @IBOutlet var backgroundLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var houseCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundLabel.layer.backgroundColor  = UIColor(red: 55.0/255.0, green: 128.0/225.0, blue: 214.0/255.0, alpha: 1.0).CGColor
        backgroundLabel.layer.cornerRadius = 10
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (nameTextField.text!.characters.count > 0){
            if (houseCodeTextField.text!.characters.count == 0) {
                let alertController = UIAlertController(title: "Invalid house code", message: "You need your house's code to join its chore list.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Uh oh", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                user = User(username: nameTextField.text!)
                let bar = segue.destinationViewController as! UITabBarController
                let navForMyChore = bar.customizableViewControllers![0] as! UINavigationController
                let destMyChore = navForMyChore.topViewController as! MyChoreViewController
                
                let navForTableView = bar.customizableViewControllers![1] as! UINavigationController
                let choreTable = navForTableView.topViewController as! ChoreListTableViewController
                
                let navForHouseTableView = bar.customizableViewControllers![2] as! UINavigationController
                let houseMemberTable = navForHouseTableView.topViewController as! HouseTableViewController
                
                
                destMyChore.thisUser = user
                destMyChore.choreListTable = choreTable
                
                choreTable.thisUser = user
                choreTable.users = [user]
                
                choreTable.choreViewController = destMyChore
                houseMemberTable.choreListTable = choreTable
                
                destMyChore.tabBar = bar
                choreTable.tabBar = bar
                houseMemberTable.tabBar = bar
            }
            // later, add checking valid house codes
        } else {
            let alertController = UIAlertController(title: "Invalid name", message: "You need need a name!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Oops", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    


}
